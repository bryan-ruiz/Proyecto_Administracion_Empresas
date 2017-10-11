/*
Tabla dimensiones, contiene las dimensiones las cuales son parte de los componentes
*/
USE [Proyecto bases];
GO
CREATE TABLE Dimensiones(
	ID			INT	IDENTITY(1,1)	NOT NULL,
	Dimension	VARCHAR(50)			NOT NULL	UNIQUE,
	CONSTRAINT PK_Dimensiones_ID PRIMARY KEY CLUSTERED (ID)
);
GO

/*
Tabla componentes, contiene los componentes que son parte de un criterio a la hora de su evaluación
*/
USE [Proyecto bases];
GO
CREATE TABLE Componentes(
	ID				INT	IDENTITY(1,1)	NOT NULL,
	ID_Dimension	INT,
	Componente		VARCHAR(50)			NOT NULL	UNIQUE,
	CONSTRAINT PK_Componentes_ID			PRIMARY KEY CLUSTERED (ID),
	CONSTRAINT FK_Componentes_ID_Dimension	FOREIGN KEY (ID_Dimension) 
		REFERENCES	dbo.Dimensiones (ID) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

/*
Tabla CYE, contiene los criterios y estandares propuestos/inpuestos por SINAES
*/
USE [Proyecto bases];
GO
CREATE TABLE CYE(
	ID				INT	IDENTITY(1,1)	NOT NULL,
	ID_Componente	INT,
	Criterio		VARCHAR (300)		NOT NULL	UNIQUE,
	CONSTRAINT PK_CYE_ID			PRIMARY KEY CLUSTERED (ID),
	CONSTRAINT FK_CYE_ID_Componente FOREIGN KEY (ID_Componente) 
		REFERENCES	dbo.Componentes (ID) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

/*
Tabla sedes, contiene todas las sedes del Tecnológico
*/
USE [Proyecto bases];
GO
CREATE TABLE Sedes(
	ID		INT	IDENTITY(1,1)		NOT NULL,
	Sede	VARCHAR(50)				NOT NULL	UNIQUE,
	CONSTRAINT PK_Sedes_ID			PRIMARY KEY CLUSTERED (ID)
);
GO

/*
Tabla carreras, contiene todas las carreras del TEC en general
*/
USE [Proyecto bases];
GO
CREATE TABLE Carreras(
	ID			INT	IDENTITY(1,1)	NOT NULL,
	ID_Sede		INT					NOT NULL,
	Carrera		VARCHAR(50)			NOT NULL	UNIQUE,
	CONSTRAINT PK_Carreras_ID		PRIMARY KEY CLUSTERED (ID),
	CONSTRAINT FK_Carreras_ID_Sede	FOREIGN KEY (ID_Sede) 
		REFERENCES	dbo.Sedes (ID) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

/*
Tabla autoevaluaciones anuales, dichas evaluaciones se relacionan a una persona quien es el encargado principal 
de dicha evaluación
*/
USE [Proyecto bases];
GO
CREATE TABLE AutoevaluacionesAnuales(
	ID				INT	IDENTITY(1,1)		 NOT NULL,
	ID_Encargado	INT						 NOT NULL,
	Anio			INT						 NOT NULL,
	CONSTRAINT PK_AutoevaluacionesAnuales_ID PRIMARY KEY CLUSTERED (ID)
);
GO

/*
Tabla Auto_CYEA, tabla que sale producto de la normalización entre las tablas AutoevaluacionesAnuales y CYEA y contiene 
cada todos los criterios que se asocian a un usuario administrador encargado de la evaluación de una carrera
*/
-- revisar que esten bien estas claves foraneas
USE [Proyecto bases];
GO
CREATE TABLE Auto_CYEA(
	ID_Autoeval		INT,
	ID_CYEA			INT,
	CONSTRAINT FK_AutoevaluacionesAnuales_ID_Autoeval	FOREIGN KEY (ID_Autoeval) 
		REFERENCES	dbo.AutoevaluacionesAnuales (ID) ON DELETE CASCADE ON UPDATE CASCADE,
	CONSTRAINT FK_Auto_CYEA_ID_CYEA	FOREIGN KEY (ID_CYEA) 
		REFERENCES	dbo.CYEA (ID) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

/*
Tabla NivelesIAE, contiene los niveles IAE
*/
USE [Proyecto bases];
GO
CREATE TABLE NivelesIAE(
	ID			INT	IDENTITY(1,1)			NOT NULL,
	NivelIAE	VARCHAR(50)					NOT NULL	UNIQUE,
	CONSTRAINT PK_NivelesIAE_ID PRIMARY KEY CLUSTERED (ID)
);
GO

/*
Tabla Valoraciones, contiene las valoraciones las cuales serán en escala de malo hasta excelente
*/
USE [Proyecto bases];
GO
CREATE TABLE Valoraciones(
	ID			INT	IDENTITY(1,1)			NOT NULL,
	Valoracion	VARCHAR(50)					NOT NULL	UNIQUE,
	CONSTRAINT PK_Valoraciones_ID PRIMARY KEY CLUSTERED (ID)
);
GO

/*
Tabla Valoraciones, contiene las valoraciones las cuales serán en escala de malo hasta excelente
*/
USE [Proyecto bases];
GO
CREATE TABLE CumplimientosNominales(
	ID					INT	IDENTITY(1,1)	NOT NULL,
	FechaCumplimiento	DATE				NOT NULL,
	CONSTRAINT PK_Valoraciones_ID PRIMARY KEY CLUSTERED (ID)
);
GO