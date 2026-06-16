-- ===================================================================
-- EJERCICIOS CLASE 5: SUBCONSULTAS
-- ===================================================================
USE Jurassic_Park_Practica;
GO
-- ===================================================================

-- ===================================================================
-- 1. Listar los tipos de visita que fueron guiadas alguna vez por Cristina Zaluzi.
-- ===================================================================

-- Variante A: subconsulta con IN anidado
SELECT codigo_tipo_visita, descripcion_tipo_visita
FROM Tipo_Visita
WHERE codigo_tipo_visita IN (
    SELECT codigo_tipo_visita
    FROM Reserva_Tipo_Visita
    WHERE codigo_guia IN (
        SELECT codigo_guia
        FROM Guia
        WHERE nombre_guia = 'Cristina' AND apellido_guia = 'Zaluzi'
    )
);
GO

-- Variante B: subconsulta escalar (si el nombre es unico devuelve un solo valor)
SELECT codigo_tipo_visita, descripcion_tipo_visita
FROM Tipo_Visita
WHERE codigo_tipo_visita IN (
    SELECT codigo_tipo_visita
    FROM Reserva_Tipo_Visita
    WHERE codigo_guia = (
        SELECT codigo_guia
        FROM Guia
        WHERE nombre_guia = 'Cristina' AND apellido_guia = 'Zaluzi'
    )
);
GO

-- ===================================================================
-- 2. Listar los nombres de escuela que visitaron en 2002 pero no lo hicieron en el 2001.
-- ===================================================================

-- Variante A: IN / NOT IN
SELECT nombre_escuela
FROM Escuela
WHERE codigo_escuela IN (
        SELECT codigo_escuela FROM Reserva WHERE YEAR(fecha_reserva) = 2002
    )
  AND codigo_escuela NOT IN (
        SELECT codigo_escuela FROM Reserva WHERE YEAR(fecha_reserva) = 2001
    );
GO

-- Variante B: EXISTS / NOT EXISTS
SELECT nombre_escuela
FROM Escuela e
WHERE EXISTS (
        SELECT 1 FROM Reserva r
        WHERE r.codigo_escuela = e.codigo_escuela
          AND YEAR(r.fecha_reserva) = 2002
    )
  AND NOT EXISTS (
        SELECT 1 FROM Reserva r
        WHERE r.codigo_escuela = e.codigo_escuela
          AND YEAR(r.fecha_reserva) = 2001
    );
GO

-- ===================================================================
-- 3. Listar los guias (codigo, nombre y apellido) asignados a mas de 2 tipos de visita
--    distintos y con una cantidad total real de alumnos guiados mayor a 200.
-- ===================================================================

-- Variante A: subconsulta con HAVING
SELECT codigo_guia, nombre_guia, apellido_guia
FROM Guia
WHERE codigo_guia IN (
    SELECT codigo_guia
    FROM Reserva_Tipo_Visita
    GROUP BY codigo_guia
    HAVING COUNT(DISTINCT codigo_tipo_visita) > 2
       AND SUM(cantidad_alumnos_reales) > 200
);
GO

-- Variante B: subconsultas escalares correlacionadas
SELECT codigo_guia, nombre_guia, apellido_guia
FROM Guia g
WHERE (
    SELECT COUNT(DISTINCT codigo_tipo_visita)
    FROM Reserva_Tipo_Visita
    WHERE codigo_guia = g.codigo_guia
) > 2
AND (
    SELECT SUM(cantidad_alumnos_reales)
    FROM Reserva_Tipo_Visita
    WHERE codigo_guia = g.codigo_guia
) > 200;
GO

-- ===================================================================
-- 4. Listar las escuelas que poseen mas de 1 reserva con mas de 2 tipos de visitas
--    para cada reserva.
-- ===================================================================

-- Primero: reservas con mas de 2 tipos de visita.
-- Despues: escuelas con mas de 1 de esas reservas.
SELECT codigo_escuela, nombre_escuela
FROM Escuela
WHERE codigo_escuela IN (
    SELECT codigo_escuela
    FROM Reserva
    WHERE numero_reserva IN (
        SELECT numero_reserva
        FROM Reserva_Tipo_Visita
        GROUP BY numero_reserva
        HAVING COUNT(DISTINCT codigo_tipo_visita) > 2
    )
    GROUP BY codigo_escuela
    HAVING COUNT(numero_reserva) > 1
);
GO

-- ===================================================================
-- 5. Listar nombre, apellido y codigo de guias que en alguna visita hayan atendido
--    al menos el 40% de los alumnos totales guiados en todas sus visitas.
-- ===================================================================

-- Subconsulta correlacionada: compara cada fila con el total del guia.
SELECT codigo_guia, nombre_guia, apellido_guia
FROM Guia
WHERE codigo_guia IN (
    SELECT rtv.codigo_guia
    FROM Reserva_Tipo_Visita rtv
    WHERE rtv.cantidad_alumnos_reales >= 0.4 * (
        SELECT SUM(cantidad_alumnos_reales)
        FROM Reserva_Tipo_Visita
        WHERE codigo_guia = rtv.codigo_guia
    )
);
GO

