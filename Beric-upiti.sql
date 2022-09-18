-- Upit koji ispisuje sve podatke iz Artikla a ne samo ID-jeve
USE Beric;
GO

SELECT Artikal.id_artikal, Brend.naviz_brenda, Proizvod.naziv_proizvoda, Materijali.naziv_materijala,
Proizvod.cena, Klijenti.ime, Klijenti.prezime, Magacin.adresa, Grad.naziv_grada
FROM Artikal 
RIGHT JOIN Proizvod ON Artikal.proizvod_id = Proizvod.proizvod_id
RIGHT JOIN Brend ON Proizvod.brend_id = Brend.brend_id
RIGHT JOIN Klijenti ON Artikal.klijent_id = Klijenti.klijent_id
RIGHT JOIN Magacin ON Artikal.magacin_id = Magacin.magacin_id
LEFT JOIN Grad ON Magacin.grad_id = Grad.grad_id
LEFT JOIN Materijali ON Proizvod.materijal_id = Materijali.materijal_id;

-----------------------------------------------------------------------------------------------------
-- Upit koji vraca broj porudzbina po klijentu
SELECT Artikal.klijent_id, COUNT(DISTINCT Artikal.id_artikal) as broj_porudzbina
FROM Artikal
GROUP BY Artikal.klijent_id
ORDER BY broj_porudzbina DESC;
GO
-------------------------------------------------------------------------------------------------------

-- Upit koji vraca sve muske satove po ceni od manje ka vece
SELECT Brend.naviz_brenda, Proizvod.naziv_proizvoda, Tip_Proizvoda.naziv_tipa, Kategorije.naziv_kategorije, Pol.naziv_pola, Proizvod.cena
FROM Proizvod
RIGHT JOIN Kategorije ON Kategorije.kategorija_id = Proizvod.kategorija_id
RIGHT JOIN Tip_Proizvoda ON Tip_Proizvoda.tip_id = Kategorije.tip_id
LEFT JOIN Brend ON Proizvod.brend_id = Brend.brend_id
RIGHT JOIN Pol ON Proizvod.pol_id = Pol.pol_id
WHERE Proizvod.pol_id =1 AND Tip_Proizvoda.tip_id = 1
ORDER BY cena ASC;
GO
------------------------------------------------
--Upit koji vraca klijente koji nemaju ni jednu porudzbinu

SELECT * FROM Klijenti
WHERE NOT EXISTS(SELECT * FROM Artikal
WHERE Artikal.klijent_id = Klijenti.klijent_id);
GO
----------------------------------------------
--Ispisi sve proizvode koji su brenda Casio ili Seiko
SELECT Brend.naviz_brenda, Proizvod.naziv_proizvoda, Proizvod.brend_id FROM Proizvod
 JOIN Brend ON Brend.brend_id = Proizvod.brend_id
WHERE Proizvod.brend_id =1 OR Proizvod.brend_id=2;

-------------------------------------------
--Ispisuje sve narudzbine Klijenta cije ime pocinje na N
SELECT * FROM Artikal
WHERE Artikal.klijent_id=
(
SELECT Klijenti.klijent_id FROM Klijenti
WHERE Klijenti.ime LIKE 'N%'
);

--SELECT * FROM Klijenti;
-----------------------------------------------------

--Upit koji vraca broj porudzbina po klijentu i ukupnu cenu koju su platili
SELECT Artikal.klijent_id, COUNT(DISTINCT Artikal.proizvod_id), SUM(Proizvod.cena) as ukupna_cena FROM Artikal, Proizvod
GROUP BY Artikal.klijent_id
ORDER BY ukupna_cena DESC;

/*
SELECT Artikal.klijent_id, COUNT(DISTINCT Artikal.proizvod_id), Proizvod.cena as ukupna_cena FROM Artikal, Proizvod
WHERE Proizvod.cena=(SELECT SUM(Proizvod.cena) WHERE Artikal.proizvod_id = Proizvod.proizvod_id)
GROUP BY Artikal.klijent_id
ORDER BY ukupna_cena DESC;
*/
-------------------------------------------------------------------------------
--Klijenti koji imaju vise od 5 porudzbina
SELECT  Klijenti.prezime, COUNT(Artikal.id_artikal) as broj_porudzbina 
FROM (Artikal
INNER JOIN Klijenti ON Artikal.klijent_id = Klijenti.klijent_id)
GROUP BY Klijenti.prezime
HAVING COUNT(Artikal.id_artikal) >5
ORDER BY broj_porudzbina DESC;
---------------------------------------------------------


--Ispisuje sve gradove koji imaju vise od jednog klijenta
SELECT Grad.naziv_grada, COUNT(Klijenti.klijent_id) as broj_klijenata
FROM(Klijenti
INNER JOIN Grad ON Klijenti.grad_id = Grad.grad_id)
GROUP BY Grad.naziv_grada
HAVING COUNT(Klijenti.klijent_id) >1
----------------------------------------------------

-- Upit koji ispisuje sve proizvode, i one koje nemaju narudzbinu
SELECT Proizvod.naziv_proizvoda, Artikal.id_artikal FROM Proizvod
FULL OUTER JOIN Artikal ON Proizvod.proizvod_id = Artikal.proizvod_id;
-------------------------------------------------------------------------

--Koriscenje offset fetch, upit koji ne ukljucuje 5 proizvoda sa najvecom cenom, i ukljucuje samo 15 proizvoda nakon njih
--po ceni opadajuce
SELECT Brend.naviz_brenda, Proizvod.naziv_proizvoda, Proizvod.cena FROM Proizvod
RIGHT JOIN Brend ON Proizvod.brend_id = Brend.brend_id
ORDER BY Proizvod.cena DESC
OFFSET 5 ROWS
FETCH NEXT 15 ROWS ONLY;
---------------------------------------------
--Ispisi gradove u kojima ima magacin i njihovu adresu
SELECT Grad.naziv_grada, Magacin.adresa FROM Grad
INNER JOIN Magacin
ON Magacin.grad_id = Grad.grad_id;
GO
----------------------------------------------------------------
--Svi proizvodi koji su kozenog materijala
SELECT Brend.naviz_brenda, Proizvod.naziv_proizvoda, cena, Materijali.naziv_materijala FROM Proizvod 
 RIGHT JOIN Brend ON Brend.brend_id = Proizvod.brend_id
 JOIN Materijali ON Materijali.materijal_id = Proizvod.materijal_id
WHERE Materijali.naziv_materijala='Koza'
ORDER BY cena ASC;



