USE [Weterynaryjna Klinika]
GO

/****** Object:  Trigger [dbo].[sprawdzenieDatDostawy]    Script Date: 25/05/2020 02:50:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [dbo].[sprawdzenieDatDostawy] ON [dbo].[Dostawy]
FOR INSERT
NOT FOR REPLICATION
AS 
IF (SELECT COUNT(*) FROM inserted)>=1
BEGIN
	IF((SELECT DataZam�wienia from inserted) > GETDATE())
	BEGIN RAISERROR('Data zamowienia nie mo�e by� p�niejsza ni� dzie� dzisiejszy',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT DataP�atno�ci from inserted) > GETDATE() AND (SELECT DataP�atno�ci from inserted) > (SELECT DataZam�wienia from inserted))
	BEGIN RAISERROR('Data p�atno�ci nie mo�e by� p�niejsza ni� dzie� dzisiejszy i data zam�wienia',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT DataRealizacji from inserted) > GETDATE() AND (SELECT DataRealizacji from inserted) > (SELECT DataP�atno�ci from inserted) 
		AND (SELECT DataP�atno�ci from inserted) IS NOT NULL)
	BEGIN RAISERROR('Data realizacji nie mo�e by� p�niejsza ni� dzie� dzisiejszy i data p�atno�ci',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT KwotaZam�wieniaNetto from inserted) < 0)
	BEGIN RAISERROR('Kwota zam�wienia nie mo�e by� mniejsza ni� 0',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT PodatekProcent from inserted) < 0)
	BEGIN RAISERROR('Podatek nie mo�e mie� warto�ci mniejszej ni� 0',16,1)
	ROLLBACK TRANSACTION
	END
END
GO

ALTER TABLE [dbo].[Dostawy] ENABLE TRIGGER [sprawdzenieDatDostawy]
GO


USE [Weterynaryjna Klinika]
GO

/****** Object:  Trigger [dbo].[sprawdzenieRodzajowZabiegow]    Script Date: 25/05/2020 02:50:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[sprawdzenieRodzajowZabiegow] ON [dbo].[RodzajeZabieg�w]
FOR INSERT
NOT FOR REPLICATION
AS 
IF (SELECT COUNT(*) FROM inserted)>=1
BEGIN
	IF((SELECT PodatekRodzaju from inserted) < 0)
	BEGIN RAISERROR('Podatek nie mo�e by� mniejszy ni� 0',16,1)
	ROLLBACK TRANSACTION
	END
END
GO

ALTER TABLE [dbo].[RodzajeZabieg�w] ENABLE TRIGGER [sprawdzenieRodzajowZabiegow]
GO


USE [Weterynaryjna Klinika]
GO

/****** Object:  Trigger [dbo].[sprawdzenieParamProduktow]    Script Date: 25/05/2020 02:50:47 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[sprawdzenieParamProduktow] ON [dbo].[Produkty]
FOR INSERT
NOT FOR REPLICATION
AS 
IF (SELECT COUNT(*) FROM inserted)>=1
BEGIN
	IF((SELECT Dost�pnaIlo�� from inserted) < 0)
	BEGIN RAISERROR('Dost�pna ilo�� nie mo�e by� mniejsza ni� 0',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT CenaZaSztuk�Netto from inserted) < 0)
	BEGIN RAISERROR('Cena za sztuk� nie mo�e by� mniejsza ni� 0',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT PodatekProcent from inserted) < 0)
	BEGIN RAISERROR('Podatek nie mo�e by� mniejszy ni� 0',16,1)
	ROLLBACK TRANSACTION
	END
END
GO

ALTER TABLE [dbo].[Produkty] ENABLE TRIGGER [sprawdzenieParamProduktow]
GO


USE [Weterynaryjna Klinika]
GO

/****** Object:  Trigger [dbo].[sprawdzenieDatPracownikow]    Script Date: 25/05/2020 02:50:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE TRIGGER [dbo].[sprawdzenieDatPracownikow] ON [dbo].[Pracownicy]
FOR INSERT
NOT FOR REPLICATION
AS 
IF (SELECT COUNT(*) FROM inserted)>=1
BEGIN
	IF((SELECT DataUrodzenia from inserted) > GETDATE() )
	BEGIN RAISERROR('Data urodzenia nie mo�e by� p�niejsza ni� dzie� dzisiejszy',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT DataZatrudnienia from inserted) > GETDATE() AND DATEDIFF(YY,(SELECT DataUrodzenia from inserted),(SELECT DataZatrudnienia from inserted)) < 18)
	BEGIN RAISERROR('Data zatrudnienia nie mo�e by� p�niejsza ni� dzie� dzisiejszy i data urodzenia musi by� przynajmniej 18 lat wcze�niejsza ni� data zatrudnienia',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT DataZwolnienia from inserted) > GETDATE() AND (SELECT DataZatrudnienia from inserted) < (SELECT DataZwolnienia from inserted)) 
	BEGIN RAISERROR('Data zwolnienia nie mo�e by� p�niejsza ni� dzie� dzisiejszy i data zatrudnienia nie mo�e by� p�niej ni� data zwolnienia',16,1)
	ROLLBACK TRANSACTION
	END
END
GO

ALTER TABLE [dbo].[Pracownicy] ENABLE TRIGGER [sprawdzenieDatPracownikow]
GO


USE [Weterynaryjna Klinika]
GO

/****** Object:  Trigger [dbo].[sprawdzenieParamZakupu]    Script Date: 25/05/2020 02:51:23 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [dbo].[sprawdzenieParamZakupu] ON [dbo].[Zakupy]
FOR INSERT
NOT FOR REPLICATION
AS 
IF (SELECT COUNT(*) FROM inserted)>=1
BEGIN
	IF((SELECT DataZakupu from inserted) > GETDATE())
	BEGIN RAISERROR('Data zakupu nie mo�e by� p�niejsza ni� dzie� dzisiejszy',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT KwotaZakupuBrutto from inserted) < 0)
	BEGIN RAISERROR('Kwota zakupu nie mo�e by� mniejsza ni� 0',16,1)
	ROLLBACK TRANSACTION
	END
END
GO

ALTER TABLE [dbo].[Zakupy] ENABLE TRIGGER [sprawdzenieParamZakupu]
GO


USE [Weterynaryjna Klinika]
GO

/****** Object:  Trigger [dbo].[sprawdzenieParamUrlopu]    Script Date: 25/05/2020 02:51:18 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [dbo].[sprawdzenieParamUrlopu] ON [dbo].[Urlopy]
FOR INSERT
NOT FOR REPLICATION
AS 
IF (SELECT COUNT(*) FROM inserted)>=1
BEGIN
	IF((SELECT DataRozpocz�cia from inserted) > GETDATE())
	BEGIN RAISERROR('Data rozpocz�cia urlopu nie mo�e by� p�niejsza ni� dzie� dzisiejszy',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT DataZako�czenia from inserted) > GETDATE() AND (SELECT DataRozpocz�cia from inserted) > (SELECT DataZako�czenia from inserted))
	BEGIN RAISERROR('Data zako�czenia nie mo�e by� p�niejsza ni� dzie� dzisiejszy i da',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT P�atno�� from inserted) < 0)
	BEGIN RAISERROR('P�atno�� nie mo�e mie� warto�ci mniejszej ni� 0',16,1)
	ROLLBACK TRANSACTION
	END
END
GO

ALTER TABLE [dbo].[Urlopy] ENABLE TRIGGER [sprawdzenieParamUrlopu]
GO


USE [Weterynaryjna Klinika]
GO

/****** Object:  Trigger [dbo].[sprawdzenieParamZabiegow]    Script Date: 25/05/2020 02:51:15 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [dbo].[sprawdzenieParamZabiegow] ON [dbo].[Zabiegi]
FOR INSERT
NOT FOR REPLICATION
AS 
IF (SELECT COUNT(*) FROM inserted)>=1
BEGIN
	IF((SELECT DataZabiegu from inserted) > GETDATE())
	BEGIN RAISERROR('Data rozpocz�cia zabiegu nie mo�e by� p�niejsza ni� dzie� dzisiejszy',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT CenaZabiegu from inserted) < 0)
	BEGIN RAISERROR('Cena zabiegu nie mo�e mie� warto�ci mniejszej ni� 0',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT PodatekZabiegu from inserted) < 0)
	BEGIN RAISERROR('Podatek zabiegu nie mo�e mie� warto�ci mniejszej ni� 0',16,1)
	ROLLBACK TRANSACTION
	END
END
GO

ALTER TABLE [dbo].[Zabiegi] ENABLE TRIGGER [sprawdzenieParamZabiegow]
GO


USE [Weterynaryjna Klinika]
GO

/****** Object:  Trigger [dbo].[sprawdzenieParamZwierzat]    Script Date: 25/05/2020 02:51:38 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE TRIGGER [dbo].[sprawdzenieParamZwierzat] ON [dbo].[Zwierz�ta]
FOR INSERT
NOT FOR REPLICATION
AS 
IF (SELECT COUNT(*) FROM inserted)>=1
BEGIN
	IF((SELECT Masa from inserted) <= 0)
	BEGIN RAISERROR('Masa zwierz�cia nie mo�e by� mniejsza lub r�wna 0',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT Wysoko�� from inserted) <= 0)
	BEGIN RAISERROR('Wysoko�� zwierz�cia nie mo�e by� mniejsza lub r�wna 0',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT D�ugo�� from inserted) <= 0)
	BEGIN RAISERROR('D�ugo�� nie mo�e mie� warto�ci mniejszej lub r�wna 0',16,1)
	ROLLBACK TRANSACTION
	END
END
GO

ALTER TABLE [dbo].[Zwierz�ta] ENABLE TRIGGER [sprawdzenieParamZwierzat]
GO


