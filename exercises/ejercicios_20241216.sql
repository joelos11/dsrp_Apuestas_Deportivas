USE dsrp_apuestas_deportivas;

/*
EJERCICIOS NIVEL INTERMEDIO

Consulta de usuarios activos:

Obtén una lista de usuarios que realizaron al menos una apuesta en el último mes, mostrando su nombre, correo electrónico y cantidad de apuestas realizadas.
*/
SELECT CONCAT(u.nombre, ' ', u.apellido_paterno, ' ', u.apellido_materno) AS 'nombre_usuarios',
	   u.email,
	   COUNT(t.id_usuario) AS 'cantidad_apuestas'
FROM transaccion t
INNER JOIN usuarios u ON u.id = t.id_usuario
WHERE fecha_transaccion > DATEADD(MONTH, -1, GETDATE()) AND id_tipo_transaccion = 3
GROUP BY u.nombre, u.apellido_paterno, u.apellido_materno, u.email;
/*
Consulta de apuestas ganadas por usuario:

Crea una consulta que liste los usuarios que han ganado apuestas en los últimos 6 meses.
Muestra su nombre, la cantidad de apuestas ganadas y la suma total de sus ganancias.
*/
SELECT CONCAT(u.nombre, ' ', u.apellido_paterno, ' ', u.apellido_materno) AS nombre_usuario,
	   COALESCE(COUNT(t.id_usuario), 0) AS cantidad_apuestas_ganadas,
	   COALESCE(t2.monto_transaccion, 0) AS ganancia_total
FROM usuarios u
INNER JOIN transaccion t ON u.id = t.id_usuario AND t.id_tipo_transaccion = 4
LEFT JOIN apuestas a ON a.id_transaccion = t.id
LEFT JOIN (SELECT id_usuario, SUM(monto_transaccion) AS monto_transaccion 
		   FROM transaccion WHERE id_tipo_transaccion = 4
		   GROUP BY id_usuario) t2 ON t2.id_usuario = u.id
WHERE t.fecha_transaccion > DATEADD(MONTH, -6, GETDATE())
GROUP BY u.id, u.email, u.nombre, u.apellido_paterno, u.apellido_materno, t2.monto_transaccion
ORDER BY u.id;
/*
Consulta de ranking de apuestas por deporte:

Muestra el ranking de los deportes en los que más se han realizado apuestas.
Devuelve el nombre del deporte y la cantidad total de apuestas realizadas.
*/
SELECT DISTINCT ed.deporte,
	   COUNT(ed.deporte) AS cantidad_apuestas_realizadas
FROM evento_deportivo ed
INNER JOIN partido p ON p.id_evento = ed.id
INNER JOIN apuestas a ON a.id_partido = p.id
GROUP BY ed.deporte;
/*
Vista de resumen de usuarios activos:

Crea una vista llamada vw_resumen_usuarios que muestre para cada usuario:
Nombre
Correo electrónico
Total de apuestas realizadas
Total de apuestas ganadas
Total de ganancias
*/
CREATE VIEW VW_JL_resumen_usuarios
AS
SELECT u.id, 
	   CONCAT(u.nombre, ' ', u.apellido_paterno, ' ', u.apellido_materno) AS nombre_usuario,
	   u.email,
	   COALESCE(COUNT(CASE
							WHEN t.id_tipo_transaccion = 3 THEN t.id_usuario
				      END), 0) AS cantidad_apuestas_realizadas,
	   COALESCE(COUNT(CASE
							WHEN t.id_tipo_transaccion = 4 THEN t.id_usuario
				      END), 0) AS cantidad_apuestas_ganadas,
	   COALESCE(t2.monto_transaccion, 0) AS ganancia_total
FROM usuarios u
LEFT JOIN transaccion t ON u.id = t.id_usuario AND t.id_tipo_transaccion IN (3, 4)
LEFT JOIN apuestas a ON a.id_transaccion = t.id
LEFT JOIN (SELECT id_usuario, SUM(monto_transaccion) AS monto_transaccion 
		   FROM transaccion WHERE id_tipo_transaccion = 4
		   GROUP BY id_usuario) t2 ON t2.id_usuario = u.id
GROUP BY u.id, u.email, u.nombre, u.apellido_paterno, u.apellido_materno, t2.monto_transaccion;
GO
/*
Vista de historial de apuestas:

Crea una vista llamada vw_historial_apuestas que muestre todas las apuestas de los últimos 30 días.
Incluye:
Nombre del usuario
Nombre del evento deportivo
Cantidad apostada
Cuota de la apuesta
Fecha de la apuesta
*/
CREATE VIEW JW_JL_historial_apuestas
AS
SELECT u.id, 
	   CONCAT(u.nombre, ' ', u.apellido_paterno, ' ', u.apellido_materno) AS nombre_usuario,
	   ed.nombre_evento,
	   p.equipo_local,
	   p.equipo_visitante,
	   t.monto_transaccion,
	   a.cuota,
	   t.fecha_transaccion
