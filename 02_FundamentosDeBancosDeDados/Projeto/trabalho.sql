USE [master]
GO
/****** Object:  Database [trabalho]    Script Date: 14/05/2025 14:28:13 ******/
CREATE DATABASE [trabalho]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'trabalho', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\trabalho.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'trabalho_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\trabalho_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [trabalho] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [trabalho].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [trabalho] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [trabalho] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [trabalho] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [trabalho] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [trabalho] SET ARITHABORT OFF 
GO
ALTER DATABASE [trabalho] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [trabalho] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [trabalho] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [trabalho] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [trabalho] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [trabalho] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [trabalho] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [trabalho] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [trabalho] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [trabalho] SET  ENABLE_BROKER 
GO
ALTER DATABASE [trabalho] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [trabalho] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [trabalho] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [trabalho] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [trabalho] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [trabalho] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [trabalho] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [trabalho] SET RECOVERY FULL 
GO
ALTER DATABASE [trabalho] SET  MULTI_USER 
GO
ALTER DATABASE [trabalho] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [trabalho] SET DB_CHAINING OFF 
GO
ALTER DATABASE [trabalho] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [trabalho] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [trabalho] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [trabalho] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'trabalho', N'ON'
GO
ALTER DATABASE [trabalho] SET QUERY_STORE = ON
GO
ALTER DATABASE [trabalho] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [trabalho]
GO
/****** Object:  Table [dbo].[CARGA]    Script Date: 14/05/2025 14:28:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CARGA](
	[IDCARGA] [int] IDENTITY(1,1) NOT NULL,
	[IDPORTO_DESTINO] [int] NULL,
	[IDPORTO_ORIGEM] [int] NULL,
	[IDAGENTE] [int] NULL,
	[IDNAVIO] [int] NULL,
	[PESO] [decimal](10, 2) NULL,
	[DATAEMBARQUE] [datetime] NULL,
	[MAXDATA_EMBARQUE] [datetime] NULL,
	[TIPO_CARGA] [varchar](10) NULL,
	[DATAVALIDADE] [datetime] NULL,
	[MAXTEMPERATURA] [decimal](5, 2) NULL,
 CONSTRAINT [PK_CARGA] PRIMARY KEY CLUSTERED 
(
	[IDCARGA] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NAVIO]    Script Date: 14/05/2025 14:28:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NAVIO](
	[IDNAVIO] [int] IDENTITY(1,1) NOT NULL,
	[NOMENAVIO] [varchar](50) NULL,
	[CAPACIDADETOTAL] [decimal](12, 2) NULL,
 CONSTRAINT [PK_NAVIO] PRIMARY KEY CLUSTERED 
(
	[IDNAVIO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PORTO]    Script Date: 14/05/2025 14:28:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PORTO](
	[IDPORTO] [int] IDENTITY(1,1) NOT NULL,
	[NOMEPORTO] [varchar](30) NULL,
	[LOCALIZACAO] [varchar](50) NULL,
 CONSTRAINT [PK_PORTO] PRIMARY KEY CLUSTERED 
(
	[IDPORTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ROTA]    Script Date: 14/05/2025 14:28:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ROTA](
	[DATACHEGADA] [datetime] NOT NULL,
	[IDNAVIO] [int] NOT NULL,
	[IDPORTO] [int] NOT NULL,
 CONSTRAINT [PK_ROTA] PRIMARY KEY CLUSTERED 
(
	[DATACHEGADA] ASC,
	[IDNAVIO] ASC,
	[IDPORTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_DataPrevistaEntrega]    Script Date: 14/05/2025 14:28:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DataPrevistaEntrega] AS
SELECT
    C.IDCARGA,
    C.TIPO_CARGA,
    C.PESO,
    P_ORIGEM.NOMEPORTO AS PORTO_ORIGEM,
    P_DESTINO.NOMEPORTO AS PORTO_DESTINO,
    N.NOMENAVIO,
    C.DATAEMBARQUE,
    R.DATACHEGADA AS DATA_PREVISTA_ENTREGA
FROM
    CARGA C
JOIN NAVIO N ON C.IDNAVIO = N.IDNAVIO
JOIN PORTO P_ORIGEM ON C.IDPORTO_ORIGEM = P_ORIGEM.IDPORTO
JOIN PORTO P_DESTINO ON C.IDPORTO_DESTINO = P_DESTINO.IDPORTO
JOIN ROTA R ON R.IDNAVIO = C.IDNAVIO AND R.IDPORTO = C.IDPORTO_DESTINO
GO
/****** Object:  View [dbo].[VW_DataPrevistaEntregaCompleto]    Script Date: 14/05/2025 14:28:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_DataPrevistaEntregaCompleto] AS
SELECT
    C.IDCARGA,
    C.TIPO_CARGA,
    C.PESO,
    P_ORIGEM.NOMEPORTO AS PORTO_ORIGEM,
    P_DESTINO.NOMEPORTO AS PORTO_DESTINO,
    N.NOMENAVIO,
    C.DATAEMBARQUE,
    R.DATACHEGADA AS DATA_PREVISTA_ENTREGA
FROM
    CARGA C
LEFT JOIN NAVIO N ON C.IDNAVIO = N.IDNAVIO
LEFT JOIN PORTO P_ORIGEM ON C.IDPORTO_ORIGEM = P_ORIGEM.IDPORTO
LEFT JOIN PORTO P_DESTINO ON C.IDPORTO_DESTINO = P_DESTINO.IDPORTO
LEFT JOIN ROTA R ON R.IDNAVIO = C.IDNAVIO AND R.IDPORTO = C.IDPORTO_DESTINO
GO
/****** Object:  Table [dbo].[AGENTE_RECEPTOR]    Script Date: 14/05/2025 14:28:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AGENTE_RECEPTOR](
	[IDAGENTE] [int] IDENTITY(1,1) NOT NULL,
	[IDPORTO] [int] NULL,
	[NOMEAGENTE] [varchar](50) NULL,
 CONSTRAINT [PK_AGENTE_RECEPTOR] PRIMARY KEY CLUSTERED 
(
	[IDAGENTE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [5_FK]    Script Date: 14/05/2025 14:28:14 ******/
