USE [master]
GO

/****** Object:  Database [Beric]    Script Date: 2/18/2022 8:01:31 PM ******/
CREATE DATABASE [Beric]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Beric', FILENAME = N'D:\sqlNikola\test1\Beric.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Beric_log', FILENAME = N'D:\sqlNikola\test1\Beric_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Beric].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [Beric] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [Beric] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [Beric] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [Beric] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [Beric] SET ARITHABORT OFF 
GO

ALTER DATABASE [Beric] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [Beric] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [Beric] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [Beric] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [Beric] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [Beric] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [Beric] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [Beric] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [Beric] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [Beric] SET  DISABLE_BROKER 
GO

ALTER DATABASE [Beric] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [Beric] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [Beric] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [Beric] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [Beric] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [Beric] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [Beric] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [Beric] SET RECOVERY FULL 
GO

ALTER DATABASE [Beric] SET  MULTI_USER 
GO

ALTER DATABASE [Beric] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [Beric] SET DB_CHAINING OFF 
GO

ALTER DATABASE [Beric] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [Beric] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO

ALTER DATABASE [Beric] SET DELAYED_DURABILITY = DISABLED 
GO

ALTER DATABASE [Beric] SET QUERY_STORE = OFF
GO

ALTER DATABASE [Beric] SET  READ_WRITE 
GO

--Pravlenje tabela

USE Beric;
GO

CREATE TABLE Tip_Proizvoda(
tip_id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
naziv_tipa nvarchar(10) NOT NULL
);
GO

CREATE TABLE Magacin(
magacin_id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
adresa nvarchar(25) NOT NULL,
kontakt int
);
GO

CREATE TABLE Materijali(
materijal_id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
naziv_materijala nvarchar(25)
);
GO

CREATE TABLE Grad(
grad_id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
naziv_grada nvarchar(20)
);
GO

CREATE TABLE Klijenti(
klijent_id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
ime nvarchar(15) NOT NULL,
prezime nvarchar(15) NOT NULL,
adresa nvarchar(25) NOT NULL,
grad_id int FOREIGN KEY REFERENCES Grad(grad_id) 
);
GO

CREATE TABLE Kategorije(
kategorija_id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
naziv_kategorije nvarchar(25),
tip_id int FOREIGN KEY REFERENCES Tip_Proizvoda(tip_id) NOT NULL
);
GO

CREATE TABLE Pol(
pol_id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
naziv_pola nvarchar(10) NOT NULL
);
GO

CREATE TABLE Kategorije_Proizvoda(
Kproizvoda_id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
pol_id int FOREIGN KEY REFERENCES Pol(pol_id) NOT NULL,
kategorija_id int FOREIGN KEY REFERENCES Kategorije(kategorija_id) NOT NULL
);
GO


CREATE TABLE Materijal_Proizvoda(
Mproizvoda_id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
Kproizvoda_id int FOREIGN KEY REFERENCES Kategorije_Proizvoda(Kproizvoda_id) NOT NULL,
materijal_id int FOREIGN KEY REFERENCES Materijali(materijal_id) NOT NULL
);
GO

CREATE TABLE Brend(
brend_id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
naviz_brenda nvarchar(25) NOT NULL,
tip_id int FOREIGN KEY REFERENCES Tip_Proizvoda(tip_id) NOT NuLL
);
GO

CREATE TABLE Proizvod(
proizvod_id int IDENTITY(1,1) PRIMARY KEY NOT NULL,
Mproizvoda_id int FOREIGN KEY REFERENCES Materijal_Proizvoda(Mproizvoda_id) NOT NULL,
naziv_proizvoda nvarchar(35) NOT NULL
);
GO

CREATE TABLE Artikal(
id_artikal int IDENTITY(1,1) PRIMARY KEY NOT NULL,
proizvod_id int FOREIGN KEY REFERENCES Proizvod(proizvod_id) NOT NULL,
klijent_id int FOREIGN KEY REFERENCES Klijenti(klijent_id) NOT NULL,
magacin_id int FOREIGN KEY REFERENCES Magacin(magacin_id) NOT NULL
);
GO

ALTER TABLE Materijal_Proizvoda
ADD Kproizvoda_id int FOREIGN KEY REFERENCES Kategorije_Proizvoda(Kproizvoda_id);

ALTER TABLE Proizvod 
ADD brend_id int FOREIGN KEY REFERENCES Brend(brend_id);

ALTER TABLE Magacin
ADD grad_id int FOREIGN KEY REFERENCES Grad(grad_id);

ALTER TABLE Materijal_Proizvoda
DROP CONSTRAINT FK__Materijal__tip_i__4E88ABD4;

ALTER TABLE Materijal_Proizvoda
DROP COLUMN tip_id;

ALTER TABLE Proizvod
ADD cena int NOT NULL;

ALTER TABLE Proizvod 
DROP CONSTRAINT FK__Proizvod__Mproiz__5EBF139D;

ALTER TABLE Proizvod 
DROP COLUMN Mproizvoda_id;

DROP TABLE Materijal_Proizvoda;

DROP TABLE Kategorije_Proizvoda;

ALTER TABLE Proizvod
ADD kategorija_id int FOREIGN KEY REFERENCES Kategorije(kategorija_id),
materijal_id int FOREIGN KEY REFERENCES Materijali(materijal_id),
pol_id int FOREIGN KEY REFERENCES Pol(pol_id);
