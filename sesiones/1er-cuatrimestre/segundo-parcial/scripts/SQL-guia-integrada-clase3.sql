-- ===================================================================
-- EJERCICIOS CLASE 3: EJERCICIOS: INSERT, UPDATE, DELETE, SELECT
-- ===================================================================
USE Jurassic_Park_Practica;
GO
-- ===================================================================
-- ** EJERCICIOS: INSERT **
-- 1. Inserte una nueva escuela.
INSERT INTO Escuela (codigo_escuela, nombre_escuela, calle_escuela, altura_escuela)
VALUES (1, 'Escuela Jurassic', 'Calle Ficticia', 123);
GO
-- 2. Agregue un nuevo guía a la base.
INSERT INTO Guia(codigo_guia, nombre_guia, apellido_guia, sueldo_hora, domicilio_guia)
VALUES (1, 'John', 'Doe', 15.50, 'Calle Imaginaria 456');
GO
-- 3. Inserte los datos de una escuela existente (nombre y domicilio) pero con un nuevo código.
INSERT INTO Escuela (codigo_escuela, nombre_escuela, calle_escuela, altura_escuela)
SELECT 2, nombre_escuela, calle_escuela + ' - Nueva Sucursal', altura_escuela + 10
FROM Escuela
WHERE codigo_escuela = 1;
GO
-- 4. Borre todos los teléfonos que se encuentren en la tabla telefono_Escuela e inserte para todas las escuelas cargadas el teléfono 1111-1111.
-- DELETE FROM Telefono_Escuela;
-- GO
-- NO EXISTE TABLA TELEFONO_ESCUELA, ASI QUE SE ASUME QUE SE DEBE CREAR PRIMERO Y LUEGO REALIZAR LAS OPERACIONES DE BORRADO E INSERCIÓN.
CREATE TABLE Telefono_Escuela (
    codigo_escuela smallint,
    telefono VARCHAR(20),
    PRIMARY KEY (codigo_escuela, telefono),
    FOREIGN KEY (codigo_escuela) REFERENCES Escuela(codigo_escuela)
);
GO

DELETE FROM Telefono_Escuela;
GO

INSERT INTO Telefono_Escuela (codigo_escuela, telefono)
SELECT codigo_escuela, '1111-1111'
FROM Escuela;
GO

-- Nota: los valores pueden tener '1111-1111' o 11111111, dependiendo el tipo de dato definido. En este caso, Telefono_Escuela puede ser CHAR o INTERGER.
-- ===================================================================
-- ** EJERCICIOS: UPDATE **
-- 5. Actualice el teléfono de una de las escuelas por el número 8765-7865.

UPDATE Telefono_Escuela
SET telefono = '8765-7865'
WHERE codigo_escuela = 2;
GO
-- 6. Actualice la fecha de una reserva que usted seleccione por 23/12/2004
UPDATE Reserva
SET fecha_reserva = '2004-12-23'
WHERE numero_reserva = 1;
GO
-- 7. Debe realizarse un descuento en el arancel por alumno de $2 para todas las reservas de más de 10 alumnos.
UPDATE Reserva_Tipo_Visita
SET arancel_tipo_visita = arancel_tipo_visita - 2
WHERE cantidad_alumnos_reservados > 10;
GO
-- 8. Actualice el código de guía de las reservas que tengan asignado al guía 1 por el guía 2.
UPDATE Reserva_Tipo_Visita
SET codigo_guia = 2
WHERE codigo_guia = 1;
GO

-- ===================================================================
-- ** EJERCICIOS: DELETE **
-- 9. Borre todas las reservas con menos de 10 Alumnos.
DELETE FROM Reserva_Tipo_Visita
WHERE cantidad_alumnos_reservados < 10;
GO
-- 10. Elimine a todos los guías que no tengan cargado su nombre.
DELETE FROM Guia
WHERE nombre_guia IS NULL OR nombre_guia = '';
GO
--==================================================================
-- ** EJERCICIOS: SELECT **
-- 11. Obtenga un listado de todos los guías de nombre Bernardo.
SELECT *
FROM Guia
WHERE nombre_guia = 'Bernardo';
GO
-- 12. Se desea obtener la cantidad de reservas con fecha mayor a 03/01/2004.
SELECT COUNT(*) AS Cantidad_Reservas
FROM Reserva
WHERE fecha_reserva > '2004-01-03';
GO
-- 13. Se necesita conocer la cantidad total de alumnos reservados para cada reserva (agrupadas por reservas).
SELECT numero_reserva, SUM(cantidad_alumnos_reservados) AS Total_Alumnos
FROM Reserva_Tipo_Visita
GROUP BY numero_reserva;
GO
-- 14. Liste todas las reservas que posee una cantidad total de alumnos reservados mayor a 20.
SELECT numero_reserva, SUM(cantidad_alumnos_reservados) AS Total_Alumnos
FROM Reserva_Tipo_Visita
GROUP BY numero_reserva
HAVING SUM(cantidad_alumnos_reservados) > 20;
GO
-- 15. Muestre las reservas realizadas en las cuales la inasistencia a las visitas sea mayor a 5.
SELECT numero_reserva, SUM(cantidad_alumnos_reservados - cantidad_alumnos_reales) AS Total_Inasistentes
FROM Reserva_Tipo_Visita
GROUP BY numero_reserva
HAVING SUM(cantidad_alumnos_reservados - cantidad_alumnos_reales) > 5;
GO
-- 16. Obtenga la cantidad de escuelas que visitarán el parque después del '3/6/2004'.
SELECT COUNT(DISTINCT codigo_escuela) AS Cantidad_Escuelas
FROM Reserva
WHERE fecha_reserva > '2004-06-03';
GO

