-- ===================================================================
-- EJERCICIOS CLASE 4: CONSULTAS MULTITABLA
-- ===================================================================
USE Jurassic_Park_Practica;
GO
-- ===================================================================
-- ** EJERCICIOS: CLASE 4 **
-- 1. Listar las escuelas cuyos domicilios sean de calles que empiecen con S,
-- indicando nombre, domicilio y teléfono. Hacer una versión en la que aparezcan
-- sólo las que tienen teléfono,.
SELECT e.nombre_escuela, e.calle_escuela, e.altura_escuela, te.telefono
FROM Escuela e
LEFT JOIN Telefono_Escuela te ON e.codigo_escuela = te.codigo_escuela
WHERE e.calle_escuela LIKE 'S%';
GO

-- y hacer otra en la que aparezca solo las escuelas
-- con domicilio en calles que empiecen con S y que no tienen ningún teléfono
SELECT e.nombre_escuela, e.calle_escuela, e.altura_escuela
FROM Escuela e
LEFT JOIN Telefono_Escuela te ON e.codigo_escuela = te.codigo_escuela
WHERE e.calle_escuela LIKE 'S%' AND te.telefono IS NULL;
GO

-- 2. Listar las reservas mostrando día, nombre de escuela, cantidad de alumnos
-- de reserva y el nombre del guía.
SELECT r.fecha_reserva, e.nombre_escuela, rt.cantidad_alumnos_reservados, g.nombre_guia, g.apellido_guia
FROM Reserva r
JOIN Escuela e ON r.codigo_escuela = e.codigo_escuela
JOIN Reserva_Tipo_Visita rt ON r.numero_reserva = rt.numero_reserva
JOIN Guia g ON rt.codigo_guia = g.codigo_guia;
GO

-- 3. Listar las reservas, la cantidad total real de alumnos y el valor total
-- (cantidad x arancel con iva incluido).
SELECT r.numero_reserva, SUM(rt.cantidad_alumnos_reservados) AS cantidad_total_alumnos, 
       SUM(rt.cantidad_alumnos_reservados * tv.arancel_tipo_visita) AS valor_total
FROM Reserva r
JOIN Reserva_Tipo_Visita rt ON r.numero_reserva = rt.numero_reserva
JOIN Tipo_Visita tv ON rt.codigo_tipo_visita = tv.codigo_tipo_visita
GROUP BY r.numero_reserva;
GO

-- 4. Listar las reservas y los nombres de escuelas con valor total mayor a $1.000.
SELECT r.numero_reserva, e.nombre_escuela, SUM(rt.cantidad_alumnos_reservados * tv.arancel_tipo_visita) AS valor_total
FROM Reserva r
JOIN Escuela e ON r.codigo_escuela = e.codigo_escuela
JOIN Reserva_Tipo_Visita rt ON r.numero_reserva = rt.numero_reserva
JOIN Tipo_Visita tv ON rt.codigo_tipo_visita = tv.codigo_tipo_visita
GROUP BY r.numero_reserva, e.nombre_escuela
HAVING SUM(rt.cantidad_alumnos_reservados * tv.arancel_tipo_visita) > 1000;
GO

-- 5. Listar las escuelas que fueron atendidas alguna vez por el guía “Eleonora Fernandez”.
SELECT DISTINCT e.nombre_escuela
FROM Escuela e
JOIN Reserva r ON e.codigo_escuela = r.codigo_escuela
JOIN Reserva_Tipo_Visita rt ON r.numero_reserva = rt.numero_reserva
JOIN Guia g ON rt.codigo_guia = g.codigo_guia
WHERE g.nombre_guia = 'Eleonora' AND g.apellido_guia = 'Fernandez';
GO

-- 6. Listar las escuelas que realizaron más de una reserva para el mismo día.
SELECT e.nombre_escuela, r.fecha_reserva, COUNT(*) AS cantidad_reservas
FROM Escuela e
JOIN Reserva r ON e.codigo_escuela = r.codigo_escuela
GROUP BY e.nombre_escuela, r.fecha_reserva
HAVING COUNT(*) > 1;
GO

-- 7. Listar los nombres de los guías y la cantidad de visitas para aquellos con más
-- de 3 visitas de 30 personas.
SELECT g.nombre_guia, g.apellido_guia, COUNT(*) AS cantidad_visitas
FROM Guia g
JOIN Reserva_Tipo_Visita rt ON g.codigo_guia = rt.codigo_guia
WHERE rt.cantidad_alumnos_reservados = 30
GROUP BY g.nombre_guia, g.apellido_guia
HAVING COUNT(*) > 3;
GO

-- 8. Listar las reservas, el día, la cantidad total de alumnos por tipo de visita,
-- el nombre de la escuela y el nombre del guía.
SELECT r.numero_reserva, r.fecha_reserva, tv.descripcion_tipo_visita, SUM(rt.cantidad_alumnos_reservados) AS cantidad_total_alumnos,
       e.nombre_escuela, g.nombre_guia, g.apellido_guia
