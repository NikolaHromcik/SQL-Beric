USE Beric;
GO

INSERT Tip_Proizvoda VALUES
('sat'),
('aksesoar'),
('nakit');

SELECT * FROM Tip_Proizvoda;
-------------------------------------------

INSERT Pol VALUES
('musko'),
('zensko'),
('uniseks');

SELECT * FROM Pol;
------------------------------------------

ALTER TABLE Grad
ADD postanski_broj int;

INSERT Grad VALUES
('Beograd', 101801),
('Novi Sad', 123456),
('Nis', 213267),
('Pancevo',179458),
('Zrenjanin',262155),
('Vrsac', 123678),
('Sabac',334422),
('Kragujevac',653321),
('Vranje',125543),
('Krusevac',953246),
('Subotica',234564),
('Uzice',455623),
('Smederevo',254793);

SELECT * FROM Grad;
---------------------------

INSERT Materijali VALUES
('Celik'),
('Zlato'),
('Srebro'),
('Platina'),
('Guma'),
('Koza'),
('Plastika'),
('Tekstil'),
('Titanijum'),
('Keramika');

SELECT * FROM Materijali;
-------------------------------------

INSERT Kategorije VALUES
('Kvarcni',1),
('Mehanicki',1),
('Digitalni',1),
('Ogrlica',3),
('Narukvica',3),
('Mindjuse',3),
('Prstenje',3),
('Kajsevi',2),
('Upaljaci',2),
('Novcanici',2);

SELECT * FROM Kategorije;
/*
SELECT Tip_Proizvoda.naziv_tipa, Kategorije.naziv_kategorije FROM Tip_Proizvoda 
RIGHT JOIN Kategorije ON Tip_Proizvoda.tip_id = Kategorije.tip_id WHERE Tip_Proizvoda.tip_id =1;


INSERT Kategorije_Proizvoda VALUES
(1,1),
(1,2),
(1,3),
(1,4),
(1,5),
(1,6),
(1,7),
(1,8),
(1,9),
(1,10),
(2,1),
(2,2),
(2,3),
(2,4),
(2,5),
(2,6),
(2,7),
(2,8),
(2,9),
(2,10),
(3,1),
(3,2),
(3,3),
(3,4),
(3,5);
SELECT * FROM Kategorije_Proizvoda;

SELECT Kategorije_Proizvoda.Kproizvoda_id, Kategorije_Proizvoda.pol_id, Kategorije_Proizvoda.kategorija_id, Kategorije.naziv_kategorije FROM Kategorije_Proizvoda
RIGHT JOIN Kategorije ON Kategorije_Proizvoda.kategorija_id = Kategorije.kategorija_id;
-----------------------------------
INSERT Materijal_Proizvoda VALUES
(1,105),
(1,115),
(1,125),
(1,106),
(1,116),
(1,126),
(1,107),
(1,117),
(1,127),
(1,108),
(1,118),
(1,128),
(1,109),
(1,119),
(1,129),
(1,110),
(1,120),
(1,111),
(1,121),
(1,113),
(1,123),
(2,106),
(2,116),
(2,126),
(2,108),
(2,118),
(2,128),
(2,109),
(2,119),
(2,129),
(2,111),
(2,121),
(3,106),
(3,116),
(3,126),
(3,108),
(3,118),
(3,128),
(3,109),
(3,119),
(3,129),
(3,111),
(3,121),
(4,106),
(4,116),
(4,126),
(4,108),
(4,118),
(4,128),
(4,109),
(4,119),
(4,129),
(4,101),
(4,121),
(2,106),
(9,116),
(9,126),
(9,108),
(9,118),
(9,128),
(9,109),
(9,119),
(9,129),
(9,111),
(9,121),
(10,111),
(10,121),
(10,105),
(10,115),
(10,125),
(5,105),
(5,115),
(5,125),
(5,106),
(5,116),
(5,126),
(5,107),
(5,117),
(5,127),
(5,109),
(5,119),
(5,129),
(5,112),
(5,122),
(6,105),
(6,115),
(6,125),
(6,106),
(6,116),
(6,126),
(6,109),
(6,119),
(6,129),
(6,112),
(6,122),
(6,118),
(6,128),
(6,108),
(6,114),
(6,124),
(7,107),
(7,117),
(7,127),
(8,112),
(8,122),
(8,114),
(8,124);
SELECT * FROM Materijal_Proizvoda;
*/
---------------------------------------------
INSERT Brend VALUES
('Casio',1),
('Seiko',1),
('Fossil',1),
('G-Shock',1),
('Daniel Wellington',1),
('Longines',1),
('Swatch',1),
('Vostok',1),
('Orient',1),
('Tissot',1),
('Citizen',1),
('2Jewels',3),
('DIESEL',3),
('GUESS',3),
('GUCCI',3),
('Victoria Cruz',3),
('Tommy Hilfiger',3),
('Majorica',3),
('PANDORA',3),
('Calvin Klein',3),
('ZIPPO',2),
('DUCATI',2),
('Colibri',2),
('Condor',2),
('Morellato',2),
('POLICE',2);