-- ==================================================================
-- ** EJERCICIOS: COMBINADOS **
-- 1. Insertar un nuevo guía con el número inmediato consecutivo al máximo existente.
INSERT INTO Guia (codigo_guia, nombre_guia, apellido_guia, sueldo_hora, domicilio_guia)
VALUES ((SELECT ISNULL(MAX(codigo_guia), 0) + 1 FROM Guia), 'Nuevo', 'Guia', 20.00, 'Calle Nueva 789');
GO
-- 2. Insertar un nuevo tipo de visita con el número inmediato consecutivo al máximo existente sin utilizar subconsultas.
DECLARE @nuevo_codigo tinyint;
SELECT @nuevo_codigo = ISNULL(MAX(codigo_tipo_visita), 0) + 1 FROM Tipo_Visita;
INSERT INTO Tipo_Visita (codigo_tipo_visita, descripcion_tipo_visita, arancel_tipo_visita)
VALUES (@nuevo_codigo, 'Nueva Visita', 50.00);
GO
-- 3. Insertar los datos de la tabla escuela en una nueva tabla, borre los datos de la tabla escuela.
-- En la nueva tabla realice una actualización de los códigos de escuela incrementándolos en uno.
-- Posteriormente reinsértelos en la tabla escuela y vuelva a la normalidad los códigos.

-- Copiar toda la estructura y datos de Escuela en una tabla nueva
SELECT * INTO Escuela_Copia FROM Escuela;
GO
-- Deshabilitar FKs que referencian Escuela para poder borrar sus filas
ALTER TABLE Reserva          NOCHECK CONSTRAINT ALL;
ALTER TABLE Telefono_Escuela NOCHECK CONSTRAINT ALL;
ALTER TABLE Email_Escuela    NOCHECK CONSTRAINT ALL;
GO
DELETE FROM Escuela;
GO
-- Incrementar los códigos en la copia
UPDATE Escuela_Copia SET codigo_escuela = codigo_escuela + 1;
GO
-- Reinsertar en Escuela con los códigos incrementados
INSERT INTO Escuela SELECT * FROM Escuela_Copia;
GO
-- Rehabilitar FKs (sin revalidar datos existentes, ya que los codigos se revertiran a continuacion)
ALTER TABLE Reserva          WITH NOCHECK CHECK CONSTRAINT ALL;
ALTER TABLE Telefono_Escuela WITH NOCHECK CHECK CONSTRAINT ALL;
ALTER TABLE Email_Escuela    WITH NOCHECK CHECK CONSTRAINT ALL;
GO
-- Volver a la normalidad: decrementar los códigos al valor original
UPDATE Escuela SET codigo_escuela = codigo_escuela - 1;
GO
DROP TABLE Escuela_Copia;
GO

-- 4. Las compañías telefónicas han decidido (por falta de números telefónicos!!),
-- que todas las líneas deben agregar un 9 como primer número.
-- Realice la actualización correspondiente en los teléfonos de las escuelas.
UPDATE Telefono_Escuela
SET telefono = '9' + telefono;
GO

-- 5. Debido a un feriado inesperado, las fechas de las visitas deben posponerse por un día.
UPDATE Reserva
SET fecha_reserva = DATEADD(DAY, 1, fecha_reserva);
GO

-- 6. Obtener los datos de la última reserva existente.
SELECT TOP 1 *
FROM Reserva
ORDER BY numero_reserva DESC;
GO

-- 7. Obtener los apellidos de los guias que se encuentren repetidos.
SELECT apellido_guia, COUNT(*) AS Cantidad
FROM Guia
GROUP BY apellido_guia
HAVING COUNT(*) > 1;
GO

-- 8. Obtener un listado con la cantidad de reservas por fecha.
SELECT fecha_reserva, COUNT(*) AS Cantidad_Reservas
FROM Reserva
GROUP BY fecha_reserva;
GO

-- 9. Obtener el promedio de alumnos asistentes, reservados
-- y la diferencia entre estos promedios.
SELECT
    AVG(cantidad_alumnos_reales) AS Promedio_Asistentes,
    AVG(cantidad_alumnos_reservados) AS Promedio_Reservados,
    AVG(cantidad_alumnos_reservados) - AVG(cantidad_alumnos_reales) AS Diferencia_Promedios
FROM Reserva_Tipo_Visita;
GO

-- 10. Obtener los guias que tengan más de 3 visitas
SELECT g.codigo_guia, g.nombre_guia, g.apellido_guia, COUNT(*) AS Cantidad_Visitas
FROM Guia g
JOIN Reserva_Tipo_Visita r ON g.codigo_guia = r.codigo_guia
GROUP BY g.codigo_guia, g.nombre_guia, g.apellido_guia
HAVING COUNT(*) > 3;
GO