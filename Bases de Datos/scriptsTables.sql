/*
Tabla dimensiones, contiene las dimensiones las cuales son parte de los componentes
*/
USE ProyectoComunidad;
GO
CREATE TABLE Dimensiones(
	ID			INT	IDENTITY(1,1)	NOT NULL,
	Dimension	VARCHAR(50)			NOT NULL	UNIQUE,
	CONSTRAINT PK_Dimensiones_ID PRIMARY KEY CLUSTERED (ID)
);
GO

/*
Tabla componentes, contiene los componentes que son parte de un criterio a la hora de su evaluaci�n
*/
USE ProyectoComunidad;
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
USE ProyectoComunidad;
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
Tabla sedes, contiene todas las sedes del Tecnol�gico
*/
USE ProyectoComunidad;
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
USE ProyectoComunidad;
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
de dicha evaluaci�n
*/
USE ProyectoComunidad;
GO
CREATE TABLE AutoevaluacionesAnuales(
	ID				INT	IDENTITY(1,1)		 NOT NULL,
	ID_Encargado	INT						 NOT NULL,
	Anio			INT						 NOT NULL,
	CONSTRAINT PK_AutoevaluacionesAnuales_ID PRIMARY KEY CLUSTERED (ID)
);
GO

/*
Tabla NivelesIAE, contiene los niveles IAE
*/
USE ProyectoComunidad;
GO
CREATE TABLE NivelesIAE(
	ID			INT	IDENTITY(1,1)			NOT NULL,
	NivelIAE	VARCHAR(50)					NOT NULL	UNIQUE,
	CONSTRAINT PK_NivelesIAE_ID PRIMARY KEY CLUSTERED (ID)
);
GO

/*
Tabla Valoraciones, contiene las valoraciones las cuales ser�n en escala de malo hasta excelente
*/
USE ProyectoComunidad;
GO
CREATE TABLE Valoraciones(
	ID			INT	IDENTITY(1,1)			NOT NULL,
	Valoracion	VARCHAR(50)					NOT NULL	UNIQUE,
	CONSTRAINT PK_Valoraciones_ID PRIMARY KEY CLUSTERED (ID)
);
GO

/*
Tabla CumplimientosNominales, contiene fechas en las que se deben presentar avances o tener listo alg�n criterio
*/
USE ProyectoComunidad;
GO
CREATE TABLE CumplimientosNominales(
	ID					INT	IDENTITY(1,1)	NOT NULL,
	FechaCumplimiento	DATE				NOT NULL	UNIQUE,
	CONSTRAINT PK_CumplimientosNominales_ID PRIMARY KEY CLUSTERED (ID)
);
GO

/*
Tabla Responsables, contiene las personas que son responsables de que un criterio se cumpla bajo los requisitos de SINAES
*/
USE ProyectoComunidad;
GO
CREATE TABLE Responsables(
	ID			INT	IDENTITY(1,1)	NOT NULL,
	Correo		VARCHAR(100)		NOT NULL	UNIQUE,
	CONSTRAINT PK_Responsables_ID PRIMARY KEY CLUSTERED (ID)
);
GO

/*
Tabla Evidencias, contiene las evidencias que prueban el correcto cumplimiento de un criterio ajustado
*/
USE ProyectoComunidad;
GO
CREATE TABLE Evidencias(
	ID				INT	IDENTITY(1,1)	NOT NULL,
	TipoEvidencia	INT					NOT NULL	UNIQUE,
	URL				VARCHAR	(350)		NOT NULL,
	CONSTRAINT PK_Evidencias_ID PRIMARY KEY CLUSTERED (ID)
);
GO

