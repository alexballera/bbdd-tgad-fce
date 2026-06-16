CREATE DATABASE Unidad4_Lenguaje_de_Consultas;
GO
USE Unidad4_Lenguaje_de_Consultas;
GO
-- ===================================================================
-- CREACIÓN DE TABLAS
DROP TABLE IF EXISTS Instructor;
GO

CREATE TABLE Instructor (
    id_instructor smallint,
    nombre_instructor VARCHAR(50) NOT NULL,
    nombre_departamento VARCHAR(50) NOT NULL
);
GO

INSERT INTO Instructor (id_instructor, nombre_instructor, nombre_departamento)
VALUES (1, 'Juan Perez', 'Matemáticas'),
       (2, 'María Gómez', 'Física'),
       (3, 'Carlos López', 'Química');
GO

DROP TABLE IF EXISTS Curso;
GO

CREATE TABLE Curso (
    id_curso smallint,
    nombre_curso VARCHAR(50) NOT NULL,
    id_instructor smallint,
);
GO

INSERT INTO Curso (id_curso, nombre_curso, id_instructor)
VALUES (1, 'Álgebra', 1),
       (2, 'Mecánica', 1),
       (3, 'Química Orgánica', 2),
       (4, 'Cálculo', 5);
GO

-- ===================================================================
-- PRODUCTO CARTESIANO
SELECT *
FROM Instructor, Curso;
GO

-- PRODUCTO CARTESIANO CON CONDICIÓN DE IGUALDAD
SELECT *
FROM Instructor, Curso
WHERE Instructor.id_instructor = Curso.id_instructor;
GO

-- REUNIÓN NATURAL - INNER JOIN
SELECT *
FROM Instructor I
INNER JOIN Curso C
ON I.id_instructor = C.id_instructor;
GO

-- NOTA: PRODUCTO CARTESIANO CON CONDICIÓN DE IGUALDAD = INNER JOIN, PERO SE DEBE ESPECIFICAR LA CONDICIÓN DE IGUALDAD EN EL WHERE O EN EL ON, DEPENDIENDO DEL TIPO DE JOIN UTILIZADO.
-- REUNIÓN EXTERNA - OUTER JOIN 
-- LEFT JOIN
SELECT *
FROM Instructor I
LEFT JOIN Curso C
ON I.id_instructor = C.id_instructor;
GO

-- RIGHT JOIN
SELECT *
FROM Instructor I
RIGHT JOIN Curso C
ON I.id_instructor = C.id_instructor;
GO

-- FULL OUTER JOIN
SELECT *
FROM Instructor I
FULL OUTER JOIN Curso C
ON I.id_instructor = C.id_instructor;
GO

-- ===================================================================