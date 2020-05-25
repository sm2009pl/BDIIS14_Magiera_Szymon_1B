
DROP FUNCTION IF EXISTS dbo.fn_ProduktyKtorychNieMa
GO
CREATE FUNCTION fn_ProduktyKtorychNieMa()
RETURNS TABLE
	AS
	RETURN
	(
		SELECT * FROM Produkty
		WHERE Dost�pnaIlo�� = 0
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
		WHERE Dost�pnaIlo�� != 0
	);
	GO

DROP FUNCTION IF EXISTS dbo.fn_PracownicyNaUrlopie
GO
CREATE FUNCTION fn_PracownicyNaUrlopie()
RETURNS TABLE
	AS
	RETURN
	(
		SELECT Pracownicy.Imi�, Pracownicy.Nazwisko FROM Pracownicy
		INNER JOIN Urlopy ON
		Pracownicy.IDPracownika = Urlopy.IDPracownika
		WHERE Urlopy.DataZako�czenia IS NULL OR Urlopy.DataZako�czenia > GETDATE()
	);
	GO


DROP FUNCTION IF EXISTS dbo.fn_DostawyOczekujaceBrakProduktu
GO
CREATE FUNCTION fn_DostawyOczekujaceBrakProduktu()
RETURNS TABLE
	AS
	RETURN
	(
		SELECT Dostawy.IDDostawy, Szczeg�yDostawy.IDProduktu FROM Dostawy
		INNER JOIN Szczeg�yDostawy ON
		Szczeg�yDostawy.IDDostawy = Dostawy.IDDostawy
		INNER JOIN Produkty ON
		Produkty.IDProduktu = Szczeg�yDostawy.IDProduktu
		WHERE Dost�pnaIlo�� = 0
	);
	GO



