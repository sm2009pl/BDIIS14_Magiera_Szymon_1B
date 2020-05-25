
DROP FUNCTION IF EXISTS dbo.fn_ProduktyKtorychNieMa
GO
CREATE FUNCTION fn_ProduktyKtorychNieMa()
RETURNS TABLE
	AS
	RETURN
	(
		SELECT * FROM Produkty
		WHERE DostêpnaIloœæ = 0
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
		WHERE DostêpnaIloœæ != 0
	);
	GO

DROP FUNCTION IF EXISTS dbo.fn_PracownicyNaUrlopie
GO
CREATE FUNCTION fn_PracownicyNaUrlopie()
RETURNS TABLE
	AS
	RETURN
	(
		SELECT Pracownicy.Imiê, Pracownicy.Nazwisko FROM Pracownicy
		INNER JOIN Urlopy ON
		Pracownicy.IDPracownika = Urlopy.IDPracownika
		WHERE Urlopy.DataZakoñczenia IS NULL OR Urlopy.DataZakoñczenia > GETDATE()
	);
	GO


DROP FUNCTION IF EXISTS dbo.fn_DostawyOczekujaceBrakProduktu
GO
CREATE FUNCTION fn_DostawyOczekujaceBrakProduktu()
RETURNS TABLE
	AS
	RETURN
	(
		SELECT Dostawy.IDDostawy, Szczegó³yDostawy.IDProduktu FROM Dostawy
		INNER JOIN Szczegó³yDostawy ON
		Szczegó³yDostawy.IDDostawy = Dostawy.IDDostawy
		INNER JOIN Produkty ON
		Produkty.IDProduktu = Szczegó³yDostawy.IDProduktu
		WHERE DostêpnaIloœæ = 0
	);
	GO