SELECT * FROM Brend;
--------------------------------

INSERT Proizvod VALUES
('B640WD',1,7540,3,1,3),
('CA-53WF',1,5530,3,7,1),
('MTP-1314',1,4590,1,6,1),
('LTP-1302',1,5810,1,1,2),
('SRPG35K1',2,33750,2,8,1),
('SPRE05K1',2,76250,2,5,1),
('SSH001J1',2,275000,2,9,1),
('SRPD69K1',2,42500,2,1,3),
('BQ3659',3,19500,1,1,2),
('ES5006',3,13390,1,1,2),
('FS57192',3,22990,1,1,1),
('GA2110',4,13500,1,7,1),
('GMA-B800',4,18890,1,7,3),
('SQ-5600',4,16540,3,7,3),
('GST-B100D',4,54470,1,1,1),
('DW00100025',5,21730,1,6,1),
('DW001005',5,18280,1,8,3),
('DQ0010056',5,19430,1,6,2),
('L2.409',6,94450,2,6,2),
('L3.781',6,125000,2,9,1),
('L4.709',6,173540,2,1,2),
('L5.512',6,179640,2,6,2),
('YLS141',7,43200,1,10,2),
('YCS485',7,55000,2,10,2),
('GZ353',7,24000,1,7,3),
('YVS478',7,26500,2,5,1),
('YN84',8,69480,2,6,1),
('6S21',8,92280,2,6,1),
('NH35A',8,80280,2,5,1),
('VK64',8,46280,1,1,2),
('RA-NB01',9,24650,1,6,2),
('RA-AG00',9,38730,2,1,2),
('RA-KV05',9,25450,2,8,1),
('RA-AK06',9,34340,2,5,1),
('T137',10,56000,2,1,1),
('T116',10,625230,2,6,1),
('T120',10,88240,2,5,1),
('T101',10,67550,2,1,2),
('T125',10,73300,2,8,1),
('EM0192',11,38800,1,1,2),
('BN0158',11,25990,2,5,1),
('BM8560',11,29990,2,9,1),
('B620',11,25990,1,3,1),
('251436',12,4400,4,1,3),
('232143',12,3830,5,1,2),
('261339',12,2700,6,1,2),
('261774',12,6400,6,2,2),
('DX11225',13,11590,5,1,1),
('DX00014',13,8490,4,10,1),
('DX11480',13,10390,4,1,1),
('JUBE0144',14,4400,7,1,2),
('UBB29075',14,4400,5,1,2),
('UBN2299',14,22200,4,3,2),
('UBB700',14,11100,5,1,2),
('YBC0723',15,153333,7,2,3),
('YBC081I',15,78667,7,2,3),
('YBB365',15,86677,4,9,2),
('A3616',16,8040,6,1,2),
('A3061',16,7320,5,1,2),
('A1056',16,7560,5,1,2),
('27006',17,7461,5,10,1),
('27505',17,7490,6,10,2),
('27901',17,7190,5,6,1),
('13641',18,21240,5,10,2),
('16346',18,20520,5,3,2),
('12832',18,18360,4,1,2),
('59934',19,38870,5,3,2),
('18091',19,19270,7,1,2),
('59074',19,16770,4,1,2),
('KJ3UM',20,28540,4,3,2),
('KJ6GJ',20,15400,5,1,2),
('KJ6VP',20,12000,6,1,2),
('49272',21,10650,9,1,1),
('Z4919',21,4540,9,1,2),
('Z218H',21,4409,9,1,1),
('DLTUG',22,6990,10,6,1),
('DLTGW',22,10990,10,6,1),
('QTR8',23,3370,9,1,1),
('LI30',23,4469,9,1,2),
('613R',24,2290,8,6,1),
('241R',24,1590,8,6,2),
('630R',24,4330,8,6,1),
('SABK0',25,5832,7,1,2),
('SCZ0',25,5670,4,1,2),
('PTC045',26,5290,10,6,1),
('PTC046',26,2990,10,6,1);