FROM transaccion t
INNER JOIN usuarios u ON u.id = t.id_usuario
LEFT JOIN apuestas a ON a.id_transaccion = t.id
LEFT JOIN partido p ON p.id = a.id_partido
LEFT JOIN evento_deportivo ed ON ed.id = p.id_evento
WHERE t.fecha_transaccion > DATEADD(MONTH, -1, GETDATE()) AND id_tipo_transaccion = 3;
GO
/*
Procedimiento almacenado de registrar una nueva apuesta:

Crea un procedimiento almacenado sp_registrar_apuesta que permita registrar una nueva apuesta.
Parámetros de entrada:
ID del usuario
ID del partido
Monto de la apuesta
Tipo de apuesta
Resultado apostado
Cuota de la apuesta
Valida que:
El partido esté abierto.
El usuario tenga saldo suficiente (suponiendo que haya una tabla de saldos de usuarios).
*/
SELECT * FROM apuestas;
SELECT * FROM transaccion;

CREATE PROCEDURE SP_JL_registrar_apuesta
	@id_usuario INT,
	@id_partido INT,
	@monto_apostado MONEY,
	@id_tipo_apuesta INT,
	@resultado_apostado VARCHAR(255),
	@cuota FLOAT
AS
	SET NOCOUNT ON;
	
BEGIN 
	BEGIN TRANSACTION;

	BEGIN TRY
		--Validación del usuario
		IF NOT EXISTS (SELECT 1 FROM usuarios WHERE id = @id_usuario) 
		BEGIN
			RAISERROR('El usuario no existe', 16, 1);
			RETURN;
		END

		--Validación del partido
		IF NOT EXISTS (SELECT 1 FROM partido WHERE id = @id_partido)
		BEGIN
			RAISERROR('El partido no existe', 16, 1);
			RETURN;
		END;
		IF (SELECT estado_partido FROM partido WHERE id = @id_partido) != 'Abierto'
		BEGIN
			RAISERROR('El partido no está disponible', 16, 1);
			RETURN;
		END;

		--Validación del monto
		IF @monto_apostado > (SELECT saldo FROM usuarios WHERE id = @id_usuario)
		BEGIN
			RAISERROR('Saldo Insuficiente', 16, 1);
			RETURN;
		END;
		IF @monto_apostado <= 0 
		BEGIN
			RAISERROR('El monto debe ser mayor a 0', 16, 1);
			RETURN;
		END

		--Insertamos la transaccion
		INSERT INTO [dbo].[transaccion] ([id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion])
		VALUES (@id_usuario, 3, @monto_apostado, GETDATE());

		--Insertamos la apuesta
		INSERT INTO [dbo].[apuestas] ([id_partido], [id_transaccion], [id_tipo_apuesta], [resultado_apostado], [cuota], [estado_apuesta])
		VALUES (@id_partido, SCOPE_IDENTITY(), @id_tipo_apuesta, @resultado_apostado, @cuota, 'En curso');
		
		UPDATE usuarios
		SET saldo = saldo - @monto_apostado
		WHERE id = @id_usuario;

		--Confirmamos la transacción
		COMMIT TRANSACTION;
	END TRY

	BEGIN CATCH
        -- Captura de errores y deshacer la transacción
        ROLLBACK TRANSACTION;

        -- Obtener información del error
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(), 
            @ErrorSeverity = ERROR_SEVERITY(), 
            @ErrorState = ERROR_STATE();

        -- Lanza el error capturado
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END

EXEC SP_JL_registrar_apuesta 22, 36, 1500.00, 1, 'Cruzeiro', 3.0;
/*
Procedimiento almacenado que actualice un partido (mejorar para que actualice las apuestas cuando el estado sea Finalizado):

Crea un procedimiento sp_actualizar_partido para actualizar un partido una vez que ha finalizado o se ha cerrado la apuesta o un equipo ha puntuado.
Parámetro de entrada:
ID del partido
Marcador local
Marcador visitante
Estado del partido
Este procedimiento debe cambiar el estado de abierto a cerrado o a finalizado.
*/
CREATE PROCEDURE SP_JL_actualizar_partido
	@id_partido INT,
	@marcador_local INT,
	@marcador_visitante INT,
	@estado_partido VARCHAR(100)
AS
	SET NOCOUNT ON;

