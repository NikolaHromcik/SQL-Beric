-- Skalarna funkcija za cenu bez pdva
USE Beric;
GO

CREATE FUNCTION dbo.Cena_bez_PDV(@cena float)
returns float
AS 
BEGIN
RETURN @cena * 0.8;
END
GO

SELECT Proizvod.naziv_proizvoda, dbo.Cena_bez_PDV(Proizvod.cena) as bez_pdv FROM Proizvod;

-----------------------------------------------------------------------------------------------------

--Upit sa agregatnom funkciom koji vraca prosecnu cenu za svaki brend
SELECT Brend.naviz_brenda, Proizvod.brend_id, AVG(Proizvod.cena)as prosecna_cena FROM Proizvod
LEFT JOIN Brend ON Brend.brend_id=Proizvod.brend_id
GROUP BY Brend.naviz_brenda, Proizvod.brend_id
ORDER BY prosecna_cena DESC;
-------------------------------------------------------------------

-- Procedura INSERT,UPDATE,DELETE

CREATE OR ALTER PROCEDURE dbo.dodajKlijenta(@ime nvarchar(15), 
@prezime nvarchar(15), @adresa nvarchar(25), @gradID int)
AS 
BEGIN TRY
INSERT INTO dbo.Klijenti(ime, prezime, adresa, grad_id)
VALUES
(@ime, @prezime, @adresa, @gradID)
END TRY
BEGIN CATCH
EXEC ErrorHandler
END CATCH
GO

------

CREATE OR ALTER PROCEDURE dbo.updateKlijenta(@KlijentID int, @ime nvarchar(15), 
@prezime nvarchar(15), @adresa nvarchar(25), @GradID int)
AS 
BEGIN TRY
UPDATE dbo.Klijenti
SET 
ime = @ime,
prezime = @prezime,
adresa = @adresa,
grad_id = @GradID
WHERE klijent_id = @KlijentID
END TRY
BEGIN CATCH
EXEC ErrorHandler
END CATCH
GO

------

CREATE OR ALTER PROCEDURE dbo.ObrisiKlijenta(@KlijentID int)
AS 
BEGIN TRY
DELETE FROM dbo.Klijenti 
WHERE klijent_id = @KlijentID
END TRY
BEGIN CATCH
EXEC ErrorHandler
END CATCH
GO

EXEC dbo.dodajKlijenta 'Misa', 'Misica', 'Ulicica 1', 1;
EXEC dbo.updateKlijenta 19, 'Misa', 'Vasic', 'Pancevacki most 69', 1;

SELECT * FROM Klijenti;

---------------------------------------------------------------------------
SELECT * FROM Magacin;
--After okidac
SELECT * FROM Artikal;

CREATE TRIGGER dbo.insertArtikal
ON dbo.Artikal
AFTER INSERT
AS
BEGIN
SET NOCOUNT ON;
IF EXISTS(SELECT * FROM inserted AS i
WHERE
i.proizvod_id NOT BETWEEN 1 AND 86 OR
i.klijent_id NOT BETWEEN 1 AND 19 OR
i.magacin_id NOT BETWEEN 1 AND 5
)
BEGIN
PRINT 'Niste uneli validne podatke';
IF @@TRANCOUNT > 0 
ROLLBACK TRANSACTION;
END; 
END;
GO

INSERT dbo.Artikal(proizvod_id,klijent_id,magacin_id)
VALUES
(5,22,7)

-----------------------------------------------------------
--DDL okidac
CREATE TABLE dbo.ddlEventLog(serverName varchar(200), postTime datetime, loginName varchar(200),
databaseName varchar(200), tsqlCommand varchar(2000));
GO

CREATE or ALTER TRIGGER triggerCreateTable
on DATABASE
FOR create_table
AS
DECLARE @data xml = eventdata();
INSERT INTO dbo.ddlEventLog([serverName], [postTime], [loginName], [databaseName], [tsqlCommand])
VALUES
(
  @data.value ('(/EVENT_INSTANCE/ServerName)[1]', 'nvarchar(200)'),
  GETDATE(),
  @data.value ('(/EVENT_INSTANCE/LoginName)[1]', 'nvarchar(200)'),
  @data.value ('(/EVENT_INSTANCE/DatabaseName)[1]', 'nvarchar(200)'),
  @data.value ('(/EVENT_INSTANCE/TSQLCommand)[1]', 'nvarchar(2000)')
);
GO

CREATE TABLE dbo.test(testID int);
GO

SELECT * FROM dbo.ddlEventLog;
-------------------------------------------
--Instead of okidac
SELECT * FROM Grad;

CREATE TABLE dbo.Grad2(
grad_id int IDENTITY(1,1) PRIMARY KEY,
naziv_grada nvarchar(20) NOT NULL,
postanski_broj int NOT NULL
);
GO
ALTER TABLE Grad2
ADD LogAction nvarchar(50);
DECLARE @LogAction nvarchar(50);

CREATE OR ALTER TRIGGER dbo.InsteadOfUpdate
ON dbo.Grad2 INSTEAD OF UPDATE 
AS
DECLARE 
@GradID int, @naziv_grada nvarchar(20), @Postanski_broj int, @LogAction nvarchar(50);
SELECT @GradID = i.grad_id FROM inserted i;
SELECT @naziv_grada = i.naziv_grada FROM inserted i;
SELECT @Postanski_broj = i.postanski_broj FROM inserted i;
SET @LogAction = 'Insertovana stavka';
BEGIN
BEGIN TRAN
IF (@Postanski_broj <100000)
BEGIN
RAISERROR('Postanski broj ne sme biti manji od 100000',16,1);
ROLLBACK;
END
ELSE BEGIN
INSERT INTO dbo.Grad2(grad_id,naziv_grada,postanski_broj)
VALUES (@GradID,@naziv_grada,@Postanski_broj);
COMMIT;
PRINT 'Stavka je updateovana';
END
END

SELECT  * FROM Grad2;
INSERT Grad2 VALUES
('Budimpesta', 112000,'');

UPDATE dbo.Grad2 SET postanski_broj = '500' WHERE grad_id =1;

SELECT * FROM Grad2;

---------------------------------------------
-- Inline table valued funkcija koja vraca sve artikle odredjenog klijenta

CREATE FUNCTION dbo.ArtikliKlijenta(@KlijentID int)
RETURNS TABLE
AS
RETURN
(
SELECT Artikal.id_artikal, Artikal.klijent_id FROM Artikal
WHERE Artikal.klijent_id = @KlijentID
);
GO

SELECT * FROM dbo.ArtikliKlijenta(5);
--------------------------------------------------------
-- procedura transakcije

CREATE PROCEDURE UpdateCena
@ProizvodID int, @cena float
AS
BEGIN TRY
BEGIN TRANSACTION 
UPDATE Proizvod
SET cena = @cena
WHERE proizvod_id = @ProizvodID
IF @@TRANCOUNT > 0
COMMIT 
END TRY
BEGIN CATCH
IF @@TRANCOUNT > 0 
ROLLBACK
END CATCH
GO
SELECT * FROM Proizvod;

EXEC UpdateCena 2, 6000;

SELECT * FROM Proizvod;
