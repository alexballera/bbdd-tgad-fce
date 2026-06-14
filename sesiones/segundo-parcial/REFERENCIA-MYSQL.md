# Guía de Referencia MySQL — Segundo Parcial BBDD

**Materia:** Bases de Datos — TGAD, FCE-UBA  
**Fecha:** Junio 2026  
**Motor:** MySQL 8.0+

> 📌 **Este documento es el equivalente MySQL de `REFERENCIA-SQL-SERVER.md`.**  
> Al final de cada sección se destacan las diferencias más importantes respecto a SQL Server.

---

## 📌 Tabla de Contenidos

1. [Conexión y Configuración](#conexión-y-configuración)
2. [DDL — Lenguaje de Definición de Datos](#ddl--lenguaje-de-definición-de-datos)
3. [DML — Lenguaje de Manipulación de Datos](#dml--lenguaje-de-manipulación-de-datos)
4. [Consultas SELECT](#consultas-select)
5. [Funciones de Agregación](#funciones-de-agregación)
6. [JOINs](#joins)
7. [Subconsultas](#subconsultas)
8. [Variables y Expresiones](#variables-y-expresiones)
9. [Operadores de Conjuntos](#operadores-de-conjuntos)
10. [Transacciones](#transacciones)
11. [Procedimientos Almacenados](#procedimientos-almacenados)
12. [Triggers (Disparadores)](#triggers-disparadores)
13. [Conceptos Clave](#conceptos-clave)

---

## Conexión y Configuración

### 🔷 Desde la Línea de Comandos (CLI) con `mysql`

El cliente `mysql` se instala con MySQL Server o MySQL Client. En Windows, suele quedar en:
```
C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe
```

**Agregar al PATH** (opcional, en PowerShell):
```powershell
$env:PATH += ";C:\Program Files\MySQL\MySQL Server 8.0\bin"
```

O de forma permanente desde Variables de Entorno del sistema.

#### Comandos de Conexión

**Conectar al servidor local:**
```bash
mysql -u root -p
```
Pedirá la contraseña interactivamente.

**Conectar sin pausa para contraseña (no recomendado en producción):**
```bash
mysql -u root -pMiContraseña
```

**Parámetros comunes:**

| Parámetro | Descripción |
|-----------|------------|
| `-u usuario` | Nombre de usuario |
| `-p` | Solicitar contraseña (interactivo) |
| `-h host` | Servidor (por defecto: `localhost`) |
| `-P puerto` | Puerto (por defecto: `3306`) |
| `-D base_de_datos` | Base de datos inicial |
| `--ssl-mode=DISABLED` | Deshabilitar SSL (solo dev) |

**Conectar directamente a una base de datos:**
```bash
mysql -u root -p jurasik_park
```

**Ejecutar un script SQL:**
```bash
mysql -u root -p jurasik_park < script.sql
```

**Ejecutar un script y guardar resultados:**
```bash
mysql -u root -p jurasik_park < script.sql > resultados.txt
```

#### Comandos Interactivos de `mysql`

| Comando | Descripción |
|---------|------------|
| `;` o `\g` | Ejecuta la consulta actual |
| `\G` | Ejecuta y muestra resultados en formato vertical |
| `\q` o `EXIT` o `QUIT` | Sale del cliente |
| `\c` | Cancela la consulta actual sin ejecutar |
| `source archivo.sql` | Ejecuta un archivo SQL |
| `\! comando` | Ejecuta un comando del sistema operativo |

> ⚠️ **Diferencia con SQL Server:** MySQL NO usa `GO` como separador de batches. Cada sentencia termina con `;`. No hay concepto de "batch" como en T-SQL.

#### Comandos de Gestión de Bases de Datos

**Listar bases de datos:**
```sql
SHOW DATABASES;
```

**Seleccionar base de datos:**
```sql
USE jurasik_park;
```

**Crear base de datos:**
```sql
CREATE DATABASE jurasik_park;
-- O con codificación explícita (recomendado):
CREATE DATABASE jurasik_park
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_spanish_ci;
```

**Eliminar base de datos:**
```sql
DROP DATABASE jurasik_park;
```

**Listar tablas de la BD actual:**
```sql
SHOW TABLES;
```

**Ver estructura de una tabla:**
```sql
DESCRIBE escuela;
-- o también:
SHOW COLUMNS FROM escuela;
```

**Ver el DDL completo de una tabla:**
```sql
SHOW CREATE TABLE escuela;
```

### 🔷 Desde VS Code (Extensión MySQL)

1. Instalar extensión **MySQL** de cweijan (o similar)
2. `Ctrl+Shift+P` → **MySQL: Add Connection**
3. Configuración:
   - Host: `localhost`
   - Port: `3306`
   - User: `root`
   - Password: tu contraseña
4. Ejecutar consultas: `Ctrl+Enter`

---

## DDL — Lenguaje de Definición de Datos

### 📋 CREATE TABLE

**Sintaxis básica:**
```sql
CREATE TABLE nombre_tabla (
    columna1 tipo_dato [restricciones],
    columna2 tipo_dato [restricciones],
    ...
    [restricciones_tabla]
) ENGINE=InnoDB;
```

**Ejemplo completo:**
```sql
CREATE TABLE escuela (
    Codigo_escuela SMALLINT NOT NULL,
    Nombre_escuela VARCHAR(100) NOT NULL,
    Domicilio_escuela VARCHAR(200) NOT NULL,
    Fecha_fundacion DATE,
    Activa TINYINT(1) DEFAULT 1,
    PRIMARY KEY (Codigo_escuela)
) ENGINE=InnoDB;
```

> ⚠️ **Diferencias con SQL Server:**
> - Se usa `TINYINT(1)` en lugar de `BIT` para booleanos
> - Se recomienda especificar `ENGINE=InnoDB` para soporte de transacciones y FK
> - No existe `NONCLUSTERED` en la definición de PRIMARY KEY
> - Se puede agregar `CHARACTER SET utf8mb4` al crear la tabla

### 📐 Tipos de Datos Comunes

| Tipo MySQL | Descripción | Equivalente SQL Server |
|------------|-------------|----------------------|
| `INT` | Entero (-2,147,483,648 a 2,147,483,647) | `INT` |
| `INT UNSIGNED` | Entero sin signo (0 a 4,294,967,295) | — |
| `SMALLINT` | Entero pequeño (-32,768 a 32,767) | `SMALLINT` |
| `TINYINT` | Entero muy pequeño (-128 a 127) | `TINYINT` |
| `BIGINT` | Entero grande | `BIGINT` |
| `DECIMAL(p,s)` | Número decimal de precisión fija | `DECIMAL(p,s)` |
| `VARCHAR(n)` | Cadena variable hasta n caracteres | `VARCHAR(n)` |
| `CHAR(n)` | Cadena fija de n caracteres | `CHAR(n)` |
| `TEXT` | Texto largo (hasta 65,535 bytes) | `VARCHAR(MAX)` |
| `MEDIUMTEXT` | Hasta 16 MB | — |
| `LONGTEXT` | Hasta 4 GB | — |
| `DATE` | Fecha (YYYY-MM-DD) | `DATE` |
| `TIME` | Hora (HH:MM:SS) | — |
| `DATETIME` | Fecha y hora | `DATETIME` |
| `TIMESTAMP` | Fecha y hora (con zona horaria) | — |
| `TINYINT(1)` | Booleano (0 o 1) | `BIT` |
| `ENUM('v1','v2')` | Lista de valores permitidos | `CHECK` con lista |

### 🔑 Restricciones (CONSTRAINTS)

**PRIMARY KEY:**
```sql
CREATE TABLE guia (
    Codigo_Guia SMALLINT NOT NULL,
    Apellido_Guia VARCHAR(60) NOT NULL,
    Nombre_Guia VARCHAR(60) NOT NULL,
    PRIMARY KEY (Codigo_Guia)
);
```

**AUTO_INCREMENT (equivalente a IDENTITY en SQL Server):**
```sql
CREATE TABLE guia (
    Codigo_Guia INT NOT NULL AUTO_INCREMENT,
    Apellido_Guia VARCHAR(60) NOT NULL,
    Nombre_Guia VARCHAR(60) NOT NULL,
    PRIMARY KEY (Codigo_Guia)
);
```

> ⚠️ **Diferencia:** SQL Server usa `IDENTITY(1,1)`, MySQL usa `AUTO_INCREMENT`.

**FOREIGN KEY:**
```sql
CREATE TABLE reserva (
    Numero_Reserva INT NOT NULL,
    Fecha_Visita_Reservada DATETIME NOT NULL,
    Codigo_escuela SMALLINT NOT NULL,
    PRIMARY KEY (Numero_Reserva),
    CONSTRAINT FK_codigo_escuela
        FOREIGN KEY (Codigo_escuela)
        REFERENCES escuela(Codigo_escuela)
);
```

**Clave primaria compuesta:**
```sql
CREATE TABLE telefono_escuela (
    Codigo_escuela SMALLINT NOT NULL,
    Telefono_escuela VARCHAR(16) NOT NULL,
    PRIMARY KEY (Codigo_escuela, Telefono_escuela),
    CONSTRAINT FK_codigo_escuela2
        FOREIGN KEY (Codigo_escuela)
        REFERENCES escuela(Codigo_escuela)
);
```

**Otras restricciones:**
```sql
CREATE TABLE tipo_visita (
    Codigo_Tipo_Visita TINYINT NOT NULL,
    Descripcion_Tipo_Visita VARCHAR(200) NOT NULL,
    Arancel_por_alumno DECIMAL(8,2) NOT NULL,
    Activo TINYINT(1) DEFAULT 1,
    Fecha_alta DATE DEFAULT (CURDATE()),
    CHECK (Arancel_por_alumno >= 0),
    UNIQUE (Descripcion_Tipo_Visita),
    PRIMARY KEY (Codigo_Tipo_Visita)
) ENGINE=InnoDB;
```

> ⚠️ **Diferencia:** `DEFAULT GETDATE()` → `DEFAULT (CURDATE())` o `DEFAULT CURRENT_TIMESTAMP`

### ✏️ ALTER TABLE

**Agregar columna:**
```sql
ALTER TABLE escuela
ADD COLUMN Email VARCHAR(100);
```

**Modificar columna:**
```sql
ALTER TABLE escuela
MODIFY COLUMN Email VARCHAR(150);
```

> ⚠️ **Diferencia:** SQL Server usa `ALTER COLUMN`, MySQL usa `MODIFY COLUMN`.

**Renombrar columna (MySQL 8.0+):**
```sql
ALTER TABLE escuela
RENAME COLUMN Email TO Correo;
```

**Eliminar columna:**
```sql
ALTER TABLE escuela
DROP COLUMN Email;
```

**Agregar restricción:**
```sql
ALTER TABLE escuela
ADD CONSTRAINT UQ_Nombre UNIQUE (Nombre_escuela);
```

**Agregar clave foránea después:**
```sql
ALTER TABLE reserva_tipo_visita
ADD CONSTRAINT FK_numero_reserva1
    FOREIGN KEY (Numero_Reserva)
    REFERENCES reserva(Numero_Reserva);
```

### 🗑️ DROP TABLE

```sql
DROP TABLE nombre_tabla;
```

**Con IF EXISTS:**
```sql
DROP TABLE IF EXISTS nombre_tabla;
```

### 🔄 TRUNCATE TABLE

```sql
TRUNCATE TABLE nombre_tabla;
```

> ⚠️ **Diferencia:** En MySQL, `TRUNCATE` también reinicia los contadores `AUTO_INCREMENT`. No puede usarse con FK activas (igual que SQL Server).

---

## DML — Lenguaje de Manipulación de Datos

### ➕ INSERT

**Insertar un registro:**
```sql
INSERT INTO escuela (Codigo_escuela, Nombre_escuela, Domicilio_escuela)
VALUES (1, 'Escuela Domingo Faustino Sarmiento', 'Soler 219, Capital Federal');
```

**Insertar múltiples registros:**
```sql
INSERT INTO escuela VALUES
    (1, 'Escuela Domingo Faustino Sarmiento', 'Soler 219, Capital Federal', NULL, 1),
    (2, 'Instituto Santa Elena', 'Las Acacias 23 Pinamar', NULL, 1),
    (3, 'Escuela Nacional Nro 4 Nicolas Avellaneda', 'Salvador y Nicaragua s/n Cordoba', NULL, 1);
```

**Insertar desde otra tabla:**
```sql
INSERT INTO escuela_backup (Codigo_escuela, Nombre_escuela, Domicilio_escuela)
SELECT Codigo_escuela, Nombre_escuela, Domicilio_escuela
FROM escuela
WHERE Codigo_escuela < 10;
```

**INSERT ... ON DUPLICATE KEY UPDATE (específico de MySQL):**
```sql
-- Si la clave ya existe, actualiza en lugar de fallar
INSERT INTO tipo_visita (Codigo_Tipo_Visita, Descripcion_Tipo_Visita, Arancel_por_alumno)
VALUES (1, 'Visita Completa', 15.00)
ON DUPLICATE KEY UPDATE Arancel_por_alumno = 15.00;
```

### 🔄 UPDATE

**Actualizar registros:**
```sql
UPDATE escuela
SET Domicilio_escuela = 'Av. Corrientes 1234, CABA'
WHERE Codigo_escuela = 5;
```

**Actualizar múltiples columnas:**
```sql
UPDATE tipo_visita
SET Descripcion_Tipo_Visita = 'Parque Jurásico Completo',
    Arancel_por_alumno = 12.50
WHERE Codigo_Tipo_Visita = 1;
```

**Actualizar con cálculos:**
```sql
UPDATE tipo_visita
SET Arancel_por_alumno = Arancel_por_alumno * 1.10
WHERE Codigo_Tipo_Visita IN (1, 2, 3);
```

**Actualizar con JOIN:**
```sql
UPDATE reserva_tipo_visita rtv
INNER JOIN reserva r ON rtv.Numero_Reserva = r.Numero_Reserva
SET rtv.Cantidad_alumnos_Reales = rtv.Cantidad_alumnos_Reservados
WHERE r.Fecha_Visita_Reservada < '2010-01-01';
```

> ⚠️ **Diferencia:** En SQL Server el UPDATE con JOIN usa `FROM`. En MySQL, se escribe `UPDATE tabla1 INNER JOIN tabla2 ON ... SET ...`.

### ❌ DELETE

**Eliminar registros:**
```sql
DELETE FROM telefono_escuela
WHERE Codigo_escuela = 5;
```

**Eliminar con subconsulta:**
```sql
DELETE FROM reserva
WHERE Codigo_escuela IN (
    SELECT Codigo_escuela
    FROM escuela
    WHERE Nombre_escuela LIKE '%Cerrada%'
);
```

> ⚠️ **Nota MySQL:** No se puede referenciar en la subconsulta la misma tabla que se está eliminando. Si es necesario, usar una tabla derivada.

**Eliminar todos los registros:**
```sql
DELETE FROM nombre_tabla;
-- O más eficiente si no hay FK:
TRUNCATE TABLE nombre_tabla;
```

---

## Consultas SELECT

### 🔍 Sintaxis General

```sql
SELECT [DISTINCT | ALL] columnas
FROM tabla(s)
[WHERE condiciones]
[GROUP BY columnas]
[HAVING condiciones_agregadas]
[ORDER BY columnas [ASC | DESC]]
[LIMIT n [OFFSET m]]
```

### 📊 SELECT Básico

**Seleccionar todas las columnas:**
```sql
SELECT * FROM escuela;
```

**Con alias:**
```sql
SELECT
    Nombre_escuela AS Escuela,
    Domicilio_escuela AS Direccion
FROM escuela;
```

### 🎯 LIMIT (equivalente a TOP en SQL Server)

> ⚠️ **Diferencia importante:** MySQL usa `LIMIT` al final, SQL Server usa `TOP` al principio.

**Primeros n registros:**
```sql
SELECT * FROM escuela LIMIT 5;
```

**Con ORDER BY:**
```sql
SELECT Nombre_escuela, Arancel_por_alumno
FROM tipo_visita
ORDER BY Arancel_por_alumno DESC
LIMIT 10;
```

**Paginación — LIMIT con OFFSET:**
```sql
-- Registros 11 al 20 (segunda página de 10)
SELECT * FROM escuela
ORDER BY Codigo_escuela
LIMIT 10 OFFSET 10;

-- Sintaxis equivalente (menos legible):
SELECT * FROM escuela
ORDER BY Codigo_escuela
LIMIT 10, 10;  -- LIMIT offset, cantidad
```

> ⚠️ **No existe TOP PERCENT en MySQL.** Se debe calcular manualmente.

### 🔎 WHERE — Condiciones

**Operadores de comparación:** Idénticos a SQL Server (`=`, `<>`, `!=`, `>`, `>=`, `<`, `<=`).

**BETWEEN, IN, LIKE, IS NULL:** Misma sintaxis que SQL Server.

**LIKE — Wildcards:**
```sql
-- % equivale a "cualquier cantidad de caracteres"
-- _ equivale a "exactamente un carácter"
SELECT * FROM escuela WHERE Nombre_escuela LIKE 'Escuela%';
SELECT * FROM escuela WHERE Nombre_escuela LIKE '_a%';
```

**REGEXP (específico de MySQL):**
```sql
-- Escuelas cuyo nombre empieza con "E" o "I"
SELECT * FROM escuela WHERE Nombre_escuela REGEXP '^[EI]';
```

### 📈 ORDER BY

Idéntico a SQL Server. `ASC` es el valor por defecto.

```sql
SELECT * FROM tipo_visita
ORDER BY Arancel_por_alumno DESC;
```

### 🔢 DISTINCT

Idéntico a SQL Server.

```sql
SELECT DISTINCT Codigo_escuela FROM reserva;
```

---

## Funciones de Agregación

### 📊 Funciones Principales

Idénticas a SQL Server: `COUNT`, `SUM`, `AVG`, `MAX`, `MIN`.

```sql
SELECT COUNT(*) AS Total FROM reserva;
SELECT SUM(Cantidad_alumnos_Reservados) AS Total FROM reserva_tipo_visita;
SELECT AVG(Arancel_por_alumno) AS Promedio FROM tipo_visita;
SELECT MAX(Arancel_por_alumno) AS Maximo FROM tipo_visita;
SELECT MIN(Arancel_por_alumno) AS Minimo FROM tipo_visita;
```

### 📊 GROUP BY

**Regla fundamental:** Igual que SQL Server — toda columna en `SELECT` que no sea función de agregación debe estar en `GROUP BY`.

```sql
SELECT Codigo_escuela, COUNT(*) AS Total_Reservas
FROM reserva
GROUP BY Codigo_escuela;
```

> ⚠️ **Diferencia:** MySQL por defecto tiene `ONLY_FULL_GROUP_BY` desactivado en versiones antiguas, lo que permitía SELECT con columnas no agrupadas (comportamiento incorrecto). En MySQL 8.0, `ONLY_FULL_GROUP_BY` está activado por defecto, respetando el estándar SQL.

### 🔍 HAVING

Idéntico a SQL Server. Filtra después de agrupar.

```sql
SELECT Codigo_escuela, COUNT(*) AS Total_Reservas
FROM reserva
GROUP BY Codigo_escuela
HAVING COUNT(*) > 5;
```

---

## JOINs

### Tipos de JOIN

Todos los tipos son iguales a SQL Server: `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `CROSS JOIN`, `SELF JOIN`.

> ⚠️ **Diferencia:** MySQL **NO tiene `FULL OUTER JOIN`**. Se simula con `UNION` de `LEFT JOIN` y `RIGHT JOIN`.

**INNER JOIN:**
```sql
SELECT
    r.Numero_Reserva,
    r.Fecha_Visita_Reservada,
    e.Nombre_escuela
FROM reserva r
INNER JOIN escuela e ON r.Codigo_escuela = e.Codigo_escuela;
```

**LEFT JOIN:**
```sql
SELECT
    e.Codigo_escuela,
    e.Nombre_escuela,
    COUNT(r.Numero_Reserva) AS Total_Reservas
FROM escuela e
LEFT JOIN reserva r ON e.Codigo_escuela = r.Codigo_escuela
GROUP BY e.Codigo_escuela, e.Nombre_escuela;
```

**Simular FULL OUTER JOIN con UNION:**
```sql
SELECT e.Nombre_escuela, r.Numero_Reserva
FROM escuela e
LEFT JOIN reserva r ON e.Codigo_escuela = r.Codigo_escuela

UNION

SELECT e.Nombre_escuela, r.Numero_Reserva
FROM escuela e
RIGHT JOIN reserva r ON e.Codigo_escuela = r.Codigo_escuela;
```

**CROSS JOIN:**
```sql
SELECT e.Nombre_escuela, tv.Descripcion_Tipo_Visita
FROM escuela e
CROSS JOIN tipo_visita tv;
```

**SELF JOIN:**
```sql
SELECT
    g1.Codigo_Guia AS Guia1_ID,
    CONCAT(g1.Nombre_Guia, ' ', g1.Apellido_Guia) AS Guia1,
    g2.Codigo_Guia AS Guia2_ID,
    CONCAT(g2.Nombre_Guia, ' ', g2.Apellido_Guia) AS Guia2
FROM guia g1
INNER JOIN guia g2 ON g1.Apellido_Guia = g2.Apellido_Guia
WHERE g1.Codigo_Guia < g2.Codigo_Guia;
```

> ⚠️ **Diferencia:** En MySQL se usa `CONCAT(a, b)` para concatenar, no el operador `+`.

---

## Subconsultas

### 🔍 Subconsulta en WHERE

```sql
-- Tipos de visita con arancel mayor al promedio
SELECT Codigo_Tipo_Visita, Descripcion_Tipo_Visita, Arancel_por_alumno
FROM tipo_visita
WHERE Arancel_por_alumno > (
    SELECT AVG(Arancel_por_alumno) FROM tipo_visita
);
```

**Con IN:**
```sql
-- Escuelas que tienen reservas en 2021
SELECT Nombre_escuela
FROM escuela
WHERE Codigo_escuela IN (
    SELECT DISTINCT Codigo_escuela
    FROM reserva
    WHERE YEAR(Fecha_Visita_Reservada) = 2021
);
```

### 🔍 Subconsulta en FROM

```sql
SELECT Rango, AVG(Arancel_por_alumno) AS Promedio
FROM (
    SELECT
        Codigo_Tipo_Visita,
        Arancel_por_alumno,
        CASE
            WHEN Arancel_por_alumno < 10 THEN 'Bajo'
            WHEN Arancel_por_alumno BETWEEN 10 AND 20 THEN 'Medio'
            ELSE 'Alto'
        END AS Rango
    FROM tipo_visita
) AS Subconsulta
GROUP BY Rango;
```

> ⚠️ **Diferencia:** En MySQL, toda subconsulta en `FROM` **debe tener un alias** (obligatorio). En SQL Server también es buena práctica, pero en MySQL es un error de sintaxis omitirlo.

### 🔍 Subconsulta en SELECT

```sql
SELECT
    e.Nombre_escuela,
    (SELECT COUNT(*)
     FROM reserva r
     WHERE r.Codigo_escuela = e.Codigo_escuela) AS Total_Reservas
FROM escuela e;
```

### 🔍 EXISTS / NOT EXISTS

Idénticos a SQL Server.

```sql
-- Escuelas con al menos una reserva
SELECT Nombre_escuela
FROM escuela e
WHERE EXISTS (
    SELECT 1
    FROM reserva r
    WHERE r.Codigo_escuela = e.Codigo_escuela
);
```

### 🔍 ANY / ALL

Idénticos a SQL Server.

```sql
SELECT Descripcion_Tipo_Visita, Arancel_por_alumno
FROM tipo_visita
WHERE Arancel_por_alumno > ALL (
    SELECT Arancel_por_alumno
    FROM tipo_visita
    WHERE Arancel_por_alumno < 5
);
```

---

## Variables y Expresiones

### 📦 Variables de Usuario

> ⚠️ **Diferencia importante:** En MySQL las variables de usuario se crean con `SET @variable` sin necesidad de `DECLARE`. El `DECLARE` solo se usa dentro de procedimientos almacenados.

**Declarar y asignar:**
```sql
SET @CodigoEscuela = 5;

SELECT * FROM escuela
WHERE Codigo_escuela = @CodigoEscuela;
```

**Asignar desde una consulta:**
```sql
SET @Total = (SELECT COUNT(*) FROM reserva);
SELECT @Total AS Total_Reservas;
```

**O con SELECT ... INTO @variable:**
```sql
SELECT COUNT(*) INTO @Total FROM reserva;
SELECT @Total;
```

**Múltiples variables:**
```sql
SET @FechaInicio = '2021-01-01';
SET @FechaFin = '2021-12-31';

SELECT COUNT(*) INTO @TotalAnio
FROM reserva
WHERE Fecha_Visita_Reservada BETWEEN @FechaInicio AND @FechaFin;

SELECT @TotalAnio AS Total_Reservas_2021;
```

### 🧮 Operadores Aritméticos

Idénticos a SQL Server.

```sql
SELECT
    Codigo_Tipo_Visita,
    Arancel_por_alumno,
    Arancel_por_alumno * 1.21 AS Arancel_con_IVA,
    Arancel_por_alumno * 0.9 AS Arancel_Descuento_10
FROM tipo_visita;
```

### 🔤 Concatenación de Cadenas

> ⚠️ **Diferencia crítica:** MySQL NO usa el operador `+` para concatenar cadenas. Se usa exclusivamente la función `CONCAT()`.

```sql
-- ✅ CORRECTO en MySQL
SELECT CONCAT(Nombre_Guia, ' ', Apellido_Guia) AS Nombre_Completo
FROM guia;

-- ❌ INCORRECTO en MySQL (esto suma números, no concatena texto)
SELECT Nombre_Guia + ' ' + Apellido_Guia FROM guia;
```

**CONCAT_WS (con separador):**
```sql
-- Más cómodo cuando hay múltiples campos y un separador constante
SELECT CONCAT_WS(' ', Nombre_Guia, Apellido_Guia) AS Nombre_Completo
FROM guia;

-- Con coma y espacio:
SELECT CONCAT_WS(', ', Apellido_Guia, Nombre_Guia) AS Guia
FROM guia;
```

**Manejo de NULL en CONCAT:**
```sql
-- CONCAT trata NULL como cadena vacía en MySQL
SELECT CONCAT('Hola ', NULL, 'Mundo');  -- Resultado: 'Hola Mundo'
```

### 🔀 CASE (Expresión Condicional)

Idéntico a SQL Server.

```sql
SELECT
    Descripcion_Tipo_Visita,
    Arancel_por_alumno,
    CASE
        WHEN Arancel_por_alumno < 10 THEN 'Económico'
        WHEN Arancel_por_alumno BETWEEN 10 AND 20 THEN 'Moderado'
        ELSE 'Premium'
    END AS Categoria
FROM tipo_visita;
```

### 📅 Funciones de Fecha

> ⚠️ **Diferencia importante:** MySQL usa funciones distintas a SQL Server para fechas.

| Operación | SQL Server | MySQL |
|-----------|-----------|-------|
| Fecha y hora actual | `GETDATE()` | `NOW()` |
| Solo fecha actual | `CONVERT(DATE, GETDATE())` | `CURDATE()` |
| Solo hora actual | — | `CURTIME()` |
| Extraer año | `YEAR(fecha)` | `YEAR(fecha)` |
| Extraer mes | `MONTH(fecha)` | `MONTH(fecha)` |
| Extraer día | `DAY(fecha)` | `DAY(fecha)` |
| Sumar días | `DATEADD(DAY, n, fecha)` | `DATE_ADD(fecha, INTERVAL n DAY)` |
| Restar días | `DATEADD(DAY, -n, fecha)` | `DATE_SUB(fecha, INTERVAL n DAY)` |
| Diferencia en días | `DATEDIFF(DAY, f1, f2)` | `DATEDIFF(f1, f2)` |
| Diferencia en meses | `DATEDIFF(MONTH, f1, f2)` | `TIMESTAMPDIFF(MONTH, f1, f2)` |
| Formatear fecha | `CONVERT(VARCHAR, f, 103)` | `DATE_FORMAT(fecha, '%d/%m/%Y')` |

**Ejemplos:**
```sql
-- Fecha actual
SELECT NOW();         -- '2026-06-12 14:30:00'
SELECT CURDATE();     -- '2026-06-12'
SELECT CURTIME();     -- '14:30:00'

-- Extraer partes
SELECT
    Fecha_Visita_Reservada,
    YEAR(Fecha_Visita_Reservada) AS Anio,
    MONTH(Fecha_Visita_Reservada) AS Mes,
    DAY(Fecha_Visita_Reservada) AS Dia,
    DAYOFWEEK(Fecha_Visita_Reservada) AS Dia_Semana
FROM reserva;

-- Sumar/restar tiempo
SELECT DATE_ADD(CURDATE(), INTERVAL 7 DAY) AS En_Una_Semana;
SELECT DATE_SUB(CURDATE(), INTERVAL 3 MONTH) AS Hace_Tres_Meses;
SELECT DATE_ADD('2021-06-12', INTERVAL 1 YEAR) AS Anio_Siguiente;

-- Diferencia entre fechas
SELECT DATEDIFF('2021-12-31', '2021-01-01') AS Dias;  -- Solo días
SELECT TIMESTAMPDIFF(MONTH, '2021-01-01', '2021-12-31') AS Meses;
SELECT TIMESTAMPDIFF(YEAR, '2020-01-01', '2023-01-01') AS Anios;

-- Formatear fecha
SELECT DATE_FORMAT(CURDATE(), '%d/%m/%Y');   -- 12/06/2026
SELECT DATE_FORMAT(CURDATE(), '%Y-%m-%d');   -- 2026-06-12
SELECT DATE_FORMAT(NOW(), '%d/%m/%Y %H:%i'); -- 12/06/2026 14:30
```

### 🔤 Funciones de Cadena

Similares a SQL Server, con algunas diferencias:

```sql
-- Mayúsculas/minúsculas (igual)
SELECT UPPER('hola mundo');  -- HOLA MUNDO
SELECT LOWER('HOLA MUNDO');  -- hola mundo

-- Longitud (diferencia: LENGTH en MySQL, LEN en SQL Server)
SELECT LENGTH('Hola Mundo');   -- 10 (bytes)
SELECT CHAR_LENGTH('Hola');    -- 4 (caracteres, mejor con UTF-8)

-- Subcadena (igual semánticamente, distinto nombre)
SELECT SUBSTRING('Hola Mundo', 1, 4);  -- Hola
SELECT SUBSTR('Hola Mundo', 1, 4);     -- Hola (alias)
SELECT MID('Hola Mundo', 6, 5);        -- Mundo

-- Reemplazar (igual)
SELECT REPLACE('Hola Mundo', 'Mundo', 'SQL');  -- Hola SQL

-- Quitar espacios
SELECT LTRIM('   Hola');   -- 'Hola'
SELECT RTRIM('Hola   ');   -- 'Hola'
SELECT TRIM('   Hola   '); -- 'Hola'

-- Encontrar posición (diferente nombre)
SELECT LOCATE('Mundo', 'Hola Mundo');  -- 6  (SQL Server: CHARINDEX)

-- Repetir una cadena
SELECT REPEAT('ab', 3);  -- 'ababab'

-- Rellenar (LPAD / RPAD)
SELECT LPAD('5', 3, '0');  -- '005'
SELECT RPAD('5', 3, '0');  -- '500'
```

| Función | SQL Server | MySQL |
|---------|-----------|-------|
| Longitud | `LEN()` | `CHAR_LENGTH()` o `LENGTH()` |
| Subcadena | `SUBSTRING()` | `SUBSTRING()` o `SUBSTR()` |
| Posición | `CHARINDEX()` | `LOCATE()` o `POSITION()` |
| Reemplazar | `REPLACE()` | `REPLACE()` |

### 🔢 Funciones Numéricas

Idénticas a SQL Server.

```sql
SELECT ROUND(15.567, 2);   -- 15.57
SELECT CEILING(15.1);      -- 16
SELECT FLOOR(15.9);        -- 15
SELECT ABS(-25);           -- 25
SELECT POWER(2, 3);        -- 8
SELECT SQRT(25);           -- 5
SELECT MOD(10, 3);         -- 1  (módulo/resto)
```

### 🔄 Funciones de Conversión

```sql
-- CAST (igual sintaxis)
SELECT CAST(123 AS CHAR);
SELECT CAST('2021-06-12' AS DATE);
SELECT CAST(15.789 AS UNSIGNED);  -- 15

-- CONVERT (diferente a SQL Server — sin formato de fecha)
SELECT CONVERT(123, CHAR);
SELECT CONVERT('2021-06-12', DATE);
```

> ⚠️ **Diferencia:** En SQL Server `CONVERT(VARCHAR, fecha, 103)` acepta un tercer argumento para el formato. En MySQL **no existe** ese tercer argumento; se usa `DATE_FORMAT()` para formatear fechas.

### 🛡️ Funciones de Nulos

> ⚠️ **Diferencia:** SQL Server usa `ISNULL()`, MySQL usa `IFNULL()`.

```sql
-- IFNULL (equivalente a ISNULL de SQL Server)
SELECT
    Numero_Reserva,
    IFNULL(Cantidad_alumnos_Reales, 0) AS Alumnos_Reales
FROM reserva_tipo_visita;

-- COALESCE (igual, primer valor no NULL)
SELECT
    COALESCE(Cantidad_alumnos_Reales, Cantidad_alumnos_Reservados, 0) AS Total
FROM reserva_tipo_visita;

-- NULLIF (igual, devuelve NULL si ambos son iguales)
SELECT NULLIF(10, 10);  -- NULL
SELECT NULLIF(10, 20);  -- 10
```

| Función | SQL Server | MySQL |
|---------|-----------|-------|
| Reemplazar NULL | `ISNULL(expr, val)` | `IFNULL(expr, val)` |
| Primer no-NULL | `COALESCE(...)` | `COALESCE(...)` |
| NULL si iguales | `NULLIF(a, b)` | `NULLIF(a, b)` |

---

## Operadores de Conjuntos

> ⚠️ **Diferencia:** `EXCEPT` e `INTERSECT` son estándar SQL pero MySQL los incorporó recién en **MySQL 8.0**. En versiones anteriores se simulaban con subconsultas o JOINs.

Requieren **relaciones compatibles**: misma cantidad de columnas y tipos compatibles.

### UNION

Retorna las tuplas que están en R, **o** en S, **o en ambas** (elimina duplicados).

```sql
SELECT Cod_Reserva, Fecha
FROM Reserva
WHERE Fecha = '2009-04-30'

UNION

SELECT Cod_Reserva, Fecha_Hist
FROM Reserva_Historica
WHERE Fecha_Hist = '2005-04-01';
```

**Para incluir duplicados:** `UNION ALL`

```sql
SELECT Codigo_escuela FROM reserva
UNION ALL
SELECT Codigo_escuela FROM reserva_historica;
```

### EXCEPT (MySQL 8.0+)

Retorna las tuplas que están en R **pero no en S**.

```sql
SELECT Cod_Reserva, Fecha
FROM Reserva

EXCEPT

SELECT Cod_Reserva, Fecha_Hist
FROM Reserva_Historica
WHERE cod_escuela = 100;
```

**Alternativa compatible con MySQL < 8.0:**
```sql
-- Simulación de EXCEPT con LEFT JOIN
SELECT r.Cod_Reserva, r.Fecha
FROM Reserva r
LEFT JOIN Reserva_Historica rh
    ON r.Cod_Reserva = rh.Cod_Reserva
    AND rh.cod_escuela = 100
WHERE rh.Cod_Reserva IS NULL;
```

### INTERSECT (MySQL 8.0+)

Retorna las tuplas que están en R **y también en S**.

```sql
SELECT Cod_Reserva, Fecha
FROM Reserva

INTERSECT

SELECT Cod_Reserva, Fecha_Hist
FROM Reserva_Historica;
```

**Alternativa compatible con MySQL < 8.0:**
```sql
-- Simulación de INTERSECT con INNER JOIN
SELECT DISTINCT r.Cod_Reserva, r.Fecha
FROM Reserva r
INNER JOIN Reserva_Historica rh ON r.Cod_Reserva = rh.Cod_Reserva;
```

---

## Transacciones

> ⚠️ **Diferencia:** MySQL usa `START TRANSACTION` en lugar de `BEGIN TRAN`. El `COMMIT` y `ROLLBACK` son iguales.

> ⚠️ **Diferencia importante — AUTOCOMMIT:** MySQL por defecto tiene `autocommit = ON`, lo que significa que cada sentencia SQL se confirma automáticamente. Para usar transacciones explícitas, se debe iniciar con `START TRANSACTION` (que suspende autocommit temporalmente) o ejecutar `SET autocommit = 0`.

```sql
START TRANSACTION         -- o: BEGIN  (MySQL acepta ambas formas)
    operaciones...
COMMIT;                   -- Confirma y finaliza la transacción
ROLLBACK;                 -- Revierte y finaliza la transacción
```

**Verificar y cambiar autocommit:**
```sql
SELECT @@autocommit;      -- Ver estado actual (1 = activo, 0 = inactivo)
SET autocommit = 0;       -- Desactivar para toda la sesión
```

**Ejemplo — UPDATE sin WHERE (error), luego ROLLBACK:**

```sql
START TRANSACTION;

UPDATE tipo_visita
SET Arancel_por_alumno = 2;   -- ¡Afecta toda la tabla!

-- Detectamos el error, revertimos:
ROLLBACK;

SELECT * FROM tipo_visita;  -- Los datos vuelven a su estado original
```

**Ejemplo — UPDATE correcto, luego COMMIT:**

```sql
START TRANSACTION;

UPDATE tipo_visita
SET Arancel_por_alumno = 2
WHERE Codigo_Tipo_Visita IN (4, 5, 7);

-- Verificamos el resultado y confirmamos:
COMMIT;
```

**SAVEPOINT (exclusivo de MySQL/InnoDB):**

```sql
START TRANSACTION;

UPDATE escuela SET Activa = 0 WHERE Codigo_escuela = 1;
SAVEPOINT punto1;

UPDATE escuela SET Activa = 0 WHERE Codigo_escuela = 2;

-- Revertir solo hasta el savepoint (deshacer la segunda operación):
ROLLBACK TO SAVEPOINT punto1;

-- Aún podemos confirmar lo hecho antes del savepoint:
COMMIT;
```

**Diferencias resumidas:**

| Operación | SQL Server | MySQL |
|-----------|-----------|-------|
| Iniciar transacción | `BEGIN TRAN` | `START TRANSACTION` o `BEGIN` |
| Confirmar | `COMMIT` | `COMMIT` |
| Revertir | `ROLLBACK` | `ROLLBACK` |
| Punto de restauración | — | `SAVEPOINT nombre` |
| Comportamiento por defecto | Sin autocommit | Con autocommit (debe desactivarse) |

---

## Procedimientos Almacenados

> ⚠️ **Diferencia crítica:** En MySQL se debe cambiar el delimitador antes de crear un SP, porque el cuerpo del procedimiento contiene `;` que el cliente `mysql` interpretaría como fin de sentencia.

### Cambio de Delimitador

```sql
DELIMITER //
-- Aquí va el CREATE PROCEDURE
DELIMITER ;
```

### Sintaxis

```sql
DELIMITER //
CREATE PROCEDURE nombre_procedimiento(
    IN  parametro1 tipo_de_dato,
    OUT parametro2 tipo_de_dato,
    INOUT parametro3 tipo_de_dato
)
BEGIN
    -- código SQL
END //
DELIMITER ;
```

> ⚠️ **Diferencias con SQL Server:**
> - `IN`, `OUT`, `INOUT` en lugar de solo `@param tipo OUTPUT`
> - El cuerpo va entre `BEGIN ... END`
> - Se llama con `CALL` en lugar de `EXEC`
> - No hay valores predeterminados directos en la firma (se manejan con IF dentro del cuerpo)

### Ejemplo sin parámetros

```sql
DELIMITER //
CREATE PROCEDURE ListarEscuelas()
BEGIN
    SELECT Nombre_escuela, Domicilio_escuela
    FROM escuela
    ORDER BY Nombre_escuela;
END //
DELIMITER ;

-- Ejecución:
CALL ListarEscuelas();
```

### Ejemplo con parámetro de entrada (IN)

```sql
DELIMITER //
CREATE PROCEDURE ListaEscuelas(
    IN p_Nombre VARCHAR(20)
)
BEGIN
    SELECT Nombre_escuela
    FROM escuela
    WHERE Nombre_escuela LIKE p_Nombre;
END //
DELIMITER ;

-- Ejecución:
CALL ListaEscuelas('Esc%');
```

**Con valor predeterminado simulado (IF dentro del cuerpo):**

```sql
DELIMITER //
CREATE PROCEDURE ListaEscuelasOpcional(
    IN p_Nombre VARCHAR(20)
)
BEGIN
    IF p_Nombre IS NULL THEN
        SELECT Nombre_escuela FROM escuela;
    ELSE
        SELECT Nombre_escuela FROM escuela
        WHERE Nombre_escuela LIKE p_Nombre;
    END IF;
END //
DELIMITER ;

-- Con parámetro:
CALL ListaEscuelasOpcional('Esc%');

-- "Sin parámetro" (pasando NULL):
CALL ListaEscuelasOpcional(NULL);
```

### Ejemplo con parámetro de salida (OUT)

```sql
DELIMITER //
CREATE PROCEDURE ContarReservas(
    IN  p_CodigoEscuela SMALLINT,
    OUT p_Total INT
)
BEGIN
    SELECT COUNT(*) INTO p_Total
    FROM reserva
    WHERE Codigo_escuela = p_CodigoEscuela;
END //
DELIMITER ;

-- Ejecución:
CALL ContarReservas(5, @Resultado);
SELECT @Resultado AS Total_Reservas;
```

### Ejemplo con lógica condicional e IF/ELSEIF

```sql
DELIMITER //
CREATE PROCEDURE ObtenerReservasPorAnio(
    IN p_Anio INT
)
BEGIN
    IF p_Anio IS NULL THEN
        SELECT * FROM reserva;
    ELSEIF p_Anio < 2000 THEN
        SELECT 'Año fuera de rango' AS Mensaje;
    ELSE
        SELECT * FROM reserva
        WHERE YEAR(Fecha_Visita_Reservada) = p_Anio;
    END IF;
END //
DELIMITER ;

CALL ObtenerReservasPorAnio(2021);
```

### Modificar y eliminar

```sql
-- Modificar (SQL Server usa ALTER PROCEDURE, MySQL también):
DROP PROCEDURE IF EXISTS ListaEscuelas;

DELIMITER //
CREATE PROCEDURE ListaEscuelas(
    IN p_Nombre VARCHAR(20)
)
BEGIN
    SELECT Nombre_escuela, Domicilio_escuela
    FROM escuela
    WHERE Nombre_escuela LIKE p_Nombre;
END //
DELIMITER ;

-- Eliminar:
DROP PROCEDURE IF EXISTS ListaEscuelas;
```

> ⚠️ **Diferencia:** MySQL no tiene `ALTER PROCEDURE` para cambiar el cuerpo. Se debe hacer `DROP` + `CREATE`.

**Listar procedimientos almacenados:**
```sql
SHOW PROCEDURE STATUS WHERE Db = 'jurasik_park';
```

---

## Triggers (Disparadores)

> ⚠️ **Diferencias importantes con SQL Server:**
> - En lugar de las tablas `inserted` y `deleted`, MySQL usa `NEW` y `OLD`
> - MySQL tiene `BEFORE` y `AFTER`, pero **NO tiene `INSTEAD OF`**
> - En MySQL, los triggers también requieren `DELIMITER`
> - Solo un trigger por combinación evento+timing por tabla en MySQL 5.7 (MySQL 8.0+ admite múltiples)

### Tablas especiales en MySQL

| Tabla virtual | Disponible en | Contiene |
|--------------|--------------|---------|
| `NEW` | INSERT y UPDATE | Los valores nuevos que se insertan/actualizan |
| `OLD` | DELETE y UPDATE | Los valores anteriores que se eliminan/modifican |

**Comparación directa con SQL Server:**

| SQL Server | MySQL | Cuándo está disponible |
|-----------|-------|----------------------|
| `inserted` | `NEW` | INSERT, UPDATE |
| `deleted` | `OLD` | DELETE, UPDATE |

### Sintaxis

```sql
DELIMITER //
CREATE TRIGGER nombre_trigger
BEFORE | AFTER
INSERT | UPDATE | DELETE
ON nombre_tabla
FOR EACH ROW
BEGIN
    -- código SQL usando NEW y/o OLD
END //
DELIMITER ;
```

> ⚠️ `FOR EACH ROW` es **obligatorio** en MySQL (el trigger se ejecuta por cada fila afectada).

### Ejemplo AFTER DELETE

```sql
DELIMITER //
CREATE TRIGGER trig_delete
AFTER DELETE
ON reserva_tipo_visita
FOR EACH ROW
BEGIN
    DELETE FROM guia
    WHERE codigo_guia = OLD.codigo_guia;
END //
DELIMITER ;
```

> ⚠️ En SQL Server se usaba la tabla `deleted`; en MySQL se usa `OLD` para acceder a los valores de la fila eliminada.

### Ejemplo AFTER INSERT (auditoría)

```sql
DELIMITER //
CREATE TRIGGER trig_audit_reserva
AFTER INSERT
ON reserva
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_reservas (Numero_Reserva, Fecha_Operacion)
    VALUES (NEW.Numero_Reserva, NOW());
END //
DELIMITER ;
```

### Ejemplo BEFORE UPDATE (validación)

```sql
-- Impide que el arancel baje a menos de 1
-- Nota: MySQL usa BEFORE para validaciones (no puede hacer ROLLBACK en AFTER como en SQL Server)
DELIMITER //
CREATE TRIGGER trig_check_arancel
BEFORE UPDATE
ON tipo_visita
FOR EACH ROW
BEGIN
    IF NEW.Arancel_por_alumno < 1 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: el arancel no puede ser menor a 1.';
    END IF;
END //
DELIMITER ;
```

> ⚠️ **Diferencia crítica:** SQL Server puede hacer `ROLLBACK` dentro de un trigger `AFTER UPDATE`. MySQL no puede hacer `ROLLBACK` dentro de un trigger; en su lugar, se usa `SIGNAL SQLSTATE '45000'` en un trigger `BEFORE` para lanzar un error que cancela la operación.

### Ejemplo BEFORE DELETE (equivalente a soft delete)

```sql
-- En lugar de eliminar, marca la escuela como inactiva
-- MySQL no tiene INSTEAD OF, se usa BEFORE DELETE + SIGNAL para cancelar el DELETE
DELIMITER //
CREATE TRIGGER trig_soft_delete_escuela
BEFORE DELETE
ON escuela
FOR EACH ROW
BEGIN
    UPDATE escuela SET Activa = 0 WHERE Codigo_escuela = OLD.Codigo_escuela;
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Operación cancelada: la escuela fue desactivada en su lugar.';
END //
DELIMITER ;
```

> ⚠️ **Alternativa más limpia para soft delete en MySQL:** Usar la aplicación para ejecutar `UPDATE` en lugar de `DELETE`, dado que no existe `INSTEAD OF`.

### Modificar y eliminar triggers

```sql
-- Eliminar:
DROP TRIGGER IF EXISTS trig_delete;

-- "Modificar" (igual que SP: DROP + CREATE):
DROP TRIGGER IF EXISTS trig_audit_reserva;

DELIMITER //
CREATE TRIGGER trig_audit_reserva
AFTER INSERT
ON reserva
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_reservas (Numero_Reserva, Fecha_Operacion, Usuario)
    VALUES (NEW.Numero_Reserva, NOW(), USER());
END //
DELIMITER ;
```

**Listar triggers:**
```sql
SHOW TRIGGERS FROM jurasik_park;
-- O para una tabla específica:
SHOW TRIGGERS FROM jurasik_park LIKE 'reserva';
```

> ⚠️ **Diferencia:** SQL Server tiene `DISABLE TRIGGER` y `ENABLE TRIGGER`. MySQL **no tiene esa funcionalidad**: la alternativa es eliminar y recrear el trigger.

### Diferencia clave: Stored Procedure vs Trigger en MySQL

| Característica | Stored Procedure | Trigger |
|---------------|-----------------|---------|
| **Se llama** | Directamente con `CALL` | Automáticamente ante un evento |
| **Parámetros** | `IN`, `OUT`, `INOUT` | No acepta parámetros; usa `NEW`/`OLD` |
| **Evento** | Cuando el usuario lo invoca | `INSERT`, `UPDATE`, `DELETE` |
| **Timing** | — | `BEFORE` o `AFTER` |
| **No existe** | — | `INSTEAD OF` (usar `BEFORE` + `SIGNAL`) |
| **Cancelar operación** | No aplica | `BEFORE` + `SIGNAL SQLSTATE '45000'` |
| **Uso típico** | Lógica reutilizable, consultas complejas | Validaciones, auditoría, integridad |

---

## Conceptos Clave

### 🎯 Orden de Ejecución de SQL

Igual que SQL Server:
```
1. FROM
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. ORDER BY
7. LIMIT
```

### 📊 NULL en MySQL

Igual que SQL Server: `NULL` es ausencia de valor, no `0` ni cadena vacía.

```sql
-- ✅ CORRECTO
SELECT * FROM reserva_tipo_visita
WHERE Cantidad_alumnos_Reales IS NULL;

-- ❌ INCORRECTO
SELECT * FROM reserva_tipo_visita
WHERE Cantidad_alumnos_Reales = NULL;
```

### 🔄 Producto Cartesiano vs Reunión

Igual que SQL Server.

```sql
-- Producto Cartesiano (sintaxis antigua, generalmente no deseado)
SELECT * FROM escuela, tipo_visita;

-- Reunión Natural (con JOIN, recomendado)
SELECT * FROM reserva r
INNER JOIN escuela e ON r.Codigo_escuela = e.Codigo_escuela;
```

### ⚡ Tabla comparativa: SQL Server vs MySQL

| Característica | SQL Server (T-SQL) | MySQL |
|---------------|-------------------|-------|
| Separador de batch | `GO` | No existe (se usa `;`) |
| Primeros N registros | `TOP n` (al inicio del SELECT) | `LIMIT n` (al final de la consulta) |
| Fecha actual | `GETDATE()` | `NOW()` / `CURDATE()` |
| Booleano | `BIT` | `TINYINT(1)` |
| Autoincremento | `IDENTITY(1,1)` | `AUTO_INCREMENT` |
| Reemplazar NULL | `ISNULL(expr, val)` | `IFNULL(expr, val)` |
| Concatenar | `'a' + 'b'` o `CONCAT()` | Solo `CONCAT()` |
| Longitud de cadena | `LEN()` | `CHAR_LENGTH()` |
| Posición en cadena | `CHARINDEX()` | `LOCATE()` |
| Modificar columna | `ALTER COLUMN` | `MODIFY COLUMN` |
| Diferencia de fechas | `DATEDIFF(tipo, f1, f2)` | `DATEDIFF(f1, f2)` (solo días) |
| Diferencia por unidad | `DATEDIFF(MONTH, f1, f2)` | `TIMESTAMPDIFF(MONTH, f1, f2)` |
| Sumar a fecha | `DATEADD(DAY, n, f)` | `DATE_ADD(f, INTERVAL n DAY)` |
| Formatear fecha | `CONVERT(VARCHAR, f, 103)` | `DATE_FORMAT(f, '%d/%m/%Y')` |
| Iniciar transacción | `BEGIN TRAN` | `START TRANSACTION` |
| Ejecutar SP | `EXEC nombre` | `CALL nombre()` |
| Parámetros de SP | `@param tipo OUTPUT` | `OUT param tipo` |
| Cuerpo de SP/Trigger | Sin bloque especial | `BEGIN ... END` |
| Delimitador en SP | No necesario | `DELIMITER //` obligatorio |
| Tablas en triggers | `inserted` / `deleted` | `NEW` / `OLD` |
| Timing de triggers | `AFTER`, `INSTEAD OF` | `BEFORE`, `AFTER` |
| Cancelar en trigger | `ROLLBACK` en AFTER | `SIGNAL` en BEFORE |
| FULL OUTER JOIN | Nativo | Simular con `UNION` |
| EXCEPT | Nativo | MySQL 8.0+ (simular con LEFT JOIN) |
| INTERSECT | Nativo | MySQL 8.0+ (simular con INNER JOIN) |
| Ver bases de datos | `SELECT name FROM sys.databases` | `SHOW DATABASES` |
| Ver tablas | `SELECT name FROM sys.tables` | `SHOW TABLES` |
| Ver estructura | — | `DESCRIBE tabla` |

---

## 📚 Recursos Adicionales

**Archivos del proyecto:**
- `REFERENCIA-SQL-SERVER.md` — Versión equivalente para SQL Server
- `UT_3_Script Jurasik Park_SQL_Server_V2.sql` — Script base (adaptar para MySQL)

**Documentación oficial:**
- [MySQL 8.0 Reference Manual](https://dev.mysql.com/doc/refman/8.0/en/)
- [MySQL Language Reference — Transact-SQL Equivalents](https://dev.mysql.com/doc/refman/8.0/en/migrating-from-sql-server.html)

---

## ✅ Checklist Pre-Parcial (MySQL)

- [ ] Puedo conectarme a MySQL desde la CLI con `mysql -u root -p`
- [ ] Conozco los comandos `SHOW DATABASES`, `SHOW TABLES`, `DESCRIBE`
- [ ] Sé crear tablas con `AUTO_INCREMENT`, `ENGINE=InnoDB`
- [ ] Domino INSERT, UPDATE con JOIN, DELETE
- [ ] Entiendo `LIMIT` en lugar de `TOP`
- [ ] Puedo usar funciones de agregación (COUNT, SUM, AVG, MAX, MIN)
- [ ] Comprendo GROUP BY y HAVING
- [ ] Domino todos los tipos de JOIN (y sé simular FULL OUTER con UNION)
- [ ] Puedo escribir subconsultas en WHERE, FROM y SELECT (con alias obligatorio en FROM)
- [ ] Entiendo `IFNULL()` y `COALESCE()` para nulos
- [ ] Conozco las funciones de fecha: `NOW()`, `CURDATE()`, `DATE_ADD()`, `DATE_FORMAT()`, `DATEDIFF()`, `TIMESTAMPDIFF()`
- [ ] Uso `CONCAT()` para concatenar (no el operador `+`)
- [ ] Sé usar CASE para expresiones condicionales
- [ ] Conozco UNION, y sé simular EXCEPT e INTERSECT si es MySQL < 8.0
- [ ] Sé usar `START TRANSACTION` / `COMMIT` / `ROLLBACK`
- [ ] Puedo crear un SP con `DELIMITER //`, parámetros `IN`/`OUT` y ejecutarlo con `CALL`
- [ ] Conozco las diferencias entre `NEW`/`OLD` vs `inserted`/`deleted`
- [ ] Sé crear triggers `BEFORE` y `AFTER` con `FOR EACH ROW`
- [ ] Entiendo que MySQL no tiene `INSTEAD OF`: usar `BEFORE` + `SIGNAL`
- [ ] Distingo los comandos T-SQL equivalentes en MySQL (tabla comparativa)

---

**¡Éxitos en el parcial! 🚀**

*Documento creado: Junio 2026*  
*Materia: Bases de Datos — TGAD, FCE-UBA*
