-- EJERCICIOS CLASE 1
--1. Crear una base de datos de nombre Jurassic_Park sin especificar los valores de la base.
CREATE DATABASE Jurassic_Park_Practica;
GO

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
-- EJERCICIOS CLASE 2