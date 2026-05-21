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

-- =================================== Tabla Medico
CREATE TABLE medico(
	medicoID 		INT AUTO_INCREMENT,
	medicoNombres 	VARCHAR(50) NOT NULL,
	medicoApellidos VARCHAR(50) NOT NULL,
	especialidadID 	INT NOT NULL,
	medicoEstado 	VARCHAR(10) NOT NULL DEFAULT 'Activo',
    CONSTRAINT pk_medico				PRIMARY KEY (medicoID),
	CONSTRAINT fk_medico_especialidad 	FOREIGN KEY (especialidadID) REFERENCES especialidad(especialidadID),
	CONSTRAINT ch_medicoNombres 		CHECK (medicoNombres REGEXP '^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$' AND LENGTH(TRIM(medicoNombres)) > 0),
	CONSTRAINT ch_medicoApellidos 		CHECK (medicoApellidos REGEXP '^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$' AND LENGTH(TRIM(medicoApellidos)) > 0),
    CONSTRAINT ch_medicoEstado 			CHECK (medicoEstado IN ('Activo', 'Vacaciones' 'Retirado'))
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
-- =================================== Paciente
-- Create
DELIMITER //
CREATE PROCEDURE usp_RegistrarPaciente(
	IN dni CHAR(8),
	IN nombres VARCHAR(50),
    IN apellidos VARCHAR(50),
    IN numero VARCHAR(10),
    IN email VARCHAR(150)
)
BEGIN
	IF numero = '' THEN
		SET numero = 'Sin numero';
	END IF;
    
	IF email = '' THEN
		SET email = 'Sin email';
	END IF;
    
    INSERT INTO paciente(pacienteDNI, pacienteNombres, pacienteApellidos, pacienteNumero, pacienteEmail)
    VALUES
    (dni, nombres, apellidos, numero, email);
END //
DELIMITER ;

-- Read
CREATE VIEW vw_ListaPacientes AS
SELECT
	pacienteID as id,
    pacienteDNI as dni,
    CONCAT(pacienteNombres, ' ', pacienteApellidos) AS nombre_completo,
    pacienteNumero as telefono,
    pacienteEmail as email
FROM paciente
WHERE pacienteEstado = 'Activo';

-- Update
DELIMITER //
CREATE PROCEDURE usp_ActualizarPaciente(
	IN id INT,
	IN dni CHAR(8),
	IN nombres VARCHAR(50),
    IN apellidos VARCHAR(50),
    IN numero VARCHAR(10),
    IN email VARCHAR(150)
)
BEGIN
	IF numero = '' THEN
		SET numero = 'Sin numero';
	END IF;
    
	IF email = '' THEN
		SET email = 'Sin email';
	END IF;
    
    UPDATE paciente
    SET
		pacienteDNI = dni,
        pacienteNombres = nombres,
        pacienteApellidos = apellidos,
        pacienteNumero = numero,
        pacienteEmail = email
	WHERE pacienteID = id;
END //
DELIMITER ;

-- Delete
DELIMITER //
CREATE PROCEDURE usp_EliminarPaciente(
	IN id INT
)
BEGIN
	DECLARE citas_activas INT DEFAULT 0;

	SELECT COUNT(*) INTO citas_activas
	FROM citas c
	INNER JOIN horario h ON c.horarioID = h.horarioID
	WHERE c.pacienteID = id
		AND h.horarioEstado = 'Reservado'
		AND TIMESTAMP(h.horarioFecha, h.horarioInicio) > NOW();

	IF citas_activas > 0 THEN
		SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = 'No se puede eliminar: El paciente tiene citas reservadas pendientes.';
	ELSE
		UPDATE paciente
		SET
			pacienteDNI = NULL,
			pacienteNombres = NULL,
			pacienteApellidos = NULL,
			pacienteNumero = NULL,
			pacienteEmail = NULL,
			pacienteEstado = 'Borrado'
		WHERE pacienteID = id;
	END IF;
END //
DELIMITER ;

-- =================================== Especialidad

-- =================================== Medico
-- =================================== Consultorio
-- =================================== Horario
-- =================================== Citas
-- =================================== Roll
-- =================================== Usuario