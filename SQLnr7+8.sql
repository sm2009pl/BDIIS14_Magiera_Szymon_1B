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
	IF((SELECT DataZamówienia from inserted) > GETDATE())
	BEGIN RAISERROR('Data zamowienia nie mo¿e byæ póŸniejsza ni¿ dzieñ dzisiejszy',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT DataP³atnoœci from inserted) > GETDATE() AND (SELECT DataP³atnoœci from inserted) > (SELECT DataZamówienia from inserted))
	BEGIN RAISERROR('Data p³atnoœci nie mo¿e byæ póŸniejsza ni¿ dzieñ dzisiejszy i data zamówienia',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT DataRealizacji from inserted) > GETDATE() AND (SELECT DataRealizacji from inserted) > (SELECT DataP³atnoœci from inserted) 
		AND (SELECT DataP³atnoœci from inserted) IS NOT NULL)
	BEGIN RAISERROR('Data realizacji nie mo¿e byæ póŸniejsza ni¿ dzieñ dzisiejszy i data p³atnoœci',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT KwotaZamówieniaNetto from inserted) < 0)
	BEGIN RAISERROR('Kwota zamówienia nie mo¿e byæ mniejsza ni¿ 0',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT PodatekProcent from inserted) < 0)
	BEGIN RAISERROR('Podatek nie mo¿e mieæ wartoœci mniejszej ni¿ 0',16,1)
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


CREATE TRIGGER [dbo].[sprawdzenieRodzajowZabiegow] ON [dbo].[RodzajeZabiegów]
FOR INSERT
NOT FOR REPLICATION
AS 
IF (SELECT COUNT(*) FROM inserted)>=1
BEGIN
	IF((SELECT PodatekRodzaju from inserted) < 0)
	BEGIN RAISERROR('Podatek nie mo¿e byæ mniejszy ni¿ 0',16,1)
	ROLLBACK TRANSACTION
	END
END
GO

ALTER TABLE [dbo].[RodzajeZabiegów] ENABLE TRIGGER [sprawdzenieRodzajowZabiegow]
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
	IF((SELECT DostêpnaIloœæ from inserted) < 0)
	BEGIN RAISERROR('Dostêpna iloœæ nie mo¿e byæ mniejsza ni¿ 0',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT CenaZaSztukêNetto from inserted) < 0)
	BEGIN RAISERROR('Cena za sztukê nie mo¿e byæ mniejsza ni¿ 0',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT PodatekProcent from inserted) < 0)
	BEGIN RAISERROR('Podatek nie mo¿e byæ mniejszy ni¿ 0',16,1)
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
	BEGIN RAISERROR('Data urodzenia nie mo¿e byæ póŸniejsza ni¿ dzieñ dzisiejszy',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT DataZatrudnienia from inserted) > GETDATE() AND DATEDIFF(YY,(SELECT DataUrodzenia from inserted),(SELECT DataZatrudnienia from inserted)) < 18)
	BEGIN RAISERROR('Data zatrudnienia nie mo¿e byæ póŸniejsza ni¿ dzieñ dzisiejszy i data urodzenia musi byæ przynajmniej 18 lat wczeœniejsza ni¿ data zatrudnienia',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT DataZwolnienia from inserted) > GETDATE() AND (SELECT DataZatrudnienia from inserted) < (SELECT DataZwolnienia from inserted)) 
	BEGIN RAISERROR('Data zwolnienia nie mo¿e byæ póŸniejsza ni¿ dzieñ dzisiejszy i data zatrudnienia nie mo¿e byæ póŸniej ni¿ data zwolnienia',16,1)
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
	BEGIN RAISERROR('Data zakupu nie mo¿e byæ póŸniejsza ni¿ dzieñ dzisiejszy',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT KwotaZakupuBrutto from inserted) < 0)
	BEGIN RAISERROR('Kwota zakupu nie mo¿e byæ mniejsza ni¿ 0',16,1)
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
	IF((SELECT DataRozpoczêcia from inserted) > GETDATE())
	BEGIN RAISERROR('Data rozpoczêcia urlopu nie mo¿e byæ póŸniejsza ni¿ dzieñ dzisiejszy',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT DataZakoñczenia from inserted) > GETDATE() AND (SELECT DataRozpoczêcia from inserted) > (SELECT DataZakoñczenia from inserted))
	BEGIN RAISERROR('Data zakoñczenia nie mo¿e byæ póŸniejsza ni¿ dzieñ dzisiejszy i da',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT P³atnoœæ from inserted) < 0)
	BEGIN RAISERROR('P³atnoœæ nie mo¿e mieæ wartoœci mniejszej ni¿ 0',16,1)
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
	BEGIN RAISERROR('Data rozpoczêcia zabiegu nie mo¿e byæ póŸniejsza ni¿ dzieñ dzisiejszy',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT CenaZabiegu from inserted) < 0)
	BEGIN RAISERROR('Cena zabiegu nie mo¿e mieæ wartoœci mniejszej ni¿ 0',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT PodatekZabiegu from inserted) < 0)
	BEGIN RAISERROR('Podatek zabiegu nie mo¿e mieæ wartoœci mniejszej ni¿ 0',16,1)
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



CREATE TRIGGER [dbo].[sprawdzenieParamZwierzat] ON [dbo].[Zwierzêta]
FOR INSERT
NOT FOR REPLICATION
AS 
IF (SELECT COUNT(*) FROM inserted)>=1
BEGIN
	IF((SELECT Masa from inserted) <= 0)
	BEGIN RAISERROR('Masa zwierzêcia nie mo¿e byæ mniejsza lub równa 0',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT Wysokoœæ from inserted) <= 0)
	BEGIN RAISERROR('Wysokoœæ zwierzêcia nie mo¿e byæ mniejsza lub równa 0',16,1)
	ROLLBACK TRANSACTION
	END
	IF((SELECT D³ugoœæ from inserted) <= 0)
	BEGIN RAISERROR('D³ugoœæ nie mo¿e mieæ wartoœci mniejszej lub równa 0',16,1)
	ROLLBACK TRANSACTION
	END
END
GO

ALTER TABLE [dbo].[Zwierzêta] ENABLE TRIGGER [sprawdzenieParamZwierzat]
GO


