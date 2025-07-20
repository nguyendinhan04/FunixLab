create database ASM1_cs2_2
go

USE [ASM1_cs2_2]
GO

CREATE TABLE [dbo].[Appearance_DIM](
	[Appearance_int] [int] IDENTITY(1,1) primary key,
	[FurLength] [varchar](13) NOT NULL,
	[MaturitySize] [varchar](13) NOT NULL)
GO


CREATE TABLE [dbo].[Breed_DIM](
	[Breed_id] [int] IDENTITY(1,1) PRIMARY KEY,
	[Breed] [varchar](255) NOT NULL)
GO

CREATE TABLE [dbo].[Color_DIM](
	[Color_id] [int] IDENTITY(1,1) PRIMARY KEY,
	[Color] [varchar](255) NOT NULL,
 )
GO


CREATE TABLE [dbo].[Gender_DIM](
	[Gender_id] [int] IDENTITY(1,1) PRIMARY KEY,
	[Gender] [varchar](6) NOT NULL,
)
GO

CREATE TABLE [dbo].[Health_DIM](
	[Health_id] [int] IDENTITY(1,1) PRIMARY KEY,
	[Health] [varchar](14) NOT NULL,
	[Dewormed] [varchar](8) NOT NULL,
	[Sterilized] [varchar](8) NOT NULL,
	[Vaccinated] [varchar](8) NOT NULL,
)
GO


CREATE TABLE [dbo].[State_DIM](
	[State_id] [int] IDENTITY(1,1) PRIMARY KEY,
	[State] [varchar](255) NOT NULL,
 )
GO

CREATE TABLE [dbo].[Type_DIM](
	[Type_id] [int] IDENTITY(1,1) PRIMARY KEY,
	[Type] [varchar](255) NOT NULL,
)
GO

CREATE TABLE [dbo].[Pet_FACT](
	[Pet_id] [int] PRIMARY KEY,
	[Type_id] [int] NOT NULL,
	[Age] [int] NOT NULL,
	[Breed1_id] [int] NOT NULL,
	[Breed2_id] [int] NULL,
	[Gender_id] [int] NOT NULL,
	[Color1_id] [int] NOT NULL,
	[Color2_id] [int] NULL,
	[Color3_id] [int] NULL,
	[Appearance_id] [int] NOT NULL,
	[Health_id] [int] NOT NULL,
	[State_id] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Fee] [int] NOT NULL,
	[Rescuer_id] [int] NOT NULL)
GO



select * from Pet_FACT;


alter table Pet_FACT 
add constraint type_pet_fact_fk foreign key (type_id) references [Type_DIM]([Type_id]);


alter table Pet_FACT 
add constraint breed1_pet_fact_fk foreign key ([breed1_id]) references [Breed_DIM]([Breed_id]);

alter table Pet_FACT 
add constraint breed2_pet_fact_fk foreign key ([breed2_id]) references [Breed_DIM]([Breed_id]);

alter table Pet_FACT 
add constraint gender_pet_fact_fk foreign key (Gender_id) references Gender_DIM(Gender_id);

alter table Pet_FACT 
add constraint color1_pet_fact_fk foreign key ([Color1_id]) references [Color_DIM]([Color_id]);

alter table Pet_FACT 
add constraint color2_pet_fact_fk foreign key ([Color2_id]) references [Color_DIM]([Color_id]);

alter table Pet_FACT 
add constraint color3_pet_fact_fk foreign key ([Color3_id]) references [Color_DIM]([Color_id]);

alter table Pet_FACT 
add constraint appearance_pet_fact_fk foreign key ([Appearance_id]) references [Appearance_DIM]([Appearance_int]);








create database CDC_ASM1_cs2_2
go

use [CDC_ASM1_cs2_2]
go


CREATE TABLE [dbo].[source](
	[Pet_id] [int] PRIMARY KEY,
	[Type] [varchar](3) NOT NULL,
	[Age] [int] NOT NULL,
	[Breed1] [varchar](255) NOT NULL,
	[Breed2] [varchar](255) NULL,
	[Gender] [varchar](6) NOT NULL,
	[Color1] [varchar](255) NOT NULL,
	[Color2] [varchar](255) NULL,
	[Color3] [varchar](255) NULL,
	[MaturitySize] [varchar](13) NOT NULL,
	[FurLength] [varchar](13) NOT NULL,
	[Vaccinated] [varchar](8) NOT NULL,
	[Dewormed] [varchar](8) NOT NULL,
	[Sterilized] [varchar](8) NOT NULL,
	[Health] [varchar](14) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Fee] [int] NOT NULL,
	[State] [varchar](255) NOT NULL,
	[RescuerID] [int] NOT NULL)
GO



