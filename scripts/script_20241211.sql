USE [master]
GO
/****** Object:  Database [dsrp_apuestas_deportivas]    Script Date: 11/12/2024 11:37:49 p. m. ******/
CREATE DATABASE [dsrp_apuestas_deportivas]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dsrp_apuestas_deportivas', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\dsrp_apuestas_deportivas.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dsrp_apuestas_deportivas_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\dsrp_apuestas_deportivas_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dsrp_apuestas_deportivas].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET ARITHABORT OFF 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET  ENABLE_BROKER 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET RECOVERY FULL 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET  MULTI_USER 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'dsrp_apuestas_deportivas', N'ON'
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET QUERY_STORE = ON
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [dsrp_apuestas_deportivas]
GO
/****** Object:  Table [dbo].[apuestas]    Script Date: 11/12/2024 11:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[apuestas](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_partido] [int] NOT NULL,
	[id_transaccion] [int] NOT NULL,
	[id_tipo_apuesta] [int] NOT NULL,
	[resultado_apostado] [varchar](255) NOT NULL,
	[cuota] [float] NOT NULL,
	[estado_apuesta] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[evento_deportivo]    Script Date: 11/12/2024 11:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[evento_deportivo](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre_evento] [varchar](500) NOT NULL,
	[deporte] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[partido]    Script Date: 11/12/2024 11:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[partido](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_evento] [int] NOT NULL,
	[fecha_hora_partido] [datetime] NOT NULL,
	[equipo_local] [varchar](255) NOT NULL,
	[equipo_visitante] [varchar](255) NOT NULL,
	[marcador_local] [int] NOT NULL,
	[marcador_visitante] [int] NOT NULL,
	[estado_partido] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipo_apuesta]    Script Date: 11/12/2024 11:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipo_apuesta](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[tipo_apuesta] [varchar](255) NOT NULL,
	[descripcion_apuesta] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tipo_transaccion]    Script Date: 11/12/2024 11:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tipo_transaccion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[nombre] [varchar](100) NOT NULL,
	[descripcion] [varchar](500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[transaccion]    Script Date: 11/12/2024 11:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[transaccion](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_usuario] [int] NOT NULL,
	[id_tipo_transaccion] [int] NOT NULL,
	[monto_transaccion] [money] NOT NULL,
	[fecha_transaccion] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[usuarios]    Script Date: 11/12/2024 11:37:49 p. m. ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[usuarios](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[numero_documento] [varchar](15) NOT NULL,
	[nombre] [varchar](255) NOT NULL,
	[apellido_paterno] [varchar](255) NOT NULL,
	[apellido_materno] [varchar](255) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[contrasena] [varchar](50) NOT NULL,
	[saldo] [money] NOT NULL,
	[fecha_registro] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[apuestas] ON 

INSERT [dbo].[apuestas] ([id], [id_partido], [id_transaccion], [id_tipo_apuesta], [resultado_apostado], [cuota], [estado_apuesta]) VALUES (31, 1, 3, 1, N'Real Madrid', 1.5, N'Ganada')
INSERT [dbo].[apuestas] ([id], [id_partido], [id_transaccion], [id_tipo_apuesta], [resultado_apostado], [cuota], [estado_apuesta]) VALUES (32, 2, 8, 2, N'Más de 1.5', 2, N'Perdida')
INSERT [dbo].[apuestas] ([id], [id_partido], [id_transaccion], [id_tipo_apuesta], [resultado_apostado], [cuota], [estado_apuesta]) VALUES (33, 3, 13, 3, N'Menos de 2.5', 1.8, N'Ganada')
INSERT [dbo].[apuestas] ([id], [id_partido], [id_transaccion], [id_tipo_apuesta], [resultado_apostado], [cuota], [estado_apuesta]) VALUES (34, 4, 18, 4, N'3', 3.5, N'Perdida')
INSERT [dbo].[apuestas] ([id], [id_partido], [id_transaccion], [id_tipo_apuesta], [resultado_apostado], [cuota], [estado_apuesta]) VALUES (35, 6, 23, 5, N'1', 4, N'Ganada')
INSERT [dbo].[apuestas] ([id], [id_partido], [id_transaccion], [id_tipo_apuesta], [resultado_apostado], [cuota], [estado_apuesta]) VALUES (36, 7, 28, 6, N'Más de 41', 2.5, N'Perdida')
INSERT [dbo].[apuestas] ([id], [id_partido], [id_transaccion], [id_tipo_apuesta], [resultado_apostado], [cuota], [estado_apuesta]) VALUES (37, 13, 8, 1, N'Lakers', 1.6, N'Ganada')
INSERT [dbo].[apuestas] ([id], [id_partido], [id_transaccion], [id_tipo_apuesta], [resultado_apostado], [cuota], [estado_apuesta]) VALUES (38, 15, 13, 2, N'Más de 2.5', 2.1, N'Perdida')
INSERT [dbo].[apuestas] ([id], [id_partido], [id_transaccion], [id_tipo_apuesta], [resultado_apostado], [cuota], [estado_apuesta]) VALUES (39, 15, 18, 3, N'Menos de 3.5', 1.9, N'Ganada')
INSERT [dbo].[apuestas] ([id], [id_partido], [id_transaccion], [id_tipo_apuesta], [resultado_apostado], [cuota], [estado_apuesta]) VALUES (40, 18, 18, 4, N'2', 3.2, N'Perdida')
INSERT [dbo].[apuestas] ([id], [id_partido], [id_transaccion], [id_tipo_apuesta], [resultado_apostado], [cuota], [estado_apuesta]) VALUES (41, 32, 28, 5, N'1', 4.5, N'Ganada')
INSERT [dbo].[apuestas] ([id], [id_partido], [id_transaccion], [id_tipo_apuesta], [resultado_apostado], [cuota], [estado_apuesta]) VALUES (42, 30, 23, 6, N'Menos de 4.5', 2.3, N'Perdida')
INSERT [dbo].[apuestas] ([id], [id_partido], [id_transaccion], [id_tipo_apuesta], [resultado_apostado], [cuota], [estado_apuesta]) VALUES (43, 33, 3, 1, N'Novak Djokovic', 1.4, N'Ganada')
INSERT [dbo].[apuestas] ([id], [id_partido], [id_transaccion], [id_tipo_apuesta], [resultado_apostado], [cuota], [estado_apuesta]) VALUES (44, 23, 3, 2, N'Más de 3.5', 2.2, N'Perdida')
INSERT [dbo].[apuestas] ([id], [id_partido], [id_transaccion], [id_tipo_apuesta], [resultado_apostado], [cuota], [estado_apuesta]) VALUES (45, 24, 28, 3, N'Menos de 1.5', 1.7, N'Ganada')
INSERT [dbo].[apuestas] ([id], [id_partido], [id_transaccion], [id_tipo_apuesta], [resultado_apostado], [cuota], [estado_apuesta]) VALUES (46, 16, 18, 4, N'1', 3.8, N'Perdida')
INSERT [dbo].[apuestas] ([id], [id_partido], [id_transaccion], [id_tipo_apuesta], [resultado_apostado], [cuota], [estado_apuesta]) VALUES (47, 31, 28, 5, N'2', 4.1, N'Ganada')
INSERT [dbo].[apuestas] ([id], [id_partido], [id_transaccion], [id_tipo_apuesta], [resultado_apostado], [cuota], [estado_apuesta]) VALUES (48, 28, 3, 6, N'Más de 5.5', 6.3, N'Ganada')
INSERT [dbo].[apuestas] ([id], [id_partido], [id_transaccion], [id_tipo_apuesta], [resultado_apostado], [cuota], [estado_apuesta]) VALUES (49, 20, 3, 1, N'Barcelona', 2.5, N'Ganada')
INSERT [dbo].[apuestas] ([id], [id_partido], [id_transaccion], [id_tipo_apuesta], [resultado_apostado], [cuota], [estado_apuesta]) VALUES (50, 17, 13, 2, N'Más de 2.5', 2, N'Perdida')
SET IDENTITY_INSERT [dbo].[apuestas] OFF
GO
SET IDENTITY_INSERT [dbo].[evento_deportivo] ON 

INSERT [dbo].[evento_deportivo] ([id], [nombre_evento], [deporte]) VALUES (1, N'UEFA Champions League', N'Fútbol')
INSERT [dbo].[evento_deportivo] ([id], [nombre_evento], [deporte]) VALUES (2, N'Premier League', N'Fútbol')
INSERT [dbo].[evento_deportivo] ([id], [nombre_evento], [deporte]) VALUES (3, N'Wimbledon', N'Tenis')
INSERT [dbo].[evento_deportivo] ([id], [nombre_evento], [deporte]) VALUES (4, N'NFL', N'Fútbol Americano')
INSERT [dbo].[evento_deportivo] ([id], [nombre_evento], [deporte]) VALUES (5, N'Copa Libertadores', N'Fútbol')
INSERT [dbo].[evento_deportivo] ([id], [nombre_evento], [deporte]) VALUES (6, N'MLB', N'Beisbol')
INSERT [dbo].[evento_deportivo] ([id], [nombre_evento], [deporte]) VALUES (7, N'NBA', N'Baloncesto')
INSERT [dbo].[evento_deportivo] ([id], [nombre_evento], [deporte]) VALUES (8, N'Copa Sudamericana', N'Fútbol')
INSERT [dbo].[evento_deportivo] ([id], [nombre_evento], [deporte]) VALUES (9, N'NHL', N'Hockey')
INSERT [dbo].[evento_deportivo] ([id], [nombre_evento], [deporte]) VALUES (10, N'Liga Endesa', N'Baloncesto')
INSERT [dbo].[evento_deportivo] ([id], [nombre_evento], [deporte]) VALUES (11, N'US Open', N'Tenis')
INSERT [dbo].[evento_deportivo] ([id], [nombre_evento], [deporte]) VALUES (12, N'Liga Santander', N'Futbol')
INSERT [dbo].[evento_deportivo] ([id], [nombre_evento], [deporte]) VALUES (13, N'Roland Garros', N'Tenis')
INSERT [dbo].[evento_deportivo] ([id], [nombre_evento], [deporte]) VALUES (14, N'Bundesliga', N'Fútbol')
INSERT [dbo].[evento_deportivo] ([id], [nombre_evento], [deporte]) VALUES (15, N'UEFA Europa League', N'Fútbol')
INSERT [dbo].[evento_deportivo] ([id], [nombre_evento], [deporte]) VALUES (16, N'Brasileirao', N'Fútbol')
INSERT [dbo].[evento_deportivo] ([id], [nombre_evento], [deporte]) VALUES (17, N'Australian Open', N'Tenis')
SET IDENTITY_INSERT [dbo].[evento_deportivo] OFF
GO
SET IDENTITY_INSERT [dbo].[partido] ON 

INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (1, 1, CAST(N'2024-01-01T20:00:00.000' AS DateTime), N'Real Madrid', N'Liverpool', 2, 1, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (2, 1, CAST(N'2024-01-02T20:00:00.000' AS DateTime), N'Barcelona', N'Chelsea', 1, 1, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (3, 2, CAST(N'2024-01-03T18:00:00.000' AS DateTime), N'Manchester United', N'Arsenal', 3, 2, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (4, 2, CAST(N'2024-01-04T18:00:00.000' AS DateTime), N'Liverpool', N'Manchester City', 2, 3, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (5, 3, CAST(N'2024-01-05T15:00:00.000' AS DateTime), N'Novak Djokovic', N'Rafael Nadal', 3, 2, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (6, 3, CAST(N'2024-01-06T15:00:00.000' AS DateTime), N'Serena Williams', N'Simona Halep', 2, 1, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (7, 4, CAST(N'2024-01-07T09:00:00.000' AS DateTime), N'San Franciso 49ers', N'Miami Dolphins', 27, 13, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (8, 4, CAST(N'2024-01-08T09:00:00.000' AS DateTime), N'Kansas City Chiefs', N'Tampa Bay Buccaneers', 32, 10, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (9, 5, CAST(N'2024-01-09T20:00:00.000' AS DateTime), N'Boca Juniors', N'River Plate', 1, 1, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (10, 5, CAST(N'2024-01-10T20:00:00.000' AS DateTime), N'Flamengo', N'Palmeiras', 2, 2, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (11, 6, CAST(N'2024-01-11T19:00:00.000' AS DateTime), N'Yankees', N'Red Sox', 5, 4, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (12, 6, CAST(N'2024-01-12T19:00:00.000' AS DateTime), N'Dodgers', N'Giants', 3, 3, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (13, 7, CAST(N'2024-01-13T21:00:00.000' AS DateTime), N'Lakers', N'Warriors', 110, 105, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (14, 7, CAST(N'2024-01-14T21:00:00.000' AS DateTime), N'Bulls', N'Celtics', 98, 99, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (15, 8, CAST(N'2024-01-15T20:00:00.000' AS DateTime), N'Independiente', N'Atlético Nacional', 1, 0, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (16, 8, CAST(N'2024-01-16T20:00:00.000' AS DateTime), N'Peñarol', N'Cerro Porteño', 2, 1, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (17, 9, CAST(N'2024-01-17T14:00:00.000' AS DateTime), N'Detroit Red Wings', N'Washington Capitals', 1, 4, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (18, 9, CAST(N'2024-01-18T14:00:00.000' AS DateTime), N'Florida Panthers', N'Boston Bruins', 3, 4, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (19, 10, CAST(N'2024-01-19T09:00:00.000' AS DateTime), N'Unicaja', N'Real Madrid', 86, 74, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (20, 10, CAST(N'2024-01-20T09:00:00.000' AS DateTime), N'Valencia Basket', N'Barcelona', 90, 93, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (21, 11, CAST(N'2024-01-21T15:00:00.000' AS DateTime), N'Novak Djokovic', N'Rafael Nadal', 3, 2, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (22, 11, CAST(N'2024-01-22T15:00:00.000' AS DateTime), N'Serena Williams', N'Simona Halep', 2, 1, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (23, 12, CAST(N'2024-01-23T20:00:00.000' AS DateTime), N'Real Madrid', N'Barcelona', 2, 1, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (24, 12, CAST(N'2024-01-24T20:00:00.000' AS DateTime), N'Atletico Madrid', N'Sevilla', 1, 1, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (25, 13, CAST(N'2024-01-25T15:00:00.000' AS DateTime), N'Novak Djokovic', N'Rafael Nadal', 3, 2, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (26, 13, CAST(N'2024-01-26T15:00:00.000' AS DateTime), N'Serena Williams', N'Simona Halep', 2, 1, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (27, 14, CAST(N'2024-01-27T14:00:00.000' AS DateTime), N'Bayern Munich', N'Stuttgart', 4, 2, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (28, 14, CAST(N'2024-01-28T14:00:00.000' AS DateTime), N'Bayer Leverkusen', N'Borussia Dortmund', 3, 3, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (29, 15, CAST(N'2024-01-29T20:00:00.000' AS DateTime), N'Manchester United', N'Arsenal', 3, 2, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (30, 15, CAST(N'2024-01-30T20:00:00.000' AS DateTime), N'Liverpool', N'Manchester City', 2, 3, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (31, 16, CAST(N'2024-01-31T20:00:00.000' AS DateTime), N'Flamengo', N'Palmeiras', 2, 2, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (32, 16, CAST(N'2024-02-01T20:00:00.000' AS DateTime), N'Santos', N'Corinthians', 1, 1, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (33, 17, CAST(N'2024-02-02T15:00:00.000' AS DateTime), N'Novak Djokovic', N'Rafael Nadal', 3, 2, N'Finalizado')
INSERT [dbo].[partido] ([id], [id_evento], [fecha_hora_partido], [equipo_local], [equipo_visitante], [marcador_local], [marcador_visitante], [estado_partido]) VALUES (34, 17, CAST(N'2024-02-03T15:00:00.000' AS DateTime), N'Serena Williams', N'Simona Halep', 2, 1, N'Finalizado')
SET IDENTITY_INSERT [dbo].[partido] OFF
GO
SET IDENTITY_INSERT [dbo].[tipo_apuesta] ON 

INSERT [dbo].[tipo_apuesta] ([id], [tipo_apuesta], [descripcion_apuesta]) VALUES (1, N'Resultado partido', N'Apuesta por el ganador o por el empate del partido')
INSERT [dbo].[tipo_apuesta] ([id], [tipo_apuesta], [descripcion_apuesta]) VALUES (2, N'Marcador local', N'Si el marcador del local es mayor o menor al indicado. Ejemplo (+1.5)')
INSERT [dbo].[tipo_apuesta] ([id], [tipo_apuesta], [descripcion_apuesta]) VALUES (3, N'Marcador visitante', N'Si el marcador del visitante es mayor o menor al indicado. Ejemplo (-1.5)')
INSERT [dbo].[tipo_apuesta] ([id], [tipo_apuesta], [descripcion_apuesta]) VALUES (4, N'Marcador exacto local', N'Si el marcador del local es igual al indicado. Ejemplo (3)')
INSERT [dbo].[tipo_apuesta] ([id], [tipo_apuesta], [descripcion_apuesta]) VALUES (5, N'Marcador exacto visitante', N'Si el marcador del visitante es igual al indicado. Ejemplo (0)')
INSERT [dbo].[tipo_apuesta] ([id], [tipo_apuesta], [descripcion_apuesta]) VALUES (6, N'Marcador total partido', N'Si la suma de los marcadores de los equipos es mayor o menor al indicado. Ejemplo (+4.5)')
SET IDENTITY_INSERT [dbo].[tipo_apuesta] OFF
GO
SET IDENTITY_INSERT [dbo].[tipo_transaccion] ON 

INSERT [dbo].[tipo_transaccion] ([id], [nombre], [descripcion]) VALUES (1, N'Depósito', N'Ingreso de dinero en la cuenta')
INSERT [dbo].[tipo_transaccion] ([id], [nombre], [descripcion]) VALUES (2, N'Retiro', N'Retiro de dinero de la cuenta')
INSERT [dbo].[tipo_transaccion] ([id], [nombre], [descripcion]) VALUES (3, N'Apuesta', N'Monto apostado en un evento deportivo')
INSERT [dbo].[tipo_transaccion] ([id], [nombre], [descripcion]) VALUES (4, N'Ganancia', N'Ganancias obtenidas de una apuesta ganada')
INSERT [dbo].[tipo_transaccion] ([id], [nombre], [descripcion]) VALUES (5, N'Bono', N'Adición de un bono promocional al saldo del usuario')
SET IDENTITY_INSERT [dbo].[tipo_transaccion] OFF
GO
SET IDENTITY_INSERT [dbo].[transaccion] ON 

INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (1, 23, 1, 1000.0000, CAST(N'2024-10-01T10:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (2, 20, 2, 500.0000, CAST(N'2024-12-02T11:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (3, 17, 3, 200.0000, CAST(N'2024-08-03T12:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (4, 12, 4, 300.0000, CAST(N'2024-05-04T13:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (5, 9, 5, 50.0000, CAST(N'2024-07-05T14:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (6, 10, 1, 1500.0000, CAST(N'2024-02-06T15:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (7, 2, 2, 700.0000, CAST(N'2024-01-07T16:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (8, 5, 3, 250.0000, CAST(N'2024-01-08T17:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (9, 29, 4, 350.0000, CAST(N'2024-12-09T18:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (10, 15, 5, 75.0000, CAST(N'2024-11-10T19:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (11, 8, 1, 2000.0000, CAST(N'2024-03-11T20:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (12, 12, 2, 800.0000, CAST(N'2024-08-12T21:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (13, 16, 3, 300.0000, CAST(N'2024-09-13T22:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (14, 24, 4, 400.0000, CAST(N'2024-11-14T23:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (15, 5, 5, 100.0000, CAST(N'2024-01-15T09:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (16, 1, 1, 2500.0000, CAST(N'2024-01-16T08:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (17, 22, 2, 900.0000, CAST(N'2024-11-17T07:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (18, 13, 3, 350.0000, CAST(N'2024-07-18T06:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (19, 19, 4, 450.0000, CAST(N'2024-09-19T05:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (20, 23, 5, 125.0000, CAST(N'2024-10-20T04:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (21, 21, 1, 3000.0000, CAST(N'2024-11-21T03:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (22, 27, 2, 1000.0000, CAST(N'2024-11-22T02:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (23, 3, 3, 400.0000, CAST(N'2024-01-23T01:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (24, 4, 4, 500.0000, CAST(N'2024-01-24T00:00:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (25, 7, 5, 150.0000, CAST(N'2024-03-25T23:59:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (26, 16, 1, 3500.0000, CAST(N'2024-09-26T22:58:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (27, 22, 2, 1100.0000, CAST(N'2024-11-27T21:57:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (28, 17, 3, 450.0000, CAST(N'2024-08-28T20:56:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (29, 26, 4, 550.0000, CAST(N'2024-11-29T19:55:00.000' AS DateTime))
INSERT [dbo].[transaccion] ([id], [id_usuario], [id_tipo_transaccion], [monto_transaccion], [fecha_transaccion]) VALUES (30, 1, 5, 175.0000, CAST(N'2024-01-30T18:54:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[transaccion] OFF
GO
SET IDENTITY_INSERT [dbo].[usuarios] ON 

INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (1, N'1234567890', N'Juan', N'Pérez', N'Gómez', N'juan.perez1@example.com', N'password123', 1000.0000, CAST(N'2023-01-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (2, N'1234567891', N'María', N'López', N'Martínez', N'maria.lopez1@example.com', N'password456', 1500.0000, CAST(N'2023-02-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (3, N'1234567892', N'Carlos', N'García', N'Fernández', N'carlos.garcia1@example.com', N'password789', 2000.0000, CAST(N'2023-03-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (4, N'1234567893', N'Ana', N'Rodríguez', N'Sánchez', N'ana.rodriguez1@example.com', N'password101', 2500.0000, CAST(N'2023-04-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (5, N'1234567894', N'Luis', N'Martínez', N'Pérez', N'luis.martinez1@example.com', N'password102', 3000.0000, CAST(N'2023-05-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (6, N'1234567895', N'Elena', N'Hernández', N'Gómez', N'elena.hernandez1@example.com', N'password103', 3500.0000, CAST(N'2023-06-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (7, N'1234567896', N'Miguel', N'González', N'López', N'miguel.gonzalez1@example.com', N'password104', 4000.0000, CAST(N'2023-07-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (8, N'1234567897', N'Laura', N'Díaz', N'Martínez', N'laura.diaz1@example.com', N'password105', 4500.0000, CAST(N'2023-08-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (9, N'1234567898', N'Jorge', N'Pérez', N'García', N'jorge.perez1@example.com', N'password106', 5000.0000, CAST(N'2023-09-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (10, N'1234567899', N'Sofía', N'López', N'Rodríguez', N'sofia.lopez1@example.com', N'password107', 5500.0000, CAST(N'2023-10-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (11, N'1234567800', N'David', N'García', N'Martínez', N'david.garcia1@example.com', N'password108', 6000.0000, CAST(N'2023-11-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (12, N'1234567801', N'Lucía', N'Rodríguez', N'Hernández', N'lucia.rodriguez1@example.com', N'password109', 6500.0000, CAST(N'2023-12-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (13, N'1234567802', N'Pedro', N'Martínez', N'González', N'pedro.martinez1@example.com', N'password110', 7000.0000, CAST(N'2024-01-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (14, N'1234567803', N'Carmen', N'Hernández', N'Díaz', N'carmen.hernandez1@example.com', N'password111', 7500.0000, CAST(N'2024-02-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (15, N'1234567804', N'José', N'González', N'Pérez', N'jose.gonzalez1@example.com', N'password112', 8000.0000, CAST(N'2024-03-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (16, N'1234567805', N'Isabel', N'Díaz', N'López', N'isabel.diaz1@example.com', N'password113', 8500.0000, CAST(N'2024-04-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (17, N'1234567806', N'Antonio', N'Pérez', N'García', N'antonio.perez1@example.com', N'password114', 9000.0000, CAST(N'2024-05-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (18, N'1234567807', N'Marta', N'López', N'Rodríguez', N'marta.lopez1@example.com', N'password115', 9500.0000, CAST(N'2024-06-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (19, N'1234567808', N'Francisco', N'García', N'Martínez', N'francisco.garcia1@example.com', N'password116', 10000.0000, CAST(N'2024-07-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (20, N'1234567809', N'Teresa', N'Rodríguez', N'Hernández', N'teresa.rodriguez1@example.com', N'password117', 10500.0000, CAST(N'2024-08-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (21, N'1234567810', N'Raúl', N'Martínez', N'González', N'raul.martinez1@example.com', N'password118', 11000.0000, CAST(N'2024-09-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (22, N'1234567811', N'Patricia', N'Hernández', N'Díaz', N'patricia.hernandez1@example.com', N'password119', 11500.0000, CAST(N'2024-10-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (23, N'1234567812', N'Alberto', N'González', N'Pérez', N'alberto.gonzalez1@example.com', N'password120', 12000.0000, CAST(N'2024-11-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (24, N'1234567813', N'Rosa', N'Díaz', N'López', N'rosa.diaz1@example.com', N'password121', 12500.0000, CAST(N'2024-12-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (25, N'1234567814', N'Fernando', N'Pérez', N'García', N'fernando.perez1@example.com', N'password122', 13000.0000, CAST(N'2024-01-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (26, N'1234567815', N'Gloria', N'López', N'Rodríguez', N'gloria.lopez1@example.com', N'password123', 13500.0000, CAST(N'2024-02-15' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (27, N'1234567816', N'Ricardo', N'García', N'Martínez', N'ricardo.garcia1@example.com', N'password124', 14000.0000, CAST(N'2024-07-01' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (28, N'1234567817', N'Beatriz', N'Rodríguez', N'Hernández', N'beatriz.rodriguez1@example.com', N'password125', 14500.0000, CAST(N'2024-01-30' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (29, N'1234567818', N'Manuel', N'Martínez', N'González', N'manuel.martinez1@example.com', N'password126', 15000.0000, CAST(N'2024-05-18' AS Date))
INSERT [dbo].[usuarios] ([id], [numero_documento], [nombre], [apellido_paterno], [apellido_materno], [email], [contrasena], [saldo], [fecha_registro]) VALUES (30, N'1234567819', N'Clara', N'Hernández', N'Díaz', N'clara.hernandez1@example.com', N'password127', 15500.0000, CAST(N'2024-06-10' AS Date))
SET IDENTITY_INSERT [dbo].[usuarios] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__usuarios__7B886A63B95E3364]    Script Date: 11/12/2024 11:37:49 p. m. ******/
ALTER TABLE [dbo].[usuarios] ADD UNIQUE NONCLUSTERED 
(
	[numero_documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__usuarios__AB6E6164864F0DAC]    Script Date: 11/12/2024 11:37:49 p. m. ******/
ALTER TABLE [dbo].[usuarios] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[partido] ADD  DEFAULT ((0)) FOR [marcador_local]
GO
ALTER TABLE [dbo].[partido] ADD  DEFAULT ((0)) FOR [marcador_visitante]
GO
ALTER TABLE [dbo].[apuestas]  WITH CHECK ADD  CONSTRAINT [FK_partido_apuesta] FOREIGN KEY([id_partido])
REFERENCES [dbo].[partido] ([id])
GO
ALTER TABLE [dbo].[apuestas] CHECK CONSTRAINT [FK_partido_apuesta]
GO
ALTER TABLE [dbo].[apuestas]  WITH CHECK ADD  CONSTRAINT [FK_tipo_apuesta] FOREIGN KEY([id_tipo_apuesta])
REFERENCES [dbo].[tipo_apuesta] ([id])
GO
ALTER TABLE [dbo].[apuestas] CHECK CONSTRAINT [FK_tipo_apuesta]
GO
ALTER TABLE [dbo].[apuestas]  WITH CHECK ADD  CONSTRAINT [FK_transaccion_apuesta] FOREIGN KEY([id_transaccion])
REFERENCES [dbo].[transaccion] ([id])
GO
ALTER TABLE [dbo].[apuestas] CHECK CONSTRAINT [FK_transaccion_apuesta]
GO
ALTER TABLE [dbo].[partido]  WITH CHECK ADD  CONSTRAINT [FK_evento_partido] FOREIGN KEY([id_evento])
REFERENCES [dbo].[evento_deportivo] ([id])
GO
ALTER TABLE [dbo].[partido] CHECK CONSTRAINT [FK_evento_partido]
GO
ALTER TABLE [dbo].[transaccion]  WITH CHECK ADD  CONSTRAINT [FK_tipo_transaccion] FOREIGN KEY([id_tipo_transaccion])
REFERENCES [dbo].[tipo_transaccion] ([id])
GO
ALTER TABLE [dbo].[transaccion] CHECK CONSTRAINT [FK_tipo_transaccion]
GO
ALTER TABLE [dbo].[transaccion]  WITH CHECK ADD  CONSTRAINT [FK_usuario_transaccion] FOREIGN KEY([id_usuario])
REFERENCES [dbo].[usuarios] ([id])
GO
ALTER TABLE [dbo].[transaccion] CHECK CONSTRAINT [FK_usuario_transaccion]
GO
USE [master]
GO
ALTER DATABASE [dsrp_apuestas_deportivas] SET  READ_WRITE 
GO
