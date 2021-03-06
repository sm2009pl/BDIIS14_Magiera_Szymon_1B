
DROP FUNCTION IF EXISTS dbo.fn_ProduktyKtorychNieMa
GO
CREATE FUNCTION fn_ProduktyKtorychNieMa()
RETURNS TABLE
	AS
	RETURN
	(
		SELECT * FROM Produkty
		WHERE DostępnaIlość = 0
	);
	GO


DROP FUNCTION IF EXISTS dbo.fn_ProduktyKtoreSa
GO
CREATE FUNCTION fn_ProduktyKtoreSa()
RETURNS TABLE
	AS
	RETURN
	(
		SELECT * FROM Produkty
		WHERE DostępnaIlość != 0
	);
	GO

DROP FUNCTION IF EXISTS dbo.fn_PracownicyNaUrlopie
GO
CREATE FUNCTION fn_PracownicyNaUrlopie()
RETURNS TABLE
	AS
	RETURN
	(
		SELECT Pracownicy.Imię, Pracownicy.Nazwisko FROM Pracownicy
		INNER JOIN Urlopy ON
		Pracownicy.IDPracownika = Urlopy.IDPracownika
		WHERE Urlopy.DataZakończenia IS NULL OR Urlopy.DataZakończenia > GETDATE()
	);
	GO


DROP FUNCTION IF EXISTS dbo.fn_DostawyOczekujaceBrakProduktu
GO
CREATE FUNCTION fn_DostawyOczekujaceBrakProduktu()
RETURNS TABLE
	AS
	RETURN
	(
		SELECT Dostawy.IDDostawy, SzczegółyDostawy.IDProduktu FROM Dostawy
		INNER JOIN SzczegółyDostawy ON
		SzczegółyDostawy.IDDostawy = Dostawy.IDDostawy
		INNER JOIN Produkty ON
		Produkty.IDProduktu = SzczegółyDostawy.IDProduktu
		WHERE DostępnaIlość = 0
	);
	GO