FROM Reserva r
JOIN Reserva_Tipo_Visita rt ON r.numero_reserva = rt.numero_reserva
JOIN Tipo_Visita tv ON rt.codigo_tipo_visita = tv.codigo_tipo_visita
JOIN Escuela e ON r.codigo_escuela = e.codigo_escuela
JOIN Guia g ON rt.codigo_guia = g.codigo_guia
GROUP BY r.numero_reserva, r.fecha_reserva, tv.descripcion_tipo_visita, e.nombre_escuela, g.nombre_guia, g.apellido_guia;
GO

-- ===================================================================
-- CLASE 4 - Adicionales
-- ===================================================================
-- 1. Listar los tipos de visita (Codigo y Descripción) que han sido asignadas más de 5 veces.
SELECT tv.codigo_tipo_visita, tv.descripcion_tipo_visita, COUNT(*) AS cantidad_asignaciones
FROM Tipo_Visita tv
JOIN Reserva_Tipo_Visita rt ON tv.codigo_tipo_visita = rt.codigo_tipo_visita
GROUP BY tv.codigo_tipo_visita, tv.descripcion_tipo_visita
HAVING COUNT(*) > 5;
GO

-- 2. Listar los Guias (Apellido y Nombre) que no han sido nunca asignados a una reserva.
SELECT g.nombre_guia, g.apellido_guia
FROM Guia g
LEFT JOIN Reserva_Tipo_Visita rt ON g.codigo_guia = rt.codigo_guia
WHERE rt.numero_reserva IS NULL;
GO

-- 3. Listar los Guias (Apellido y Nombre) con visitas de escuelas cuyo nombre no comience con “E”.
SELECT DISTINCT g.nombre_guia, g.apellido_guia
FROM Guia g
JOIN Reserva_Tipo_Visita rt ON g.codigo_guia = rt.codigo_guia
JOIN Reserva r ON rt.numero_reserva = r.numero_reserva
JOIN Escuela e ON r.codigo_escuela = e.codigo_escuela
WHERE e.nombre_escuela NOT LIKE 'E%';
GO

-- 4. Listar las escuelas (Nombre) que tengan visitas en donde la cantidad de alumnos reservada sea
-- igual a la cantidad de alumnos reales asistentes.
SELECT DISTINCT e.nombre_escuela
FROM Escuela e
JOIN Reserva r ON e.codigo_escuela = r.codigo_escuela
JOIN Reserva_Tipo_Visita rt ON r.numero_reserva = rt.numero_reserva
WHERE rt.cantidad_alumnos_reservados = rt.cantidad_alumnos_reales;
GO

-- 5. Realizar la Union de las consultas:
-- Nombres de las escuelas con reservas antes de las 9:00 hs
-- Apellidos de los guías cuyos nombres comiencen con „V‟ Ordenar el resultado en forma descendente
SELECT e.nombre_escuela AS Nombre
FROM Escuela e
JOIN Reserva r ON e.codigo_escuela = r.codigo_escuela
WHERE r.hora_reserva < '09:00:00'   
UNION
SELECT g.apellido_guia AS Nombre
FROM Guia g
WHERE g.nombre_guia LIKE 'V%'
ORDER BY Nombre DESC;
GO

-- 6. Listar los Nombres y Teléfonos de las Escuelas que concurrieron a la visita: „Los Mamuts en Familia‟
SELECT e.nombre_escuela, te.telefono
FROM Escuela e
JOIN Telefono_Escuela te ON e.codigo_escuela = te.codigo_escuela
JOIN Reserva r ON e.codigo_escuela = r.codigo_escuela
JOIN Reserva_Tipo_Visita rt ON r.numero_reserva = rt.numero_reserva
JOIN Tipo_Visita tv ON rt.codigo_tipo_visita = tv.codigo_tipo_visita
WHERE tv.descripcion_tipo_visita = 'Los Mamuts en Familia';
GO
-- 7. Listar para cada grado (sin importar de cual escuela) cual fue la última vez que hicieron una visita
SELECT rg.codigo_grado, MAX(r.fecha_reserva) AS Ultima_Visita
FROM Escuela e
JOIN Reserva r ON e.codigo_escuela = r.codigo_escuela
JOIN Reserva_por_Grado rg ON r.numero_reserva = rg.numero_reserva
GROUP BY rg.codigo_grado;
GO

-- 8. Insertar en una nueva tabla llamada Guia_Performance los datos del Guia y las sumas de las cantidades
-- reservadas y reales del año 2003.
SELECT g.codigo_guia, g.nombre_guia, g.apellido_guia, 
       SUM(rt.cantidad_alumnos_reservados) AS Total_Reservados, 
       SUM(rt.cantidad_alumnos_reales) AS Total_Reales
INTO Guia_Performance
FROM Guia g
JOIN Reserva_Tipo_Visita rt ON g.codigo_guia = rt.codigo_guia
JOIN Reserva r ON rt.numero_reserva = r.numero_reserva
WHERE YEAR(r.fecha_reserva) = 2003
GROUP BY g.codigo_guia, g.nombre_guia, g.apellido_guia;
GO

SELECT *
FROM Guia_Performance;
GO