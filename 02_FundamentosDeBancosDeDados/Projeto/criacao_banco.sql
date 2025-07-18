USE [master]
GO
/****** Object:  Database [LogisticaMarinha]    Script Date: 19/05/2025 19:33:20 ******/
CREATE DATABASE [LogisticaMarinha]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'LogisticaMarinha', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\LogisticaMarinha.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'LogisticaMarinha_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\LogisticaMarinha_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [LogisticaMarinha] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [LogisticaMarinha].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [LogisticaMarinha] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [LogisticaMarinha] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [LogisticaMarinha] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [LogisticaMarinha] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [LogisticaMarinha] SET ARITHABORT OFF 
GO
ALTER DATABASE [LogisticaMarinha] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [LogisticaMarinha] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [LogisticaMarinha] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [LogisticaMarinha] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [LogisticaMarinha] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [LogisticaMarinha] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [LogisticaMarinha] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [LogisticaMarinha] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [LogisticaMarinha] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [LogisticaMarinha] SET  ENABLE_BROKER 
GO
ALTER DATABASE [LogisticaMarinha] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [LogisticaMarinha] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [LogisticaMarinha] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [LogisticaMarinha] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [LogisticaMarinha] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [LogisticaMarinha] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [LogisticaMarinha] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [LogisticaMarinha] SET RECOVERY FULL 
GO
ALTER DATABASE [LogisticaMarinha] SET  MULTI_USER 
GO
ALTER DATABASE [LogisticaMarinha] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [LogisticaMarinha] SET DB_CHAINING OFF 
GO
ALTER DATABASE [LogisticaMarinha] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [LogisticaMarinha] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [LogisticaMarinha] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [LogisticaMarinha] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'LogisticaMarinha', N'ON'
GO
ALTER DATABASE [LogisticaMarinha] SET QUERY_STORE = ON
GO
ALTER DATABASE [LogisticaMarinha] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [LogisticaMarinha]
GO
/****** Object:  Table [dbo].[agentes]    Script Date: 19/05/2025 19:33:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[agentes](
	[id] [int] NOT NULL,
	[nome] [varchar](255) NULL,
	[id_porto] [int] NULL,
	[eh_supervisor] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cargas]    Script Date: 19/05/2025 19:33:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cargas](
	[id] [int] NOT NULL,
	[numero] [varchar](50) NULL,
	[id_navio] [int] NULL,
	[descricao] [varchar](255) NULL,
	[especificacao] [varchar](255) NULL,
	[data_inicio] [datetime] NULL,
	[data_final] [datetime] NULL,
	[data_validade] [datetime] NULL,
	[status] [varchar](50) NULL,
	[eh_sensivel] [bit] NULL,
	[eh_perecivel] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[etiquetas]    Script Date: 19/05/2025 19:33:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[etiquetas](
	[id] [int] NOT NULL,
	[id_carga] [int] NULL,
	[id_porto_origem] [int] NULL,
	[id_porto_destino] [int] NULL,
	[id_agente] [int] NULL,
	[peso] [decimal](18, 2) NULL,
	[temperatura_maxima] [decimal](5, 2) NULL,
	[data_prevista_entrega] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[navios]    Script Date: 19/05/2025 19:33:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[navios](
	[id] [int] NOT NULL,
	[nome] [varchar](255) NULL,
	[capacidade_kg] [bigint] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[portos]    Script Date: 19/05/2025 19:33:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[portos](
	[id] [int] NOT NULL,
	[nome] [varchar](255) NULL,
	[endereco] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[rotas]    Script Date: 19/05/2025 19:33:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rotas](
	[id] [int] NOT NULL,
	[id_navio] [int] NULL,
	[id_porto_origem] [int] NULL,
	[id_porto_destino] [int] NULL,
	[data_prevista_chegada] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[agentes]  WITH CHECK ADD FOREIGN KEY([id_porto])
REFERENCES [dbo].[portos] ([id])
GO
ALTER TABLE [dbo].[cargas]  WITH CHECK ADD FOREIGN KEY([id_navio])
REFERENCES [dbo].[navios] ([id])
GO
ALTER TABLE [dbo].[etiquetas]  WITH CHECK ADD FOREIGN KEY([id_agente])
REFERENCES [dbo].[agentes] ([id])
GO
ALTER TABLE [dbo].[etiquetas]  WITH CHECK ADD FOREIGN KEY([id_carga])
REFERENCES [dbo].[cargas] ([id])
GO
ALTER TABLE [dbo].[etiquetas]  WITH CHECK ADD FOREIGN KEY([id_porto_origem])
REFERENCES [dbo].[portos] ([id])
GO
ALTER TABLE [dbo].[etiquetas]  WITH CHECK ADD FOREIGN KEY([id_porto_destino])
REFERENCES [dbo].[portos] ([id])
GO
ALTER TABLE [dbo].[rotas]  WITH CHECK ADD FOREIGN KEY([id_navio])
REFERENCES [dbo].[navios] ([id])
GO
ALTER TABLE [dbo].[rotas]  WITH CHECK ADD FOREIGN KEY([id_porto_origem])
REFERENCES [dbo].[portos] ([id])
GO
ALTER TABLE [dbo].[rotas]  WITH CHECK ADD FOREIGN KEY([id_porto_destino])
REFERENCES [dbo].[portos] ([id])
GO
USE [master]
GO
ALTER DATABASE [LogisticaMarinha] SET  READ_WRITE 
GO
