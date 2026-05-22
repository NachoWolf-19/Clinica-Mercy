-- ============================================================================================================================
-- ======================================================DataBase==============================================================
-- ============================================================================================================================
CREATE DATABASE IF NOT EXISTS MercyMedDB;
USE MercyMedDB;

-- =================================== Tabla Paciente
CREATE TABLE paciente(
	pacienteID 			INT AUTO_INCREMENT,
	pacienteDNI 		CHAR(8),
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
    especialidadEstado	VARCHAR(10) NOT NULL DEFAULT 'Activo',
    CONSTRAINT pk_especialidad			PRIMARY KEY (especialidadID),
	CONSTRAINT ch_especialidadNombre 	CHECK (especialidadNombre REGEXP '^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$' AND LENGTH(TRIM(especialidadNombre)) > 0),
    CONSTRAINT ch_especialidadEstado	CHECK (especialidadEstado IN ('Activo', 'Inactivo'))
);

-- =================================== Tabla Medico
CREATE TABLE medico(
	medicoID 		INT AUTO_INCREMENT,
    medicoCMP       VARCHAR(6) NOT NULL,
	medicoNombres 	VARCHAR(50) NOT NULL,
	medicoApellidos VARCHAR(50) NOT NULL,
	especialidadID 	INT NOT NULL,
	medicoEstado 	VARCHAR(15) NOT NULL DEFAULT 'Activo',
    CONSTRAINT pk_medico				PRIMARY KEY (medicoID),
	CONSTRAINT fk_medico_especialidad 	FOREIGN KEY (especialidadID) REFERENCES especialidad(especialidadID),
    CONSTRAINT uq_medicoCMP				UNIQUE (medicoCMP),
	CONSTRAINT ch_medicoNombres 		CHECK (medicoNombres REGEXP '^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$' AND LENGTH(TRIM(medicoNombres)) > 0),
	CONSTRAINT ch_medicoApellidos 		CHECK (medicoApellidos REGEXP '^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$' AND LENGTH(TRIM(medicoApellidos)) > 0),
    CONSTRAINT ch_medicoEstado 			CHECK (medicoEstado IN ('Activo', 'Vacaciones', 'Retirado'))
);

