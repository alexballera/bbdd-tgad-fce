-- ===================================================================
-- EJERCICIOS CLASE 1
-- ===================================================================

--1. Crear una base de datos de nombre Jurassic_Park sin especificar los valores de la base.
-- CREATE DATABASE Jurassic_Park_Practica;
-- GO

USE Jurassic_Park_Practica;
GO
--2. Crear la tabla Escuela y definir su clave principal en la misma instrucción de creación.
-- Continuar con tablas Guia, Reserva y Tipo_Visita.
-- Escuela: codigo_escuela, nombre_escuela, direccion_escuela.
CREATE TABLE Escuela (
    codigo_escuela smallint PRIMARY KEY NONCLUSTERED,
    nombre_escuela varchar(50) NOT NULL,
    direccion_escuela varchar(200) NOT NULL
);
GO
-- Guia: codigo_guia, nombre_guia, apellido_guia
CREATE TABLE Guia (
    codigo_guia smallint PRIMARY KEY NONCLUSTERED,
    nombre_guia VARCHAR(50) NOT NULL,
    apellido_guia VARCHAR(50) NOT NULL,
);
GO
-- Reserva: numero_reserva, fecha_reserva, hora_reserva, codigo_escuela
CREATE TABLE Reserva (
    numero_reserva smallint PRIMARY KEY NONCLUSTERED,
    fecha_reserva date NOT NULL,
    hora_reserva time NOT NULL,
    codigo_escuela smallint NOT NULL,
    CONSTRAINT FK_codigo_escuela FOREIGN KEY (codigo_escuela) REFERENCES Escuela(codigo_escuela)
);
GO
-- Tipo_Visita: codigo_tipo_visita, descripcion_tipo_visita, arancel_tipo_visita
CREATE TABLE Tipo_Visita (
    codigo_tipo_visita smallint PRIMARY KEY NONCLUSTERED,
    descripcion_tipo_visita VARCHAR(255) NOT NULL,
    arancel_tipo_visita decimal(10,2) NOT NULL
);
GO

--3. Crear la tabla Telefono_Escuela con su clave principal. (hacer restricción en caso de ser una CP compuesta).
CREATE TABLE Telefono_Escuela (
    codigo_escuela smallint NOT NULL,
    numero_telefono varchar(20) NOT NULL,
    FOREIGN KEY (codigo_escuela) REFERENCES Escuela(codigo_escuela),
    PRIMARY KEY (codigo_escuela, numero_telefono)
);
GO
--4. Crear la tabla Reserva_Por_Grado con su clave principal. Hacer las correspondientes restricciones.
CREATE TABLE Grado(
    codigo_grado smallint PRIMARY KEY NONCLUSTERED,
    descripcion_grado varchar(255) NOT NULL
);
GO
CREATE TABLE Reserva_Por_Grado (
    numero_reserva smallint NOT NULL CONSTRAINT FK_numero_reserva FOREIGN KEY REFERENCES Reserva(numero_reserva),
    codigo_grado smallint NOT NULL CONSTRAINT FK_codigo_grado FOREIGN KEY REFERENCES Grado(codigo_grado),
    codigo_tipo_visita smallint NOT NULL CONSTRAINT FK_codigo_tipo_visita FOREIGN KEY REFERENCES Tipo_Visita(codigo_tipo_visita),
    PRIMARY KEY (numero_reserva, codigo_grado, codigo_tipo_visita)
);
GO
--5. Crear la tabla Reserva_Tipo_Visita con sus campos propios y los referenciados. Sin generar claves.
CREATE TABLE Reserva_Tipo_Visita (
    numero_reserva smallint NOT NULL CONSTRAINT FK_numero_reserva2 FOREIGN KEY REFERENCES Reserva(numero_reserva),
    codigo_tipo_visita smallint NOT NULL CONSTRAINT FK_codigo_tipo_visita2 FOREIGN KEY REFERENCES Tipo_Visita(codigo_tipo_visita),
    codigo_guia smallint NOT NULL CONSTRAINT FK_codigo_guia2 FOREIGN KEY REFERENCES Guia(codigo_guia),
    cantidad_alumnos_reservados smallint NOT NULL,
    cantidad_alumnos_reales smallint,
);
GO
--6. Completar el ejercicio anterior, con la creación de las claves correspondientes.
ALTER TABLE Reserva_Tipo_Visita
ADD PRIMARY KEY (numero_reserva, codigo_tipo_visita);
GO

--7. Añadir a la tabla de Guía la columna sueldo_hora.
ALTER TABLE Guia
ADD sueldo_hora money NOT NULL;
GO
-- ===================================================================
-- CLASE 1 - Adicionales
-- ===================================================================
-- 1. Crear la tabla Distrito_Escolar con su correspondiente CP.
CREATE TABLE Distrito_Escolar (
    codigo_distrito_escolar smallint PRIMARY KEY NONCLUSTERED,
    nombre_distrito_escolar varchar(50) NOT NULL
);
GO

-- 2. Agregar clave foránea codigo_distrito_escolar a la tabla Escuela
ALTER TABLE Escuela
ADD codigo_distrito_escolar smallint,
    CONSTRAINT FK_codigo_distrito_escolar FOREIGN KEY (codigo_distrito_escolar) REFERENCES Distrito_Escolar(codigo_distrito_escolar);
GO

-- 3. Eliminar la columna de domicilios de la tabla Escuela.
ALTER TABLE Escuela
DROP COLUMN direccion_escuela;
GO
-- 4. Agregar columnas calle_escuela y altura_escuela a la tabla Escuela.
ALTER TABLE Escuela
ADD calle_escuela varchar (50) NOT NULL,
    altura_escuela smallint NOT NULL;
GO

-- 5. Agregar domicilio_guia en tabla Guia.
ALTER TABLE Guia
ADD domicilio_guia varchar (255) NOT NULL;
GO

-- 6. Eliminar tabla Telefono_Escuela
DROP TABLE Telefono_Escuela;
GO
-- 7. Agregar tabla Email_Escuela (sin Clave primaria)
CREATE TABLE Email_Escuela (
    email_escuela varchar(50) NOT NULL,
    codigo_escuela smallint NOT NULL,
    CONSTRAINT FK_codigo_escuela2 FOREIGN KEY (codigo_escuela) REFERENCES Escuela(codigo_escuela)
);
GO
-- 8. Establecer clave primaria para Email_Escuela
ALTER TABLE Email_Escuela
ADD PRIMARY KEY (email_escuela, codigo_escuela);
GO
-- 9. Establecer que los nombres y apellidos de los guias no tengan valores nulos. nulos.
ALTER TABLE Guia
ALTER COLUMN nombre_guia varchar(50) NOT NULL;
GO

ALTER TABLE Guia
ALTER COLUMN apellido_guia varchar(50) NOT NULL;
GO

-- 10. Establecer que no se repita la calle y la altura de las escuelas.
ALTER TABLE Escuela
ADD CONSTRAINT UQ_calle_altura UNIQUE (calle_escuela, altura_escuela);
GO