BEGIN
	BEGIN TRANSACTION;

	BEGIN TRY
		--Validación del partido
		IF NOT EXISTS (SELECT 1 FROM partido WHERE id = @id_partido)
		BEGIN
			RAISERROR('El partido no existe', 16, 1);
			RETURN;
		END;
		IF (SELECT estado_partido FROM partido WHERE id = @id_partido) = 'Finalizado'
		BEGIN
			RAISERROR('El partido ya ha finalizado', 16, 1);
			RETURN;
		END;

		--Validación de los marcadores
		IF @marcador_local < 0 OR @marcador_visitante <0 
		BEGIN
			RAISERROR('Los marcadores deben ser mayores a 0', 16, 1);
			RETURN;
		END

		--Validación del estado del partido
		IF @estado_partido NOT IN('Abierto', 'Cerrado', 'Finalizado')
		BEGIN
			RAISERROR('No es un estado de partido.
					   Los posibles estados del partido son:
						- Abierto.
						- Cerrado.
						- Finalizado.', 16, 1);
			RETURN;
		END;

		UPDATE partido 
		SET marcador_local = @marcador_local,
			marcador_visitante = @marcador_visitante,
			estado_partido = @estado_partido
		WHERE id = @id_partido			

		--Confirmamos la transacción
		COMMIT TRANSACTION;
	END TRY

	BEGIN CATCH
        -- Captura de errores y deshacer la transacción
        ROLLBACK TRANSACTION;

        -- Obtener información del error
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(), 
            @ErrorSeverity = ERROR_SEVERITY(), 
            @ErrorState = ERROR_STATE();

        -- Lanza el error capturado
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO

EXEC SP_JL_actualizar_partido 37, 0, 0, 'Abierto'; 
/*
Procedimiento almacenado de reporte de ganancias:

Crea un procedimiento sp_reporte_ganancias que devuelva el total de ganancias de la casa de apuestas por cada evento.
Muestra el nombre del evento, la cantidad total apostada por los usuarios y la cantidad ganada por la casa de apuestas.
*/
CREATE PROCEDURE SP_JL_reporte_ganacias
	@id_evento_deportivo INT
AS
	SET NOCOUNT ON;

BEGIN
	BEGIN TRANSACTION;

	BEGIN TRY
		--Validación del partido
		IF NOT EXISTS (SELECT 1 FROM evento_deportivo WHERE id = @id_evento_deportivo)
		BEGIN
			RAISERROR('El evento deportivo no existe', 16, 1);
			RETURN;
		END;

		SELECT ted.nombre_evento, ted.deporte, ted.cantidad_total_apostada, ted.total_ganancias_casa_apuestas 
		FROM   (SELECT ed.id,
					   ed.nombre_evento,
					   ed.deporte,
					   SUM(t.monto_transaccion) AS cantidad_total_apostada,
					   total_ganancias_casa_apuestas 
				FROM evento_deportivo ed
				LEFT JOIN partido p ON p.id_evento = ed.id
				LEFT JOIN apuestas a ON a.id_partido = p.id
				LEFT JOIN transaccion t ON t.id = a.id_transaccion AND t.id_tipo_transaccion = 3
				LEFT JOIN (SELECT ed.id, SUM(t.monto_transaccion) as total_ganancias_casa_apuestas
						   FROM apuestas a
						   LEFT JOIN transaccion t ON t.id = a.id_transaccion
						   LEFT JOIN partido p ON p.id = a.id_partido
						   LEFT JOIN evento_deportivo ed ON ed.id = p.id_evento
						   WHERE id_transaccion IN (SELECT DISTINCT t.id FROM transaccion t
			   										LEFT JOIN apuestas a ON a.id_transaccion = t.id AND t.id_tipo_transaccion = 3
													WHERE estado_apuesta = 'Perdida')
						   GROUP BY ed.id) a2 ON a2.id = ed.id 
				GROUP BY ed.id, ed.nombre_evento, ed.deporte, total_ganancias_casa_apuestas) AS ted
		WHERE ted.id = @id_evento_deportivo;

		--Confirmamos la transacción
		COMMIT TRANSACTION;
	END TRY

	BEGIN CATCH
        -- Captura de errores y deshacer la transacción
        ROLLBACK TRANSACTION;

        -- Obtener información del error
        DECLARE @ErrorMessage NVARCHAR(4000);
        DECLARE @ErrorSeverity INT;
        DECLARE @ErrorState INT;

        SELECT 
            @ErrorMessage = ERROR_MESSAGE(), 
            @ErrorSeverity = ERROR_SEVERITY(), 
            @ErrorState = ERROR_STATE();

        -- Lanza el error capturado
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END
GO

EXEC SP_JL_reporte_ganacias 1;
/*
Función para verificar saldo suficiente:

Crea una función fn_verificar_saldo que reciba el ID de usuario y el monto a apostar.
Devuelve 1 si el usuario tiene saldo suficiente y 0 en caso contrario.
*/
CREATE FUNCTION FN_JL_verificar_saldo(@id_usuario INT,
									 @monto_apostado MONEY)
RETURNS TABLE
AS
RETURN(
		SELECT 
				CASE
					WHEN @monto_apostado <= saldo THEN 1
					ELSE 0
				END AS saldo_suficiente
		FROM usuarios
		WHERE id = @id_usuario
		);

SELECT saldo_suficiente FROM FN_JL_verificar_saldo(5, 5000.00);