SELECT * FROM Proizvod;
---------------------------

INSERT Magacin VALUES
('Cvijiceva 45',0633467898,1),
('Bulevar Oslobodjenja 27a',066557473,2),
('13. Maj', 0621337690,3),
('Vuka Karadzica',0640325956,7),
('Partizanska',0637894098,8);

SELECT * FROM Magacin;
----------------------------------
INSERT Klijenti VALUES
('Mika','Mikic','Njegoseva 11',1),
('Pera','Peric','Prizrenska 55',1),
('Ilija','Subotic','5. Oktobar 121',1),
('Vladimir','Sretenovic','Rumenacka 22',2),
('Sara','Djenic','Fruskogorska 88',2),
('Simona','Djuric','Maglicka 8',2),
('Timotej','Kovac','Marsala Tita',3),
('Radomir','Jovanovic','Bulevar Slobode 54',3),
('Misa','Perusic','Prizrenska 43',4),
('Vanja','Savic','Ive Lole Ribara',5),
('Sanja','Aleksic','Mihajla Pupina',6),
('Dusica','Stevanovic','JNA 1',7),
('Aleksa','Misic','Grcka 22',8),
('Milos','Crnjanski','Belinarska 43',9),
('Nikola','Sretenovic','Milosa Obrenovica 4',10),
('Ivana','Jahovic','Cara Dusana',11),
('Marina','Bogic','Zeleni Venac',12),
('Miroslav','Kesic','Veljka Vlahovica 8',13);

SELECT * FROM Klijenti;

INSERT Artikal VALUES
(33,12,1),
(45,13,5),
(21,1,2),
(55,4,3),
(77,8,5),
(82,15,4),
(86,18,3),
(1,5,2),
(3,12,1),
(5,8,1),
(9,6,3),
(13,3,1),
(16,9,3),
(2,4,2),
(5,7,2),
(8,8,4),
(10,2,3),
(20,11,5),
(14,15,3),
(29,11,1),
(33,15,3),
(47,2,1),
(58,5,2),
(66,6,3),
(50,3,2),
(80,15,5),
(78,12,4),
(36,8,1),
(44,3,1),
(54,4,2),
(17,6,2),
(21,3,1),
(28,4,2),
(75,6,4),
(18,2,1),
(67,8,3),
(54,3,2),
(43,2,1),
(12,3,4),
(56,4,3),
(76,5,4),
(17,8,2),
(24,8,3),
(48,12,4),
(56,11,2),
(4,2,2),
(6,4,2),
(7,5,2),
(10,2,1),
(16,3,1),
(22,4,2),
(13,3,1);

SELECT * FROM Artikal;

UPDATE Artikal
SET klijent_id = 1
WHERE id_artikal = 10;

SELECT * FROM Artikal;


DELETE FROM Artikal
WHERE magacin_id = 5;

SELECT * FROM Artikal ORDER BY magacin_id DESC;