-- =================================== Tabla Consultorio
CREATE TABLE consultorio(
	consultorioID 		INT AUTO_INCREMENT,
    consultorioCodigo 	CHAR(3) NOT NULL,
    consultorioEstado	VARCHAR(10) NOT NULL DEFAULT 'Activo',
    CONSTRAINT pk_consultorio 		PRIMARY KEY (consultorioID),
    CONSTRAINT ch_consultorioCodigo CHECK (consultorioCodigo REGEXP '^[1-9]0[1-9]$'),
    CONSTRAINT ch_consultorioEstado CHECK (consultorioEstado IN ('Activo', 'Inactivo'))
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
    CONSTRAINT uq_horario 				UNIQUE (consultorioID, horarioFecha, horarioInicio),
    CONSTRAINT uq_horario_medico 		UNIQUE (medicoID, horarioFecha, horarioInicio),
    CONSTRAINT ch_horario_estado 		CHECK (horarioEstado IN ('Disponible', 'Reservado', 'Cancelado'))
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

-- =================================== Tabla Usuario
CREATE TABLE usuario(
	usuarioID 		INT AUTO_INCREMENT,
	usuarioNombre 	VARCHAR(50) NOT NULL,
	usuarioClave 	VARCHAR(100) NOT NULL,
	usuarioRol 		VARCHAR(20) NOT NULL,
	CONSTRAINT pk_usuario 		PRIMARY KEY (usuarioID),
	CONSTRAINT ch_usuarioNombre CHECK (usuarioNombre REGEXP '^[a-zA-ZáéíóúÁÉÍÓÚñÑ ]+$' AND LENGTH(TRIM(usuarioNombre)) > 0),
	CONSTRAINT ch_usuarioClave 	CHECK (LENGTH(TRIM(usuarioClave)) > 0),
	CONSTRAINT uq_usuario 		UNIQUE (usuarioNombre),
	CONSTRAINT ch_usuarioRol 	CHECK (usuarioRol IN ('Administrador', 'Recepcionista'))
);

-- ============================================================================================================================
-- ======================================================Procesos==============================================================
-- ============================================================================================================================
-- =================================== Paciente
-- ================= Create
DELIMITER //
CREATE PROCEDURE usp_RegistrarPaciente(
	IN dni CHAR(8),
	IN nombres VARCHAR(50),
    IN apellidos VARCHAR(50),
    IN numero VARCHAR(10),
    IN email VARCHAR(150)
)
BEGIN
	IF numero = '' AND email = '' THEN
		SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = 'Error: No se puede registrar al paciente sin datos de contacto. Debe ingresar al menos un teléfono o un correo electrónico.';
	END IF;	
	
	IF numero = '' THEN
		SET numero = 'Sin Numero';
	END IF;
    
	IF email = '' THEN
		SET email = 'Sin Email';
	END IF;
    
    INSERT INTO paciente(pacienteDNI, pacienteNombres, pacienteApellidos, pacienteNumero, pacienteEmail)
    VALUES
    (dni, nombres, apellidos, numero, email);
END //
DELIMITER ;

-- ================= Read
CREATE VIEW vw_ListaPacientes AS
SELECT
	pacienteID as id,
    pacienteDNI as dni,
    pacienteNombres AS nombre,
    pacienteApellidos AS apellidos
FROM paciente
WHERE pacienteEstado = 'Activo';

-- ================= Update
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
	IF numero = '' AND email = '' THEN
		SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = 'Error: No se puede registrar al paciente sin datos de contacto. Debe ingresar al menos un teléfono o un correo electrónico.';
	END IF;	

	IF numero = '' THEN
		SET numero = 'Sin Numero';
	END IF;
    
	IF email = '' THEN
		SET email = 'Sin Email';
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

-- ================= Delete
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
		SET MESSAGE_TEXT = 'Error: El paciente tiene citas reservadas pendientes. No se puede eliminar.';
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
-- ================= Create
DELIMITER //
CREATE PROCEDURE usp_RegistrarEspecialidad(
	IN nombre VARCHAR(50)
)
BEGIN
	INSERT INTO especialidad(especialidadNombre)
    VALUES
    (nombre);
END //
DELIMITER ;
-- Read
CREATE VIEW vw_ListaEspecialidades AS
SELECT 
	especialidadID AS id,
    especialidadNombre AS nombre,
	especialidadEstado AS estado
FROM especialidad;

CREATE VIEW vw_ListaEspecialidadesActivas AS
SELECT
	especialidadID AS id,
	especialidadNombre AS nombre
FROM especialidad
WHERE especialidadEstado = 'Activo';
    
-- ================= Update
DELIMITER //
CREATE PROCEDURE usp_ActualizarEspecialidad (
	IN id INT,
    IN nombre VARCHAR(50),
    IN estadoOpcion INT
)
BEGIN
	DECLARE estado VARCHAR(10);
	DECLARE medicos_activos INT;
    
	IF estadoOpcion = 0 THEN 
		SET estado = 'Activo';    
    ELSEIF estadoOpcion = 1 THEN
		SELECT COUNT(*) INTO medicos_activos
        FROM medico
        WHERE especialidadID = id AND medicoEstado IN ('Activo', 'Vacaciones');
        
        IF medicos_activos > 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: No se puede inactivar la especialidad porque tiene médicos activos o en vacaciones asignados.';
        END IF;
        
		SET estado = 'Inactivo';
	ELSE 
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Error: El valor de estadoOpcion no es válido. Solo se permite 0 (Activo) o 1 (Inactivo).';
	END IF;
    
	UPDATE especialidad
    SET
		especialidadNombre = nombre,
        especialidadEstado = estado
	WHERE especialidadID = id;
END //
DELIMITER ;

-- =================================== Medico
-- ================= Create
DELIMITER //
CREATE PROCEDURE usp_RegistrarMedico(
	IN cmp CHAR(6),
    IN nombres VARCHAR(50),
    IN apellidos VARCHAR(50),
    IN esp INT
)
BEGIN
	INSERT INTO medico(medicoCMP, medicoNombres, medicoApellidos, especialidadID)
    VALUES
    (cmp, nombres, apellidos, esp);
END //
DELIMITER ;

-- ================= Read
CREATE VIEW vw_ListaMedicos AS 
SELECT
	m.medicoID as id,
    m.medicoCMP as cmp,
    m.medicoNombres as nombre,
    m.medicoApellidos as apellidos,
    e.especialidadNombre as especialidad,
    m.medicoEstado as estado
FROM medico m
INNER JOIN especialidad e ON m.especialidadID = e.especialidadID;

CREATE VIEW vw_ListaMedicosActivos AS
SELECT 
	medicoID as id,
    medicoCMP as cmp,
	concat(medicoNombres, ' ', medicoApellidos) as nombre_completo,
	especialidadID as especialidad_id
FROM medico
WHERE medicoEstado = 'Activo';

-- ================= Update
DELIMITER //
CREATE PROCEDURE usp_ActualizarMedico(
	IN id INT,
    IN cmp CHAR(6),
    IN nombres VARCHAR(50),
    IN apellidos VARCHAR(50),
    IN esp INT,
    IN estadoOpcion INT
)
BEGIN
	DECLARE estado VARCHAR(15);
    DECLARE citas_pendientes INT DEFAULT 0;
    
	IF estadoOpcion = 0 THEN
		SET estado = 'Activo';
	ELSEIF estadoOpcion = 1 THEN
		SET estado = 'Vacaciones';
	ELSEIF estadoOpcion = 2 THEN
		SELECT COUNT(*) INTO citas_pendientes
        FROM citas c
        INNER JOIN horario h on c.horarioID = h.horarioID
        WHERE h.medicoID = id 
			AND h.horarioEstado = 'Reservado'
            AND TIMESTAMP(h.horarioFecha, h.horarioInicio) > now();
		IF citas_pendientes > 0 THEN
			SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: No se puede cambiar a Retirado. El médico tiene citas reservadas pendientes.';
		END IF;
        
		SET estado = 'Retirado';
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Error: El valor de estadoOpcion no es válido. Solo se permite 0 (Activo), 1 (Vacaciones) o 2 (Retirado).';
	END IF;
    
	UPDATE medico
    SET
		medicoCMP = cmp,
        medicoNombres = nombres,
        medicoApellidos = apellidos,
        especialidadID = esp,
        medicoEstado = estado
	WHERE medicoID = id;
END //
DELIMITER ;

-- =================================== Consultorio
-- ================= Create
DELIMITER //
CREATE PROCEDURE usp_RegistrarConsultorio(
	IN codigo CHAR(3)
)
BEGIN
	INSERT INTO consultorio(consultorioCodigo)
    VALUES
    (codigo);
END //
DELIMITER ;

-- ================= Read
CREATE VIEW vw_ListaConsultorios AS
SELECT
	consultorioID AS id,
    consultorioCodigo AS codigo,
    consultorioEstado AS estado
FROM consultorio;

CREATE VIEW vw_ListaConsultoriosActivos AS
SELECT
	consultorioID AS id,
    consultorioCodigo AS codigo
FROM consultorio
WHERE consultorioEstado = 'Activo';

-- ================= Update
DELIMITER //
CREATE PROCEDURE usp_ActualizarConsultorio(
	IN id INT,
	IN codigo CHAR(3),
    IN estadoOpcion INT
)
BEGIN
	DECLARE estado VARCHAR(10);
	
	IF estadoOpcion = 0 THEN
		SET estado = 'Activo';
	ELSEIF estadoOpcion = 1 THEN
		SET estado = 'Inactivo';
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Error: El valor de estadoOpcion no es válido. Solo se permite 0 (Activo) o 1 (Inactivo).';
    END IF;
    
    UPDATE consultorio
	SET 
		consultorioCodigo = codigo,
        consultorioEstado = estado
	WHERE consultorioID = id;
END //
DELIMITER ;

-- =================================== Horario
-- =================================== Citas

-- =================================== Usuario
-- ================= Create
DELIMITER //
CREATE PROCEDURE usp_RegistrarUsuario(
	IN nombre VARCHAR(50),
    IN clave VARCHAR(100),
    IN rolOpcion INT
)
BEGIN
	DECLARE rol VARCHAR(20);
	
	IF rolOpcion = 0 THEN
		SET rol = 'Administrador';
	ELSEIF rolOpcion = 1 THEN
		SET rol = 'Recepcionista';
	ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Error: El valor de rolOpcion no es válido. Solo se permite 0 (Admin) o 1 (Recepcionista).';
    END IF;
    
    INSERT INTO usuario(usuarioNombre, usuarioClave, usuarioRol)
    VALUES
	(nombre, clave, rol);
END //
DELIMITER ;

-- ================= Read
CREATE VIEW vw_ListaUsuarios AS
SELECT 
	usuarioID AS id,
	usuarioNombre AS nombre,
	usuarioRol AS rol
FROM usuario;

DELIMITER //
CREATE PROCEDURE usp_ValidarUsuario(
	usuario VARCHAR(50),
    clave VARCHAR(50)
)
BEGIN
	SELECT
		usuarioNombre AS usuario,
        usuarioRol AS rol        
    FROM usuario
    WHERE usuarioNombre = usuario
		AND usuarioClave = clave;
END //
DELIMITER ;

-- ================= Update
DELIMITER //
CREATE PROCEDURE usp_ActualizarUsuario(
	IN id INT,
	IN nombre VARCHAR(50),
    IN clave VARCHAR(100),
    IN rolOpcion INT
)
BEGIN
	DECLARE rol VARCHAR(20);
    
    IF rolOpcion = 0 THEN
		SET rol = 'Administrador';
    ELSEIF rolOpcion = 1 THEN
		SET rol = 'Recepcionista';
    ELSE
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Error: El valor de rolOpcion no es válido. Solo se permite 0 (Admin) o 1 (Recepcionista).';
    END IF;
    
    UPDATE usuario
    SET
		usuarioNombre = nombre,
        usuarioClave = clave,
        usuarioRol = rol
	WHERE usuarioID = id;
END //
DELIMITER ;

-- ================= Delete
DELIMITER //
CREATE PROCEDURE usp_EliminarUsuario(
	IN id INT
)
BEGIN
	DELETE FROM usuario
    WHERE usuarioID = id;
END //
DELIMITER ;