/*
Tabla CYEA, tabla principal que contiene todos los CYE ya ajustados y listos para la autoevaluaci�n
*/
USE ProyectoComunidad;
GO
CREATE TABLE CYEA(
	ID						INT IDENTITY(1,1)	NOT NULL,
	ID_CYE_General			INT,
	ID_Sede					INT,
	ID_Carrera				INT,
	ID_Evidencia			INT,
	ID_Valoracion			INT,
	ID_CumplimientoNominal	INT,
	ID_NivelIAE				INT,
	CriterioAjustado		VARCHAR(350)		NOT NULL,
	FLOC					DATE				NOT NULL,
	FLA						DATE				NOT NULL,
	IncorporadoIAE			BIT					NOT NULL,
	Observaciones			VARCHAR(500)		NOT NULL,

	CONSTRAINT PK_CYEA_ID PRIMARY KEY CLUSTERED (ID),

	CONSTRAINT FK_CYEA_ID_CYE_General	FOREIGN KEY (ID_CYE_General) 
		REFERENCES	dbo.CYE (ID) ON DELETE CASCADE ON UPDATE CASCADE,

	CONSTRAINT FK_CYEA_ID_Sede	FOREIGN KEY (ID_Sede) 
		REFERENCES	dbo.Sedes (ID) ON DELETE CASCADE ON UPDATE CASCADE,

	CONSTRAINT FK_CYEA_ID_Evidencia	FOREIGN KEY (ID_Evidencia) 
		REFERENCES	dbo.Evidencias (ID) ON DELETE CASCADE ON UPDATE CASCADE,

	CONSTRAINT FK_CYEA_ID_Valoracion FOREIGN KEY (ID_Valoracion) 
		REFERENCES	dbo.Valoraciones (ID) ON DELETE CASCADE ON UPDATE CASCADE,

	CONSTRAINT FK_CYEA_ID_CumplimientoNominal	FOREIGN KEY (ID_CumplimientoNominal) 
		REFERENCES	dbo.CumplimientosNominales (ID) ON DELETE CASCADE ON UPDATE CASCADE,

	CONSTRAINT FK_CYEA_ID_NivelIAE	FOREIGN KEY (ID_NivelIAE) 
		REFERENCES	dbo.NivelesIAE (ID) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

/*
Tabla CYEA_Responsables, tabla producida por la normalizaci�n de la relaci�n entre las tablas CYEA y Responsables
*/
USE ProyectoComunidad;
GO
CREATE TABLE CYEA_Responsables(
	ID_CYEA			INT,
	ID_Responsable	INT,
	TipoResponsabilidad VARCHAR(250),
	CONSTRAINT FK_CYEA_Responsables_ID_CYEA	FOREIGN KEY (ID_CYEA) 
		REFERENCES	dbo.CYEA (ID) ON DELETE CASCADE ON UPDATE CASCADE,

	CONSTRAINT FK_CYEA_Responsables_ID_Responsable	FOREIGN KEY (ID_Responsable) 
		REFERENCES	dbo.Responsables (ID) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

/*
Tabla Auto_CYEA, tabla que sale producto de la normalizaci�n entre las tablas AutoevaluacionesAnuales y CYEA y contiene 
cada todos los criterios que se asocian a un usuario administrador encargado de la evaluaci�n de una carrera
*/
USE ProyectoComunidad;
GO
CREATE TABLE Auto_CYEA(
	ID_Autoeval		INT,
	ID_CYEA			INT,
	CONSTRAINT FK_Auto_CYEA_ID_Autoeval	FOREIGN KEY (ID_Autoeval) 
		REFERENCES	dbo.AutoevaluacionesAnuales (ID) ON DELETE CASCADE ON UPDATE CASCADE,

	CONSTRAINT FK_Auto_CYEA_ID_CYEA	FOREIGN KEY (ID_CYEA) 
		REFERENCES	dbo.CYEA (ID) ON DELETE CASCADE ON UPDATE CASCADE
);
GO
-----------------------------------------------------------------------------
--						ERRORES CON CLAVES FORANEAS						   --
-----------------------------------------------------------------------------

-- TRATANDO DE AGREGAR ESA CLAVE FORANEA DE MANERA EXTERNA
-- esta clave foranea es de la tabla CYEA solo que no me funciona y estoy tratando de agregarla de manera externa
-- si funcion si pongo ON DELETE NO ACTION ON UPDATE NO ACTION pero esa no es la idea
ALTER TABLE CYEA ADD CONSTRAINT FK_CYEA_ID_Carrera FOREIGN KEY (ID_Carrera) 
		REFERENCES dbo.Carreras (ID) ON DELETE CASCADE ON UPDATE NO ACTION
GO

/*
Tabla CumplimientosNominales_CYEA, tabla producida por la normalizaci�n de la relaci�n entre las tablas CYEA y
CumplimientosNominales
*/
USE ProyectoComunidad;
GO
CREATE TABLE CumplimientosNominales_CYEA(
	ID_CumplimNominal	INT,
	ID_CYEA				INT,
	CONSTRAINT FK_CumplimientosNominales_CYEA_ID_CYEA	FOREIGN KEY (ID_CYEA) 
		REFERENCES	dbo.CYEA (ID) ON DELETE CASCADE ON UPDATE CASCADE,
	
	CONSTRAINT FK_CumplimientosNominales_CYEA_ID_CumplimNominal	FOREIGN KEY (ID_CumplimNominal) 
		REFERENCES	dbo.CumplimientosNominales (ID) ON DELETE CASCADE ON UPDATE CASCADE
);
GO

/*
Tabla CYEA_Evidencias, tabla producida por la normalizaci�n de la relaci�n entre las tablas CYEA y Evidencias
*/
USE ProyectoComunidad;
GO
CREATE TABLE CYEA_Evidencias(
	ID_CYEA				INT,
	ID_Evidencia		INT,
	CONSTRAINT FK_CYEA_Evidencias_ID_CYEA	FOREIGN KEY (ID_CYEA) 
		REFERENCES	dbo.CYEA (ID) ON DELETE CASCADE ON UPDATE CASCADE,

	CONSTRAINT FK_CYEA_Evidencias_ID_Evidencia	FOREIGN KEY (ID_Evidencia) 
		REFERENCES	dbo.Evidencias (ID) ON DELETE CASCADE ON UPDATE CASCADE
);
GO