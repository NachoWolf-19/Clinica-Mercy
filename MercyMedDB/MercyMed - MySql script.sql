-- ============================================================================================================================
-- ======================================================DataBase==============================================================
-- ============================================================================================================================
CREATE DATABASE IF NOT EXISTS MercyMedDB;
USE MercyMedDB;

-- =================================== Tabla Paciente
CREATE TABLE paciente(
	pacienteID 			INT AUTO_INCREMENT,
	pacienteDNI 		CHAR(8) NULL,
	pacienteNombres 	VARCHAR(50) NULL,
	pacienteApellidos 	VARCHAR(50) NULL,
	pacienteNumero 		VARCHAR(10) NULL,
	pacienteEmail 		VARCHAR(150) NULL,
	pacienteEstado 		VARCHAR(10) NOT NULL DEFAULT 'Activo',
    CONSTRAINT pk_paciente 			PRIMARY KEY (pacienteID),
	CONSTRAINT ch_pacienteDNI 		CHECK (pacienteDNI REGEXP '^[0-9]{8}$'),
	CONSTRAINT ch_pacienteNombres 	CHECK (pacienteNombres REGEXP '^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$' AND LENGTH(TRIM(pacienteNombres)) > 0),
	CONSTRAINT ch_pacienteApellidos CHECK (pacienteApellidos REGEXP '^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$' AND LENGTH(TRIM(pacienteApellidos)) > 0),
	CONSTRAINT ch_pacienteNumero 	CHECK (pacienteNumero REGEXP '^[0-9]{9}$' OR pacienteNumero = 'Sin Numero'),
	CONSTRAINT ch_pacienteCorreo 	CHECK (pacienteEmail REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$' OR pacienteEmail = 'Sin Email'),
	CONSTRAINT ch_pacienteEstado 	CHECK (pacienteEstado IN ('Activo', 'Borrado')),
	CONSTRAINT uq_pacienteDNI		UNIQUE (pacienteDNI)
);

-- =================================== Tabla Especialidad
CREATE TABLE especialidad(
	especialidadID 		INT AUTO_INCREMENT,
	especialidadNombre 	VARCHAR(50) NOT NULL,
    CONSTRAINT pk_especialidad			PRIMARY KEY (especialidadID),
	CONSTRAINT ch_especialidadNombre 	CHECK (especialidadNombre REGEXP '^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$' AND LENGTH(TRIM(especialidadNombre)) > 0)
);

-- =================================== Tabla Doctor
CREATE TABLE medico(
	medicoID 		INT AUTO_INCREMENT,
	medicoNombres 	VARCHAR(50) NULL,
	medicoApellidos VARCHAR(50) NULL,
	especialidadID 	INT NULL,
	medicoEstado 	VARCHAR(10) NOT NULL DEFAULT 'Activo',
    CONSTRAINT pk_medico				PRIMARY KEY (medicoID),
	CONSTRAINT fk_medico_especialidad 	FOREIGN KEY (especialidadID) REFERENCES especialidad(especialidadID),
	CONSTRAINT ch_medicoNombres 		CHECK (medicoNombres REGEXP '^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$' AND LENGTH(TRIM(medicoNombres)) > 0),
	CONSTRAINT ch_medicoApellidos 		CHECK (medicoApellidos REGEXP '^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$' AND LENGTH(TRIM(medicoApellidos)) > 0),
    CONSTRAINT ch_medicoEstado 			CHECK (medicoEstado IN ('Activo', 'Borrado'))
);

-- =================================== Tabla Consultorio
CREATE TABLE consultorio(
	consultorioID 		INT AUTO_INCREMENT,
    consultorioCodigo 	CHAR(3) NOT NULL,
    CONSTRAINT pk_consultorio 		PRIMARY KEY (consultorioID),
    CONSTRAINT ch_consultorioCodigo CHECK (consultorioCodigo REGEXP '^[1-4]0[1-7]$')
);

-- =================================== Tabla Horario
CREATE TABLE horario(
	horarioID 		INT AUTO_INCREMENT,
    medicoID 		INT NOT NULL,
    consultorioID 	INT NOT NULL,
    horarioFecha 	DATE NOT NULL,
    horarioInicio	TIME NOT NULL,
    horarioEstado	VARCHAR(15) DEFAULT 'Disponible',
    CONSTRAINT pk_horario 				PRIMARY KEY (horarioID),
    CONSTRAINT fk_horario_medico 		FOREIGN KEY (medicoID) REFERENCES medico(medicoID),
    CONSTRAINT fk_horario_consultorio	FOREIGN KEY (consultorioID) REFERENCES consultorio(consultorioID),
    CONSTRAINT ch_horario_estado 		CHECK (horarioEstado IN ('Disponible', 'Reservado', 'Cancelado')),
    CONSTRAINT uq_horario 				UNIQUE (consultorioID, horarioFecha, horarioInicio)
);

-- =================================== Tabla Citas
CREATE TABLE citas(
	citaID 				INT AUTO_INCREMENT,
    pacienteID			INT NOT NULL,
    horarioID 			INT NOT NULL,
    citaPrecio 			DECIMAL(10,2) NOT NULL,
    citaTipo			VARCHAR(20) NOT NULL,
    citaFechaRegistro 	DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT pk_cita 			PRIMARY KEY (citaID),
    CONSTRAINT fk_cita_paciente FOREIGN KEY (pacienteID) REFERENCES paciente(pacienteID),
    CONSTRAINT fk_cita_horario 	FOREIGN KEY (horarioID) REFERENCES horario(horarioID),
    CONSTRAINT ch_citaPrecio 	CHECK (citaPrecio > 0),
    CONSTRAINT ch_citaTipo		CHECK (citaTipo IN ('Nueva', 'Reprogramada'))
);

-- =================================== Tabla Rol
CREATE TABLE rol(
	rolID 		INT AUTO_INCREMENT,
    rolNombre 	VARCHAR(25),
    CONSTRAINT pk_rol 		PRIMARY KEY (rolID),
    CONSTRAINT ch_rolNombre CHECK (rolNombre REGEXP '^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$' AND LENGTH(TRIM(rolNombre)) > 0)
);

-- =================================== Tabla Usuario
CREATE TABLE usuario(
	usuarioID INT AUTO_INCREMENT,
    usuarioNombre VARCHAR(50) NOT NULL,
    usuarioClave VARCHAR (100) NOT NULL,
    rolID INT NOT NULL,
    CONSTRAINT pk_usuario PRIMARY KEY (usuarioID),
    CONSTRAINT fk_usuario_rol FOREIGN KEY (rolID) REFERENCES rol(rolID),
    CONSTRAINT ch_usuarioNombre CHECK (usuarioNombre REGEXP '^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$' AND LENGTH(TRIM(usuarioNombre)) > 0),
    CONSTRAINT ch_usuarioClave CHECK (LENGTH(TRIM(usuarioClave)) > 0),
    CONSTRAINT uq_usuario UNIQUE (usuarioNombre)
);

-- ============================================================================================================================
-- ======================================================Procesos==============================================================
-- ============================================================================================================================