-- ===================================================================
-- 6. Listar nombre y codigo de escuelas que asistieron el dia con mayor cantidad
--    de alumnos reales registrados.
-- ===================================================================

-- La subconsulta mas interna obtiene la fecha con mayor SUM(alumnos_reales).
SELECT codigo_escuela, nombre_escuela
FROM Escuela
WHERE codigo_escuela IN (
    SELECT codigo_escuela
    FROM Reserva
    WHERE fecha_reserva = (
        SELECT TOP 1 r.fecha_reserva
        FROM Reserva r
        JOIN Reserva_Tipo_Visita rtv ON r.numero_reserva = rtv.numero_reserva
        GROUP BY r.fecha_reserva
        ORDER BY SUM(rtv.cantidad_alumnos_reales) DESC
    )
);
GO

-- ===================================================================
-- CLASE 5 - Adicionales
-- ===================================================================

-- ===================================================================
-- A1. Listar el codigo y nombre de las escuelas cuya fecha de reserva
--     sea igual a la primera fecha de reserva realizada.
-- ===================================================================

-- Variante A: subconsulta escalar con MIN
SELECT codigo_escuela, nombre_escuela
FROM Escuela
WHERE codigo_escuela IN (
    SELECT codigo_escuela
    FROM Reserva
    WHERE fecha_reserva = (
        SELECT MIN(fecha_reserva)
        FROM Reserva
    )
);
GO

-- Variante B: ALL (la fecha es menor o igual a todas las demas fechas)
SELECT codigo_escuela, nombre_escuela
FROM Escuela
WHERE codigo_escuela IN (
    SELECT codigo_escuela
    FROM Reserva
    WHERE fecha_reserva <= ALL (
        SELECT fecha_reserva FROM Reserva
    )
);
GO

-- ===================================================================
-- A2. Listar las escuelas que visitaron entre los anos 2001 y 2002.
-- ===================================================================

-- Variante A: IN con BETWEEN en el anio
SELECT codigo_escuela, nombre_escuela
FROM Escuela
WHERE codigo_escuela IN (
    SELECT codigo_escuela
    FROM Reserva
    WHERE YEAR(fecha_reserva) BETWEEN 2001 AND 2002
);
GO

-- Variante B: EXISTS con rango de fechas
SELECT codigo_escuela, nombre_escuela
FROM Escuela e
WHERE EXISTS (
    SELECT 1
    FROM Reserva r
    WHERE r.codigo_escuela = e.codigo_escuela
      AND r.fecha_reserva >= '2001-01-01'
      AND r.fecha_reserva <= '2002-12-31'
);
GO

-- ===================================================================
-- A3. Listar los guias que tuvieron mas de 3 escuelas diferentes y una
--     cantidad total real de alumnos mayor a 200.
-- ===================================================================

-- La cantidad de escuelas distintas requiere pasar por Reserva para obtener codigo_escuela.
-- Se usa JOIN dentro de la subconsulta para acceder a la relacion guia -> reserva -> escuela.
SELECT codigo_guia, nombre_guia, apellido_guia
FROM Guia
WHERE codigo_guia IN (
    SELECT rtv.codigo_guia
    FROM Reserva_Tipo_Visita rtv
    JOIN Reserva r ON rtv.numero_reserva = r.numero_reserva
    GROUP BY rtv.codigo_guia
    HAVING COUNT(DISTINCT r.codigo_escuela) > 3
       AND SUM(rtv.cantidad_alumnos_reales) > 200
);
GO

-- ===================================================================
-- A4. Listar los nombres y codigos de escuelas con gasto total de todas
--     las visitas mayor a $1700.
--     (gasto = cantidad_alumnos_reales * arancel_tipo_visita)
-- ===================================================================

SELECT codigo_escuela, nombre_escuela
FROM Escuela
WHERE codigo_escuela IN (
    SELECT r.codigo_escuela
    FROM Reserva r
    JOIN Reserva_Tipo_Visita rtv ON r.numero_reserva = rtv.numero_reserva
    JOIN Tipo_Visita tv ON rtv.codigo_tipo_visita = tv.codigo_tipo_visita
    GROUP BY r.codigo_escuela
    HAVING SUM(rtv.cantidad_alumnos_reales * tv.arancel_tipo_visita) > 1700
);
GO

-- ===================================================================
-- A5. Listar los guias que en solo un tipo de visita de una reserva en
--     particular hayan tenido al menos el 45% del total de alumnos que
--     esa persona atendio.
-- ===================================================================

-- Subconsulta correlacionada: igual al ejercicio 5 principal pero con umbral 0.45.
SELECT codigo_guia, nombre_guia, apellido_guia
FROM Guia
WHERE codigo_guia IN (
    SELECT rtv.codigo_guia
    FROM Reserva_Tipo_Visita rtv
    WHERE rtv.cantidad_alumnos_reales >= 0.45 * (
        SELECT SUM(cantidad_alumnos_reales)
        FROM Reserva_Tipo_Visita
        WHERE codigo_guia = rtv.codigo_guia
    )
);
GO
