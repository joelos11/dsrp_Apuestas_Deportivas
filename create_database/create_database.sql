-- Creación de la base de datos
CREATE DATABASE dsrp_apuestas_deportivas;
GO

USE dsrp_apuestas_deportivas;
GO

-- Usuarios
CREATE TABLE usuarios(
	id INT PRIMARY KEY IDENTITY(1, 1),
	numero_documento VARCHAR(15) UNIQUE NOT NULL,
	nombre VARCHAR(255) NOT NULL,
	apellido_paterno VARCHAR(255) NOT NULL,
	apellido_materno VARCHAR(255) NOT NULL,
	email VARCHAR(100) UNIQUE NOT NULL,
	contrasena VARCHAR(50) NOT NULL,
	saldo MONEY NOT NULL,
	fecha_registro DATE NOT NULL
);

-- Tipo de transacción
CREATE TABLE tipo_transaccion(
	id INT PRIMARY KEY IDENTITY(1, 1),
	nombre VARCHAR(100) NOT NULL,
	descripcion VARCHAR(500) NOT NULL
);

-- Transacción
CREATE TABLE transaccion(
	id INT PRIMARY KEY IDENTITY(1, 1),
	id_usuario INT NOT NULL,
	id_tipo_transaccion INT NOT NULL,
	monto_transaccion MONEY NOT NULL,
	fecha_transaccion DATETIME NOT NULL,
	CONSTRAINT FK_usuario_transaccion FOREIGN KEY(id_usuario) REFERENCES usuarios(id),
	CONSTRAINT FK_tipo_transaccion FOREIGN KEY(id_tipo_transaccion) REFERENCES tipo_transaccion(id)
);

-- Evento deportivo
CREATE TABLE evento_deportivo(
	id INT PRIMARY KEY IDENTITY(1, 1),
	nombre_evento VARCHAR(500) NOT NULL,
	deporte VARCHAR(255) NOT NULL
);

-- Partido
CREATE TABLE partido(
	id INT PRIMARY KEY IDENTITY(1, 1),
	id_evento INT NOT NULL,
	fecha_hora_partido DATETIME NOT NULL,
	equipo_local VARCHAR(255) NOT NULL,
	equipo_visitante VARCHAR(255) NOT NULL,
	marcador_local INT NOT NULL DEFAULT 0,
	marcador_visitante INT NOT NULL DEFAULT 0,
	estado_partido VARCHAR(100) NOT NULL,
	CONSTRAINT FK_evento_partido FOREIGN KEY(id_evento) REFERENCES evento_deportivo(id)
);

-- Tipo de apuesta
CREATE TABLE tipo_apuesta(
	id INT PRIMARY KEY IDENTITY(1, 1),
	tipo_apuesta VARCHAR(255) NOT NULL,
	descripcion_apuesta VARCHAR(255) NOT NULL);

-- Apuesta
CREATE TABLE apuestas(
	id INT PRIMARY KEY IDENTITY(1, 1),
	id_partido INT NOT NULL,
	id_transaccion INT NOT NULL,
	id_tipo_apuesta INT NOT NULL,
	resultado_apostado VARCHAR(255) NOT NULL,
	cuota FLOAT NOT NULL,
	estado_apuesta VARCHAR(100) NOT NULL,
	CONSTRAINT FK_partido_apuesta FOREIGN KEY(id_partido) REFERENCES partido(id),
	CONSTRAINT FK_transaccion_apuesta FOREIGN KEY(id_transaccion) REFERENCES transaccion(id),
	CONSTRAINT FK_tipo_apuesta FOREIGN KEY(id_tipo_apuesta) REFERENCES tipo_apuesta(id)
);