CREATE NONCLUSTERED INDEX [5_FK] ON [dbo].[AGENTE_RECEPTOR]
(
	[IDPORTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [1_FK]    Script Date: 14/05/2025 14:28:14 ******/
CREATE NONCLUSTERED INDEX [1_FK] ON [dbo].[CARGA]
(
	[IDPORTO_DESTINO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [2_FK]    Script Date: 14/05/2025 14:28:14 ******/
CREATE NONCLUSTERED INDEX [2_FK] ON [dbo].[CARGA]
(
	[IDNAVIO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [3_FK]    Script Date: 14/05/2025 14:28:14 ******/
CREATE NONCLUSTERED INDEX [3_FK] ON [dbo].[CARGA]
(
	[IDAGENTE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [7_FK]    Script Date: 14/05/2025 14:28:14 ******/
CREATE NONCLUSTERED INDEX [7_FK] ON [dbo].[CARGA]
(
	[IDPORTO_ORIGEM] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [4_FK]    Script Date: 14/05/2025 14:28:14 ******/
CREATE NONCLUSTERED INDEX [4_FK] ON [dbo].[ROTA]
(
	[IDNAVIO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [6_FK]    Script Date: 14/05/2025 14:28:14 ******/
CREATE NONCLUSTERED INDEX [6_FK] ON [dbo].[ROTA]
(
	[IDPORTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[AGENTE_RECEPTOR]  WITH CHECK ADD  CONSTRAINT [FK_AGENTE_R_5_PORTO] FOREIGN KEY([IDPORTO])
REFERENCES [dbo].[PORTO] ([IDPORTO])
GO
ALTER TABLE [dbo].[AGENTE_RECEPTOR] CHECK CONSTRAINT [FK_AGENTE_R_5_PORTO]
GO
ALTER TABLE [dbo].[CARGA]  WITH CHECK ADD  CONSTRAINT [FK_CARGA_1_PORTO] FOREIGN KEY([IDPORTO_DESTINO])
REFERENCES [dbo].[PORTO] ([IDPORTO])
GO
ALTER TABLE [dbo].[CARGA] CHECK CONSTRAINT [FK_CARGA_1_PORTO]
GO
ALTER TABLE [dbo].[CARGA]  WITH CHECK ADD  CONSTRAINT [FK_CARGA_2_NAVIO] FOREIGN KEY([IDNAVIO])
REFERENCES [dbo].[NAVIO] ([IDNAVIO])
GO
ALTER TABLE [dbo].[CARGA] CHECK CONSTRAINT [FK_CARGA_2_NAVIO]
GO
ALTER TABLE [dbo].[CARGA]  WITH CHECK ADD  CONSTRAINT [FK_CARGA_3_AGENTE_R] FOREIGN KEY([IDAGENTE])
REFERENCES [dbo].[AGENTE_RECEPTOR] ([IDAGENTE])
GO
ALTER TABLE [dbo].[CARGA] CHECK CONSTRAINT [FK_CARGA_3_AGENTE_R]
GO
ALTER TABLE [dbo].[CARGA]  WITH CHECK ADD  CONSTRAINT [FK_CARGA_7_PORTO] FOREIGN KEY([IDPORTO_ORIGEM])
REFERENCES [dbo].[PORTO] ([IDPORTO])
GO
ALTER TABLE [dbo].[CARGA] CHECK CONSTRAINT [FK_CARGA_7_PORTO]
GO
ALTER TABLE [dbo].[ROTA]  WITH CHECK ADD  CONSTRAINT [FK_ROTA_4_NAVIO] FOREIGN KEY([IDNAVIO])
REFERENCES [dbo].[NAVIO] ([IDNAVIO])
GO
ALTER TABLE [dbo].[ROTA] CHECK CONSTRAINT [FK_ROTA_4_NAVIO]
GO
ALTER TABLE [dbo].[ROTA]  WITH CHECK ADD  CONSTRAINT [FK_ROTA_6_PORTO] FOREIGN KEY([IDPORTO])
REFERENCES [dbo].[PORTO] ([IDPORTO])
GO
ALTER TABLE [dbo].[ROTA] CHECK CONSTRAINT [FK_ROTA_6_PORTO]
GO
USE [master]
GO
ALTER DATABASE [trabalho] SET  READ_WRITE 
GO
