USE [master]
GO

/****** Object:  Database [Weterynaryjna Klinika]    Script Date: 25/05/2020 02:46:37 ******/
CREATE DATABASE [Weterynaryjna Klinika]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Weterynaryjna Klinika', FILENAME = N'C:\Users\Intel\Weterynaryjna Klinika.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Weterynaryjna Klinika_log', FILENAME = N'C:\Users\Intel\Weterynaryjna Klinika_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Weterynaryjna Klinika].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [Weterynaryjna Klinika] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET ARITHABORT OFF 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET  DISABLE_BROKER 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET RECOVERY SIMPLE 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET  MULTI_USER 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [Weterynaryjna Klinika] SET DB_CHAINING OFF 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [Weterynaryjna Klinika] SET QUERY_STORE = OFF
GO

USE [Weterynaryjna Klinika]
GO

ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO

ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO

ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO

ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO

ALTER DATABASE [Weterynaryjna Klinika] SET  READ_WRITE 
GO


USE [Weterynaryjna Klinika]
GO

/****** Object:  Table [dbo].[Dostawcy]    Script Date: 25/05/2020 02:47:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Dostawcy](
	[IDDostawcy] [int] NOT NULL,
	[NazwaDostawcy] [varchar](60) NOT NULL,
	[Kraj] [varchar](30) NOT NULL,
	[Miasto] [varchar](60) NOT NULL,
	[Ulica] [varchar](60) NOT NULL,
	[NumerUlicy] [varchar](6) NOT NULL,
	[Telefon] [varchar](15) NULL,
	[Email] [varchar](255) NULL,
 CONSTRAINT [PK_Dostawcy] PRIMARY KEY CLUSTERED 
(
	[IDDostawcy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [Weterynaryjna Klinika]
GO

/****** Object:  Table [dbo].[Dostawy]    Script Date: 25/05/2020 02:47:27 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Dostawy](
	[IDDostawy] [int] NOT NULL,
	[DataZamówienia] [datetime] NULL,
	[DataP³atnoœci] [datetime] NULL,
	[DataRealizacji] [datetime] NULL,
	[KwotaZamówieniaNetto] [float] NOT NULL,
	[PodatekProcent] [float] NOT NULL,
	[IDDostawcy] [int] NOT NULL,
 CONSTRAINT [PK_Dostawy] PRIMARY KEY CLUSTERED 
(
	[IDDostawy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Dostawy]  WITH CHECK ADD  CONSTRAINT [FK_Dostawy_Dostawcy1] FOREIGN KEY([IDDostawcy])
REFERENCES [dbo].[Dostawcy] ([IDDostawcy])
GO

ALTER TABLE [dbo].[Dostawy] CHECK CONSTRAINT [FK_Dostawy_Dostawcy1]
GO


USE [Weterynaryjna Klinika]
GO

/****** Object:  Table [dbo].[Kategorie]    Script Date: 25/05/2020 02:47:33 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Kategorie](
	[IDKategorii] [int] NOT NULL,
	[NazwaKategorii] [varchar](30) NOT NULL,
	[OpisKategorii] [varchar](100) NULL,
 CONSTRAINT [PK_Kategorie] PRIMARY KEY CLUSTERED 
(
	[IDKategorii] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [Weterynaryjna Klinika]
GO

/****** Object:  Table [dbo].[Klienci]    Script Date: 25/05/2020 02:47:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Klienci](
	[IDKlienta] [int] NOT NULL,
	[Imiê] [varchar](40) NOT NULL,
	[Nazwisko] [varchar](40) NOT NULL,
	[Kraj] [varchar](30) NULL,
	[Miasto] [varchar](60) NULL,
	[Ulica] [varchar](60) NULL,
	[NumerUlicy] [varchar](6) NULL,
	[Telefon] [varchar](15) NULL,
	[Email] [varchar](255) NULL,
 CONSTRAINT [PK_Klienci] PRIMARY KEY CLUSTERED 
(
	[IDKlienta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [Weterynaryjna Klinika]
GO

/****** Object:  Table [dbo].[Pracownicy]    Script Date: 25/05/2020 02:47:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Pracownicy](
	[IDPracownika] [int] NOT NULL,
	[Imiê] [varchar](30) NOT NULL,
	[Nazwisko] [varchar](40) NOT NULL,
	[Stanowisko] [varchar](70) NOT NULL,
	[DataUrodzenia] [datetime] NOT NULL,
	[DataZatrudnienia] [datetime] NOT NULL,
	[DataZwolnienia] [datetime] NULL,
	[Kraj] [varchar](30) NULL,
	[Miasto] [varchar](60) NULL,
	[Ulica] [varchar](60) NULL,
	[NumerUlicy] [varchar](6) NULL,
	[Telefon] [varchar](20) NULL,
	[Email] [varchar](255) NULL,
 CONSTRAINT [PK_Pracownicy] PRIMARY KEY CLUSTERED 
(
	[IDPracownika] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [Weterynaryjna Klinika]
GO

/****** Object:  Table [dbo].[Produkty]    Script Date: 25/05/2020 02:47:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Produkty](
	[IDProduktu] [int] NOT NULL,
	[NazwaProduktu] [varchar](40) NOT NULL,
	[DostêpnaIloœæ] [int] NOT NULL,
	[CenaZaSztukêNetto] [float] NULL,
	[WielkoœæProduktu] [varchar](40) NULL,
	[PodatekProcent] [float] NULL,
	[IDKategorii] [int] NOT NULL,
 CONSTRAINT [PK_Produkty] PRIMARY KEY CLUSTERED 
(
	[IDProduktu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Produkty]  WITH CHECK ADD  CONSTRAINT [FK_Produkty_Kategorie] FOREIGN KEY([IDKategorii])
REFERENCES [dbo].[Kategorie] ([IDKategorii])
GO

ALTER TABLE [dbo].[Produkty] CHECK CONSTRAINT [FK_Produkty_Kategorie]
GO


USE [Weterynaryjna Klinika]
GO

/****** Object:  Table [dbo].[RodzajeZabiegów]    Script Date: 25/05/2020 02:48:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[RodzajeZabiegów](
	[IDRodzaju] [int] NOT NULL,
	[NazwaRodzaju] [varchar](50) NOT NULL,
	[OpisRodzaju] [varchar](255) NULL,
	[PodatekRodzaju] [float] NOT NULL,
 CONSTRAINT [PK_RodzajeZabiegów] PRIMARY KEY CLUSTERED 
(
	[IDRodzaju] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


USE [Weterynaryjna Klinika]
GO

/****** Object:  Table [dbo].[Szczegó³yDostawy]    Script Date: 25/05/2020 02:48:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Szczegó³yDostawy](
	[IDDostawy] [int] NOT NULL,
	[IDProduktu] [int] NOT NULL,
 CONSTRAINT [PK_Szczegó³yDostawy] PRIMARY KEY CLUSTERED 
(
	[IDDostawy] ASC,
	[IDProduktu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Szczegó³yDostawy]  WITH CHECK ADD  CONSTRAINT [FK_Szczegó³yDostawy_Dostawy] FOREIGN KEY([IDDostawy])
REFERENCES [dbo].[Dostawy] ([IDDostawy])
GO

ALTER TABLE [dbo].[Szczegó³yDostawy] CHECK CONSTRAINT [FK_Szczegó³yDostawy_Dostawy]
GO

ALTER TABLE [dbo].[Szczegó³yDostawy]  WITH CHECK ADD  CONSTRAINT [FK_Szczegó³yDostawy_Produkty] FOREIGN KEY([IDProduktu])
REFERENCES [dbo].[Produkty] ([IDProduktu])
GO

ALTER TABLE [dbo].[Szczegó³yDostawy] CHECK CONSTRAINT [FK_Szczegó³yDostawy_Produkty]
GO


USE [Weterynaryjna Klinika]
GO

/****** Object:  Table [dbo].[Szczegó³yZakupu]    Script Date: 25/05/2020 02:48:12 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Szczegó³yZakupu](
	[IDZakupu] [int] NOT NULL,
	[IDProduku] [int] NOT NULL,
 CONSTRAINT [PK_Szczegó³yZakupu] PRIMARY KEY CLUSTERED 
(
	[IDZakupu] ASC,
	[IDProduku] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Szczegó³yZakupu]  WITH CHECK ADD  CONSTRAINT [FK_Szczegó³yZakupu_Produkty1] FOREIGN KEY([IDProduku])
REFERENCES [dbo].[Produkty] ([IDProduktu])
GO

ALTER TABLE [dbo].[Szczegó³yZakupu] CHECK CONSTRAINT [FK_Szczegó³yZakupu_Produkty1]
GO

ALTER TABLE [dbo].[Szczegó³yZakupu]  WITH CHECK ADD  CONSTRAINT [FK_Szczegó³yZakupu_Zakupy] FOREIGN KEY([IDZakupu])
REFERENCES [dbo].[Zakupy] ([IDZakupu])
GO

ALTER TABLE [dbo].[Szczegó³yZakupu] CHECK CONSTRAINT [FK_Szczegó³yZakupu_Zakupy]
GO


USE [Weterynaryjna Klinika]
GO

/****** Object:  Table [dbo].[Urlopy]    Script Date: 25/05/2020 02:48:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Urlopy](
	[IDUrlopu] [int] NOT NULL,
	[DataRozpoczêcia] [datetime] NOT NULL,
	[DataZakoñczenia] [datetime] NULL,
	[Powód] [varchar](255) NOT NULL,
	[P³atnoœæ] [float] NULL,
	[IDPracownika] [int] NOT NULL,
 CONSTRAINT [PK_Urlopy] PRIMARY KEY CLUSTERED 
(
	[IDUrlopu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Urlopy]  WITH CHECK ADD  CONSTRAINT [FK_Urlopy_Pracownicy] FOREIGN KEY([IDPracownika])
REFERENCES [dbo].[Pracownicy] ([IDPracownika])
GO

ALTER TABLE [dbo].[Urlopy] CHECK CONSTRAINT [FK_Urlopy_Pracownicy]
GO


USE [Weterynaryjna Klinika]
GO

/****** Object:  Table [dbo].[WykonawcyZabiegu]    Script Date: 25/05/2020 02:48:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WykonawcyZabiegu](
	[IDZabiegu] [int] NOT NULL,
	[IDPracownika] [int] NOT NULL,
 CONSTRAINT [PK_WykonawcyZabiegu] PRIMARY KEY CLUSTERED 
(
	[IDZabiegu] ASC,
	[IDPracownika] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[WykonawcyZabiegu]  WITH CHECK ADD  CONSTRAINT [FK_WykonawcyZabiegu_Pracownicy] FOREIGN KEY([IDPracownika])
REFERENCES [dbo].[Pracownicy] ([IDPracownika])
GO

ALTER TABLE [dbo].[WykonawcyZabiegu] CHECK CONSTRAINT [FK_WykonawcyZabiegu_Pracownicy]
GO

ALTER TABLE [dbo].[WykonawcyZabiegu]  WITH CHECK ADD  CONSTRAINT [FK_WykonawcyZabiegu_Zabiegi] FOREIGN KEY([IDZabiegu])
REFERENCES [dbo].[Zabiegi] ([IDZabiegu])
GO

ALTER TABLE [dbo].[WykonawcyZabiegu] CHECK CONSTRAINT [FK_WykonawcyZabiegu_Zabiegi]
GO


USE [Weterynaryjna Klinika]
GO

/****** Object:  Table [dbo].[Zabiegi]    Script Date: 25/05/2020 02:48:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Zabiegi](
	[IDZabiegu] [int] NOT NULL,
	[NazwaZabiegu] [varchar](50) NOT NULL,
	[DataZabiegu] [datetime] NULL,
	[RodzajZabiegu] [varchar](50) NOT NULL,
	[CenaZabiegu] [float] NOT NULL,
	[PodatekZabiegu] [float] NOT NULL,
	[Komentarz] [varchar](255) NULL,
	[IDKlienta] [int] NOT NULL,
	[IDZwierzêcia] [int] NOT NULL,
 CONSTRAINT [PK_Zabiegi] PRIMARY KEY CLUSTERED 
(
	[IDZabiegu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Zabiegi]  WITH CHECK ADD  CONSTRAINT [FK_Zabiegi_Klienci] FOREIGN KEY([IDKlienta])
REFERENCES [dbo].[Klienci] ([IDKlienta])
GO

ALTER TABLE [dbo].[Zabiegi] CHECK CONSTRAINT [FK_Zabiegi_Klienci]
GO

ALTER TABLE [dbo].[Zabiegi]  WITH CHECK ADD  CONSTRAINT [FK_Zabiegi_Zwierzêta] FOREIGN KEY([IDZwierzêcia])
REFERENCES [dbo].[Zwierzêta] ([IDZwierzêcia])
GO

ALTER TABLE [dbo].[Zabiegi] CHECK CONSTRAINT [FK_Zabiegi_Zwierzêta]
GO


USE [Weterynaryjna Klinika]
GO

/****** Object:  Table [dbo].[Zakupy]    Script Date: 25/05/2020 02:48:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Zakupy](
	[IDZakupu] [int] NOT NULL,
	[DataZakupu] [datetime] NOT NULL,
	[KwotaZakupuBrutto] [float] NOT NULL,
	[IDKlienta] [int] NOT NULL,
 CONSTRAINT [PK_Zakupy] PRIMARY KEY CLUSTERED 
(
	[IDZakupu] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Zakupy]  WITH CHECK ADD  CONSTRAINT [FK_Zakupy_Klienci] FOREIGN KEY([IDKlienta])
REFERENCES [dbo].[Klienci] ([IDKlienta])
GO

ALTER TABLE [dbo].[Zakupy] CHECK CONSTRAINT [FK_Zakupy_Klienci]
GO


USE [Weterynaryjna Klinika]
GO

/****** Object:  Table [dbo].[Zwierzêta]    Script Date: 25/05/2020 02:48:50 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Zwierzêta](
	[IDZwierzêcia] [int] NOT NULL,
	[Wiek] [int] NULL,
	[Rodzaj] [varchar](50) NOT NULL,
	[Gatunek] [varchar](50) NOT NULL,
	[Masa] [varchar](15) NULL,
	[Wysokoœæ] [varchar](15) NULL,
	[D³ugoœæ] [varchar](15) NULL,
 CONSTRAINT [PK_Zwierzêta] PRIMARY KEY CLUSTERED 
(
	[IDZwierzêcia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


