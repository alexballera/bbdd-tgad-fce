# Guía de Referencia SQL Server — Segundo Parcial BBDD

**Materia:** Bases de Datos — TGAD, FCE-UBA  
**Fecha:** Junio 2026  
**Motor:** Microsoft SQL Server

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
9. [Conceptos Clave](#conceptos-clave)

---

## Conexión y Configuración

### 🔷 Desde la Línea de Comandos (CLI) con `sqlcmd`

#### Instalación y Configuración

`sqlcmd` viene incluido con SQL Server Express, ubicado en:
```
C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\180\Tools\Binn\sqlcmd.exe
```

**Crear alias en PowerShell (opcional):**

```powershell
notepad $PROFILE
```

Agregar al archivo:
```powershell
Set-Alias -Name sqlcmd -Value 'C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\180\Tools\Binn\sqlcmd.exe'
```

#### Comandos de Conexión

**Conectar a la instancia local:**
```bash
sqlcmd -S ".\SQLEXPRESS" -E -C
```

> ⚠️ **Importante:** en Git Bash y PowerShell es necesario poner el servidor entre comillas (`".\ SQLEXPRESS"`) para que la barra invertida no se malinterprete.

**Parámetros:**
- `-S ".\SQLEXPRESS"` → Servidor local con instancia SQLEXPRESS
- `-E` → Autenticación de Windows
- `-C` → Confiar en el certificado del servidor

**Conectar directamente a una base de datos:**
```bash
sqlcmd -S ".\SQLEXPRESS" -E -C -d Jurasik_Park
```

**Ejecutar un script SQL:**
```bash
sqlcmd -S ".\SQLEXPRESS" -E -C -d Jurasik_Park -i "ruta\al\script.sql"
```

**Ejecutar un script y guardar resultados:**
```bash
sqlcmd -S ".\SQLEXPRESS" -E -C -d Jurasik_Park -i "script.sql" -o "resultados.txt"
```

#### Comandos Interactivos de `sqlcmd`

| Comando | Descripción |
|---------|------------|
| `GO` | Ejecuta el batch actual |
| `EXIT` o `QUIT` | Sale de sqlcmd |
| `RESET` | Limpia el buffer de comandos |
| `:r archivo.sql` | Ejecuta un archivo SQL |
| `:!! comando` | Ejecuta un comando del sistema |

#### Navegación básica dentro de `sqlcmd`

> Son los comandos equivalentes a `SHOW DATABASES`, `USE`, `SHOW TABLES` de MySQL.

**Listar todas las bases de datos:**
```sql
SELECT name FROM sys.databases ORDER BY name;
GO
```

**Seleccionar (entrar a) una base de datos:**
```sql
USE Jurasik_Park;
GO
```

**Listar todas las tablas de la base de datos actual:**
```sql
SELECT name FROM sys.tables ORDER BY name;
GO
```

**Ver columnas de una tabla (equivalente a `DESCRIBE` en MySQL):**
```sql
SELECT
    COLUMN_NAME AS Columna,
    DATA_TYPE   AS Tipo,
    IS_NULLABLE AS Nulable
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'escuela';
GO
```

**Ver la definición completa de una tabla (columnas, tipos y restricciones):**
```sql
EXEC sp_help 'escuela';
GO
```

**Hacer una consulta rápida:**
```sql
SELECT TOP 5 * FROM escuela;
GO
```

**Secuencia típica al conectarse:**
```sql
-- 1. Listar las bases de datos disponibles
SELECT name FROM sys.databases;
GO

-- 2. Entrar a la base de datos que nos interesa
USE Jurasik_Park;
GO

-- 3. Ver qué tablas hay
SELECT name FROM sys.tables ORDER BY name;
GO

-- 4. Explorar una tabla
EXEC sp_help 'escuela';
GO

-- 5. Consultar datos
SELECT TOP 5 * FROM escuela;
GO
```

### 🔷 Desde VS Code (Extensión MSSQL)

1. Instalar extensión **SQL Server (mssql)** de Microsoft
2. `Ctrl+Shift+P` → **MSSQL: Connect**
3. Configuración:
   - Server: `.\SQLEXPRESS` o `localhost\SQLEXPRESS`
   - Authentication: `Windows Authentication`
   - ☑ Trust server certificate
   - Database: `(opcional)`
4. Ejecutar consultas: `Ctrl+Shift+E`

### 🔷 Gestión de Bases de Datos

**Crear base de datos:**
```sql
CREATE DATABASE NombreDB;
GO
```

**Seleccionar base de datos:**
```sql
USE NombreDB;
GO
```

**Eliminar base de datos:**
```sql
DROP DATABASE NombreDB;
GO
```

**Listar bases de datos:**
```sql
SELECT name FROM sys.databases;
GO
```

**Listar tablas de la BD actual:**
```sql
SELECT name FROM sys.tables ORDER BY name;
GO
```

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
);
```

**Ejemplo completo:**
```sql
CREATE TABLE escuela (
    Codigo_escuela SMALLINT NOT NULL,
    Nombre_escuela VARCHAR(100) NOT NULL,
    Domicilio_escuela VARCHAR(200) NOT NULL,
    Fecha_fundacion DATE,
    Activa BIT DEFAULT 1,
    PRIMARY KEY NONCLUSTERED (Codigo_escuela)
);
```

### 📐 Tipos de Datos Comunes

| Tipo | Descripción | Ejemplo |
|------|-------------|---------|
| `INT` | Entero (-2,147,483,648 a 2,147,483,647) | `42` |
| `SMALLINT` | Entero pequeño (-32,768 a 32,767) | `100` |
| `TINYINT` | Entero muy pequeño (0 a 255) | `5` |
| `BIGINT` | Entero grande | `9223372036854775807` |
| `DECIMAL(p,s)` | Número decimal de precisión fija | `DECIMAL(8,2)` → 999999.99 |
| `NUMERIC(p,s)` | Equivalente a DECIMAL | `NUMERIC(10,2)` |
| `VARCHAR(n)` | Cadena variable hasta n caracteres | `VARCHAR(100)` |
| `CHAR(n)` | Cadena fija de n caracteres | `CHAR(10)` |
| `TEXT` | Texto largo (deprecado, usar VARCHAR(MAX)) | - |
| `DATE` | Fecha (YYYY-MM-DD) | `'2026-06-12'` |
| `SMALLDATETIME` | Fecha y hora (minutos) | `'2026-06-12 14:30:00'` |
| `DATETIME` | Fecha y hora completa | `'2026-06-12 14:30:15.123'` |
| `BIT` | Booleano (0 o 1) | `1` |

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

**FOREIGN KEY:**
```sql
CREATE TABLE reserva (
    Numero_Reserva INT NOT NULL,
    Fecha_Visita_Reservada SMALLDATETIME NOT NULL,
    Codigo_escuela SMALLINT NOT NULL,
    PRIMARY KEY (Numero_Reserva),
    CONSTRAINT FK_codigo_escuela 
        FOREIGN KEY (Codigo_escuela) 
        REFERENCES escuela(Codigo_escuela)
);
```

**FOREIGN KEY en línea:**
```sql
CREATE TABLE reserva (
    Numero_Reserva INT NOT NULL,
    Codigo_escuela SMALLINT NOT NULL 
        CONSTRAINT FK_codigo_escuela1 REFERENCES escuela(Codigo_escuela),
    PRIMARY KEY (Numero_Reserva)
);
```

**Clave primaria compuesta:**
```sql
CREATE TABLE telefono_escuela (
    Codigo_escuela SMALLINT NOT NULL 
        CONSTRAINT FK_codigo_escuela2 REFERENCES escuela(Codigo_escuela),
    Telefono_escuela VARCHAR(16) NOT NULL,
    PRIMARY KEY (Codigo_escuela, Telefono_escuela)
);
```

**Otras restricciones:**
```sql
CREATE TABLE tipo_visita (
    Codigo_Tipo_Visita TINYINT NOT NULL,
    Descripcion_Tipo_Visita VARCHAR(200) NOT NULL,
    Arancel_por_alumno DECIMAL(8,2) NOT NULL,
    Activo BIT DEFAULT 1,
    Fecha_alta DATE DEFAULT GETDATE(),
    CHECK (Arancel_por_alumno >= 0),
    UNIQUE (Descripcion_Tipo_Visita),
    PRIMARY KEY (Codigo_Tipo_Visita)
);
```

### ✏️ ALTER TABLE

**Agregar columna:**
```sql
ALTER TABLE escuela
ADD Email VARCHAR(100);
```

**Modificar columna:**
```sql
ALTER TABLE escuela
ALTER COLUMN Email VARCHAR(150);
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
    REFERENCES Reserva(Numero_Reserva);
```

### 🗑️ DROP TABLE

```sql
DROP TABLE nombre_tabla;
```

**Eliminar con IF EXISTS (SQL Server 2016+):**
```sql
DROP TABLE IF EXISTS nombre_tabla;
```

### 🔄 TRUNCATE TABLE

Elimina todos los registros pero mantiene la estructura:
```sql
TRUNCATE TABLE nombre_tabla;
```

**Diferencia con DELETE:**
- `TRUNCATE` es más rápido, no registra cada fila eliminada
- `TRUNCATE` reinicia contadores de identidad
- `TRUNCATE` no puede usarse con claves foráneas activas

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
    (1, 'Escuela Domingo Faustino Sarmiento', 'Soler 219, Capital Federal'),
    (2, 'Instituto Santa Elena', 'Las Acacias 23 Pinamar'),
    (3, 'Escuela Nacional Nro 4 Nicolas Avellaneda', 'Salvador y Nicaragua s/n Cordoba');
```

**Insertar desde otra tabla:**
```sql
INSERT INTO escuela_backup (Codigo_escuela, Nombre_escuela, Domicilio_escuela)
SELECT Codigo_escuela, Nombre_escuela, Domicilio_escuela
FROM escuela
WHERE Codigo_escuela < 10;
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
UPDATE reserva_tipo_visita
SET Cantidad_alumnos_Reales = Cantidad_alumnos_Reservados
FROM reserva_tipo_visita rtv
INNER JOIN reserva r ON rtv.Numero_Reserva = r.Numero_Reserva
WHERE r.FeCHa_VISITa_ReSeRVaDa < '2010-01-01';
```

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

**Eliminar todos los registros:**
```sql
DELETE FROM nombre_tabla;
-- Mejor usar TRUNCATE si no hay FKs:
TRUNCATE TABLE nombre_tabla;
```

---

## Consultas SELECT

### 🔍 Sintaxis General

```sql
SELECT [DISTINCT | ALL] [TOP n] columnas
FROM tabla(s)
[WHERE condiciones]
[GROUP BY columnas]
[HAVING condiciones_agregadas]
[ORDER BY columnas [ASC | DESC]]
```

### 📊 SELECT Básico

**Seleccionar todas las columnas:**
```sql
SELECT * FROM escuela;
```

**Seleccionar columnas específicas:**
```sql
SELECT Nombre_escuela, Domicilio_escuela
FROM escuela;
```

**Con alias de columna:**
```sql
SELECT 
    Nombre_escuela AS Escuela,
    Domicilio_escuela AS Direccion
FROM escuela;
```

**Con alias de tabla:**
```sql
SELECT e.Nombre_escuela, e.Domicilio_escuela
FROM escuela AS e;
```

### 🎯 TOP

**Primeros n registros:**
```sql
SELECT TOP 5 * FROM escuela;
```

**Con ORDER BY:**
```sql
SELECT TOP 10 Nombre_escuela, Arancel_por_alumno
FROM tipo_visita
ORDER BY Arancel_por_alumno DESC;
```

**TOP con porcentaje:**
```sql
SELECT TOP 10 PERCENT *
FROM reserva
ORDER BY Numero_Reserva;
```

### 🔎 WHERE — Condiciones

**Operadores de comparación:**
```sql
-- Igual
SELECT * FROM escuela WHERE Codigo_escuela = 5;

-- Distinto
SELECT * FROM tipo_visita WHERE Arancel_por_alumno <> 10;
SELECT * FROM tipo_visita WHERE Arancel_por_alumno != 10;

-- Mayor/Menor
SELECT * FROM tipo_visita WHERE Arancel_por_alumno > 10;
SELECT * FROM tipo_visita WHERE Arancel_por_alumno >= 10;
SELECT * FROM tipo_visita WHERE Arancel_por_alumno < 10;
SELECT * FROM tipo_visita WHERE Arancel_por_alumno <= 10;
```

**Operadores lógicos:**
```sql
-- AND
SELECT * FROM tipo_visita
WHERE Arancel_por_alumno >= 10 AND Arancel_por_alumno <= 20;

-- OR
SELECT * FROM escuela
WHERE Codigo_escuela = 1 OR Codigo_escuela = 5;

-- NOT
SELECT * FROM escuela
WHERE NOT Codigo_escuela = 5;
```

**BETWEEN:**
```sql
SELECT * FROM tipo_visita
WHERE Arancel_por_alumno BETWEEN 10 AND 20;
```

**IN:**
```sql
SELECT * FROM escuela
WHERE Codigo_escuela IN (1, 5, 10, 15);
```

**LIKE — Búsqueda de patrones:**
```sql
-- Empieza con 'Escuela'
SELECT * FROM escuela
WHERE Nombre_escuela LIKE 'Escuela%';

-- Termina con 'Sarmiento'
SELECT * FROM escuela
WHERE Nombre_escuela LIKE '%Sarmiento';

-- Contiene 'Nacional'
SELECT * FROM escuela
WHERE Nombre_escuela LIKE '%Nacional%';

-- Segundo carácter es 'a'
SELECT * FROM escuela
WHERE Nombre_escuela LIKE '_a%';
```

**IS NULL / IS NOT NULL:**
```sql
SELECT * FROM reserva_tipo_visita
WHERE Cantidad_alumnos_Reales IS NULL;

SELECT * FROM reserva_tipo_visita
WHERE Cantidad_alumnos_Reales IS NOT NULL;
```

### 📈 ORDER BY

**Orden ascendente (por defecto):**
```sql
SELECT * FROM tipo_visita
ORDER BY Arancel_por_alumno;
```

**Orden descendente:**
```sql
SELECT * FROM tipo_visita
ORDER BY Arancel_por_alumno DESC;
```

**Múltiples columnas:**
```sql
SELECT * FROM reserva
ORDER BY Codigo_escuela ASC, FeCHa_VISITa_ReSeRVaDa DESC;
```

**Por número de columna:**
```sql
SELECT Nombre_escuela, Domicilio_escuela
FROM escuela
ORDER BY 1;  -- Ordena por la primera columna del SELECT
```

### 🔢 DISTINCT

**Valores únicos:**
```sql
SELECT DISTINCT Codigo_escuela
FROM reserva;
```

**Combinaciones únicas:**
```sql
SELECT DISTINCT Codigo_escuela, Codigo_Tipo_Visita
FROM reserva_tipo_visita;
```

---

## Funciones de Agregación

### 📊 Funciones Principales

**COUNT — Contar registros:**
```sql
-- Contar todos los registros
SELECT COUNT(*) AS Total_Reservas
FROM reserva;

-- Contar valores no nulos
SELECT COUNT(Cantidad_alumnos_Reales) AS Total_Con_Datos_Reales
FROM reserva_tipo_visita;

-- Contar valores únicos
SELECT COUNT(DISTINCT Codigo_escuela) AS Total_Escuelas_Con_Reserva
FROM reserva;
```

**SUM — Sumar valores:**
```sql
SELECT SUM(Cantidad_alumnos_Reservados) AS Total_Alumnos_Reservados
FROM reserva_tipo_visita;
```

**AVG — Promedio:**
```sql
SELECT AVG(Arancel_por_alumno) AS Arancel_Promedio
FROM tipo_visita;

SELECT AVG(Cantidad_alumnos_Reales) AS Promedio_Alumnos_Reales
FROM reserva_tipo_visita
WHERE Cantidad_alumnos_Reales IS NOT NULL;
```

**MAX — Valor máximo:**
```sql
SELECT MAX(Arancel_por_alumno) AS Arancel_Maximo
FROM tipo_visita;

SELECT MAX(FeCHa_VISITa_ReSeRVaDa) AS Ultima_Fecha_Reservada
FROM reserva;
```

**MIN — Valor mínimo:**
```sql
SELECT MIN(Arancel_por_alumno) AS Arancel_Minimo
FROM tipo_visita;
```

### 📊 GROUP BY

**Agrupación básica:**
```sql
SELECT Codigo_escuela, COUNT(*) AS Total_Reservas
FROM reserva
GROUP BY Codigo_escuela;
```

**⚠️ REGLA FUNDAMENTAL:**
> **Toda columna en SELECT que NO sea una función de agregación DEBE estar en GROUP BY**

```sql
-- ✅ CORRECTO
SELECT Codigo_escuela, Codigo_Tipo_Visita, SUM(Cantidad_alumnos_Reservados) AS Total
FROM reserva_tipo_visita
GROUP BY Codigo_escuela, Codigo_Tipo_Visita;

-- ❌ INCORRECTO (Codigo_Tipo_Visita falta en GROUP BY)
SELECT Codigo_escuela, Codigo_Tipo_Visita, SUM(Cantidad_alumnos_Reservados) AS Total
FROM reserva_tipo_visita
GROUP BY Codigo_escuela;
```

**Múltiples agregaciones:**
```sql
SELECT 
    Codigo_Tipo_Visita,
    COUNT(*) AS Total_Reservas,
    SUM(Cantidad_alumnos_Reservados) AS Total_Reservados,
    SUM(Cantidad_alumnos_Reales) AS Total_Reales,
    AVG(Cantidad_alumnos_Reservados) AS Promedio_Reservados
FROM reserva_tipo_visita
GROUP BY Codigo_Tipo_Visita;
```

### 🔍 HAVING

**Filtrar después de agrupar:**

```sql
-- Escuelas con más de 5 reservas
SELECT Codigo_escuela, COUNT(*) AS Total_Reservas
FROM reserva
GROUP BY Codigo_escuela
HAVING COUNT(*) > 5;
```

**HAVING vs WHERE:**
- `WHERE` filtra **antes** de agrupar (sobre filas individuales)
- `HAVING` filtra **después** de agrupar (sobre grupos)

```sql
-- Tipo de visita con arancel > 5 y promedio de alumnos > 50
SELECT 
    rtv.Codigo_Tipo_Visita,
    AVG(rtv.Cantidad_alumnos_Reservados) AS Promedio
FROM reserva_tipo_visita rtv
INNER JOIN tipo_visita tv ON rtv.Codigo_Tipo_Visita = tv.Codigo_Tipo_Visita
WHERE tv.Arancel_por_alumno > 5  -- Filtro ANTES de agrupar
GROUP BY rtv.Codigo_Tipo_Visita
HAVING AVG(rtv.Cantidad_alumnos_Reservados) > 50;  -- Filtro DESPUÉS de agrupar
```

---

## JOINs

### 🔗 Conceptos Clave

**JOIN = Reunión**: Combina filas de dos o más tablas basándose en una condición relacionada.

### 🔵 INNER JOIN

**Definición:** Devuelve solo las filas que tienen coincidencia en **ambas** tablas.

**Sintaxis:**
```sql
SELECT columnas
FROM tabla1
INNER JOIN tabla2 ON tabla1.columna = tabla2.columna;
```

**Ejemplo:**
```sql
-- Reservas con información de la escuela
SELECT 
    r.Numero_Reserva,
    r.FeCHa_VISITa_ReSeRVaDa,
    e.Nombre_escuela,
    e.Domicilio_escuela
FROM reserva r
INNER JOIN escuela e ON r.Codigo_escuela = e.Codigo_escuela;
```

**JOIN múltiple:**
```sql
-- Reservas con escuela, tipo de visita y guía
SELECT 
    r.Numero_Reserva,
    e.Nombre_escuela,
    tv.Descripcion_Tipo_Visita,
    g.Apellido_Guia,
    rtv.Cantidad_alumnos_Reservados
FROM reserva r
INNER JOIN escuela e ON r.Codigo_escuela = e.Codigo_escuela
INNER JOIN reserva_tipo_visita rtv ON r.Numero_Reserva = rtv.Numero_Reserva
INNER JOIN tipo_visita tv ON rtv.Codigo_Tipo_Visita = tv.Codigo_Tipo_Visita
INNER JOIN guia g ON rtv.Codigo_Guia = g.Codigo_Guia;
```

### 🔵 LEFT JOIN (LEFT OUTER JOIN)

**Definición:** Devuelve **todas las filas de la tabla izquierda** y las coincidencias de la derecha. Si no hay coincidencia, devuelve `NULL`.

```sql
-- Todas las escuelas, tengan o no reservas
SELECT 
    e.Codigo_escuela,
    e.Nombre_escuela,
    COUNT(r.Numero_Reserva) AS Total_Reservas
FROM escuela e
LEFT JOIN reserva r ON e.Codigo_escuela = r.Codigo_escuela
GROUP BY e.Codigo_escuela, e.Nombre_escuela;
```

**Encontrar escuelas sin reservas:**
```sql
SELECT 
    e.Codigo_escuela,
    e.Nombre_escuela
FROM escuela e
LEFT JOIN reserva r ON e.Codigo_escuela = r.Codigo_escuela
WHERE r.Numero_Reserva IS NULL;
```

### 🔵 RIGHT JOIN (RIGHT OUTER JOIN)

**Definición:** Devuelve **todas las filas de la tabla derecha** y las coincidencias de la izquierda.

```sql
-- Todas las reservas y sus escuelas (si existen)
SELECT 
    r.Numero_Reserva,
    e.Nombre_escuela
FROM escuela e
RIGHT JOIN reserva r ON e.Codigo_escuela = r.Codigo_escuela;
```

💡 **Nota:** `RIGHT JOIN` es menos común; generalmente se reescribe como `LEFT JOIN` invirtiendo el orden de las tablas.

### 🔵 FULL OUTER JOIN

**Definición:** Devuelve **todas las filas** de ambas tablas, con `NULL` donde no hay coincidencia.

```sql
SELECT 
    e.Nombre_escuela,
    r.Numero_Reserva
FROM escuela e
FULL OUTER JOIN reserva r ON e.Codigo_escuela = r.Codigo_escuela;
```

### 🔵 CROSS JOIN (Producto Cartesiano)

**Definición:** Combina **cada fila** de la primera tabla con **cada fila** de la segunda tabla.

```sql
-- Todas las combinaciones posibles entre escuelas y tipos de visita
SELECT 
    e.Nombre_escuela,
    tv.Descripcion_Tipo_Visita
FROM escuela e
CROSS JOIN tipo_visita tv;
```

**Producto Cartesiano Condicionado (= Reunión Natural):**
```sql
-- Es equivalente a INNER JOIN
SELECT *
FROM reserva r, escuela e
WHERE r.Codigo_escuela = e.Codigo_escuela;
```

### 🔵 SELF JOIN

**Definición:** Una tabla se une consigo misma.

```sql
-- Encontrar guías con el mismo apellido
SELECT 
    g1.Codigo_Guia AS Guia1_ID,
    g1.Nombre_Guia + ' ' + g1.Apellido_Guia AS Guia1,
    g2.Codigo_Guia AS Guia2_ID,
    g2.Nombre_Guia + ' ' + g2.Apellido_Guia AS Guia2
FROM guia g1
INNER JOIN guia g2 ON g1.Apellido_Guia = g2.Apellido_Guia
WHERE g1.Codigo_Guia < g2.Codigo_Guia;
```

---

## Subconsultas

### 🔍 Subconsulta en WHERE

**Subconsulta que retorna un valor:**
```sql
-- Tipos de visita con arancel mayor al promedio
SELECT 
    Codigo_Tipo_Visita,
    Descripcion_Tipo_Visita,
    Arancel_por_alumno
FROM tipo_visita
WHERE Arancel_por_alumno > (
    SELECT AVG(Arancel_por_alumno) FROM tipo_visita
);
```

**Subconsulta con IN:**
```sql
-- Escuelas que tienen reservas en 2021
SELECT Nombre_escuela
FROM escuela
WHERE Codigo_escuela IN (
    SELECT DISTINCT Codigo_escuela
    FROM reserva
    WHERE YEAR(FeCHa_VISITa_ReSeRVaDa) = 2021
);
```

**Subconsulta con NOT IN:**
```sql
-- Escuelas sin reservas
SELECT Nombre_escuela
FROM escuela
WHERE Codigo_escuela NOT IN (
    SELECT DISTINCT Codigo_escuela
    FROM reserva
);
```

### 🔍 Subconsulta en FROM

```sql
-- Promedio de aranceles por rango
SELECT 
    Rango,
    AVG(Arancel_por_alumno) AS Promedio
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

### 🔍 Subconsulta en SELECT

```sql
-- Total de reservas por escuela (en línea)
SELECT 
    e.Nombre_escuela,
    (SELECT COUNT(*) 
     FROM reserva r 
     WHERE r.Codigo_escuela = e.Codigo_escuela) AS Total_Reservas
FROM escuela e;
```

### 🔍 EXISTS / NOT EXISTS

**EXISTS:** Verifica si la subconsulta devuelve al menos una fila.

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

**NOT EXISTS:**
```sql
-- Escuelas sin reservas
SELECT Nombre_escuela
FROM escuela e
WHERE NOT EXISTS (
    SELECT 1
    FROM reserva r
    WHERE r.Codigo_escuela = e.Codigo_escuela
);
```

### 🔍 ANY / ALL

**ANY:** Al menos un valor cumple la condición.

```sql
-- Tipos de visita con arancel mayor a cualquier visita básica (<5)
SELECT Descripcion_Tipo_Visita, Arancel_por_alumno
FROM tipo_visita
WHERE Arancel_por_alumno > ANY (
    SELECT Arancel_por_alumno
    FROM tipo_visita
    WHERE Arancel_por_alumno < 5
);
```

**ALL:** Todos los valores cumplen la condición.

```sql
-- Tipos de visita con arancel mayor a todas las visitas básicas
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

### 📦 Variables Locales

**Declarar y asignar:**
```sql
DECLARE @CodigoEscuela INT;
SET @CodigoEscuela = 5;

SELECT * FROM escuela
WHERE Codigo_escuela = @CodigoEscuela;
```

**Declarar con valor inicial:**
```sql
DECLARE @Arancel DECIMAL(8,2) = 10.50;
```

**Múltiples variables:**
```sql
DECLARE 
    @FechaInicio DATE = '2021-01-01',
    @FechaFin DATE = '2021-12-31',
    @Total INT;

SELECT @Total = COUNT(*)
FROM reserva
WHERE FeCHa_VISITa_ReSeRVaDa BETWEEN @FechaInicio AND @FechaFin;

SELECT @Total AS Total_Reservas_2021;
```

### 🧮 Operadores Aritméticos

```sql
SELECT 
    Codigo_Tipo_Visita,
    Arancel_por_alumno,
    Arancel_por_alumno * 1.21 AS Arancel_con_IVA,
    Arancel_por_alumno * 0.9 AS Arancel_Descuento_10,
    Arancel_por_alumno + 5 AS Arancel_Plus_5,
    Arancel_por_alumno / 2 AS Mitad_Arancel
FROM tipo_visita;
```

### 🔤 Concatenación de Cadenas

**Operador `+`:**
```sql
SELECT 
    Nombre_Guia + ' ' + Apellido_Guia AS Nombre_Completo
FROM guia;
```

**Función `CONCAT`:**
```sql
SELECT 
    CONCAT(Nombre_Guia, ' ', Apellido_Guia) AS Nombre_Completo
FROM guia;
```

**Con valores NULL:**
```sql
-- + devuelve NULL si algún operando es NULL
SELECT 'Hola ' + NULL;  -- Resultado: NULL

-- CONCAT trata NULL como cadena vacía
SELECT CONCAT('Hola ', NULL, 'Mundo');  -- Resultado: 'Hola Mundo'
```

### 🔀 CASE (Expresión Condicional)

**CASE simple:**
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

**CASE con resultado numérico:**
```sql
SELECT 
    Numero_Reserva,
    Cantidad_alumnos_Reservados,
    Cantidad_alumnos_Reales,
    CASE
        WHEN Cantidad_alumnos_Reales IS NULL THEN 0
        WHEN Cantidad_alumnos_Reales >= Cantidad_alumnos_Reservados THEN 1
        ELSE 0
    END AS Cumplimiento
FROM reserva_tipo_visita;
```

### 📅 Funciones de Fecha

**Fecha actual:**
```sql
SELECT GETDATE() AS Fecha_Actual;  -- Fecha y hora completa
SELECT CONVERT(DATE, GETDATE()) AS Fecha_Solo;  -- Solo fecha
```

**Extraer partes de fecha:**
```sql
SELECT 
    FeCHa_VISITa_ReSeRVaDa,
    YEAR(FeCHa_VISITa_ReSeRVaDa) AS Anio,
    MONTH(FeCHa_VISITa_ReSeRVaDa) AS Mes,
    DAY(FeCHa_VISITa_ReSeRVaDa) AS Dia,
    DATEPART(WEEKDAY, FeCHa_VISITa_ReSeRVaDa) AS Dia_Semana
FROM reserva;
```

**Agregar/restar tiempo:**
```sql
SELECT DATEADD(DAY, 7, GETDATE()) AS En_Una_Semana;
SELECT DATEADD(MONTH, -3, GETDATE()) AS Hace_Tres_Meses;
SELECT DATEADD(YEAR, 1, '2021-06-12') AS Anio_Siguiente;
```

**Diferencia entre fechas:**
```sql
SELECT DATEDIFF(DAY, '2021-01-01', '2021-12-31') AS Dias;
SELECT DATEDIFF(MONTH, '2021-01-01', '2021-12-31') AS Meses;
SELECT DATEDIFF(YEAR, '2020-01-01', '2023-01-01') AS Anios;
```

### 🔤 Funciones de Cadena

```sql
-- Convertir a mayúsculas/minúsculas
SELECT UPPER('hola mundo');  -- HOLA MUNDO
SELECT LOWER('HOLA MUNDO');  -- hola mundo

-- Longitud de cadena
SELECT LEN('Hola Mundo');  -- 10

-- Subcadena
SELECT SUBSTRING('Hola Mundo', 1, 4);  -- Hola

-- Reemplazar
SELECT REPLACE('Hola Mundo', 'Mundo', 'SQL');  -- Hola SQL

-- Quitar espacios
SELECT LTRIM('   Hola');  -- 'Hola'
SELECT RTRIM('Hola   ');  -- 'Hola'
SELECT TRIM('   Hola   ');  -- 'Hola'
```

### 🔢 Funciones Numéricas

```sql
-- Redondeo
SELECT ROUND(15.567, 2);  -- 15.57
SELECT ROUND(15.567, 0);  -- 16
SELECT ROUND(15.567, -1);  -- 20

-- Techo y piso
SELECT CEILING(15.1);  -- 16
SELECT FLOOR(15.9);  -- 15

-- Valor absoluto
SELECT ABS(-25);  -- 25

-- Potencia y raíz
SELECT POWER(2, 3);  -- 8
SELECT SQRT(25);  -- 5
```

### 🔄 Funciones de Conversión

**CAST:**
```sql
SELECT CAST(123 AS VARCHAR(10));
SELECT CAST('2021-06-12' AS DATE);
SELECT CAST(15.789 AS INT);  -- 15
```

**CONVERT:**
```sql
-- Básico
SELECT CONVERT(VARCHAR(10), 123);
SELECT CONVERT(DATE, '2021-06-12');

-- Con formato de fecha
SELECT CONVERT(VARCHAR, GETDATE(), 103);  -- dd/mm/yyyy
SELECT CONVERT(VARCHAR, GETDATE(), 101);  -- mm/dd/yyyy
SELECT CONVERT(VARCHAR, GETDATE(), 120);  -- yyyy-mm-dd hh:mi:ss
```

### 🛡️ Funciones de Nulos

**ISNULL:**
```sql
SELECT 
    Numero_Reserva,
    ISNULL(Cantidad_alumnos_Reales, 0) AS Alumnos_Reales
FROM reserva_tipo_visita;
```

**COALESCE (primer valor no NULL):**
```sql
SELECT 
    COALESCE(Cantidad_alumnos_Reales, Cantidad_alumnos_Reservados, 0) AS Total
FROM reserva_tipo_visita;
```

**NULLIF (devuelve NULL si ambos son iguales):**
```sql
SELECT NULLIF(10, 10);  -- NULL
SELECT NULLIF(10, 20);  -- 10
```

---

## Conceptos Clave

### 🎯 Orden de Ejecución de SQL

Aunque escribimos:
```
SELECT → FROM → WHERE → GROUP BY → HAVING → ORDER BY
```

SQL ejecuta en este orden:
```
1. FROM       -- Selecciona las tablas
2. WHERE      -- Filtra filas
3. GROUP BY   -- Agrupa filas
4. HAVING     -- Filtra grupos
5. SELECT     -- Selecciona columnas
6. ORDER BY   -- Ordena resultados
7. TOP/LIMIT  -- Limita cantidad de resultados
```

### 🔑 Diferencias Clave

| Concepto | WHERE | HAVING |
|----------|-------|--------|
| **Cuándo filtra** | Antes de agrupar | Después de agrupar |
| **Sobre qué filtra** | Filas individuales | Grupos |
| **Puede usar funciones de agregación** | ❌ No | ✅ Sí |

```sql
-- ✅ CORRECTO
SELECT Codigo_escuela, COUNT(*) AS Total
FROM reserva
WHERE FeCHa_VISITa_ReSeRVaDa > '2020-01-01'  -- Filtra filas individuales
GROUP BY Codigo_escuela
HAVING COUNT(*) > 5;  -- Filtra grupos

-- ❌ INCORRECTO
SELECT Codigo_escuela, COUNT(*) AS Total
FROM reserva
WHERE COUNT(*) > 5  -- ERROR: No se pueden usar funciones de agregación en WHERE
GROUP BY Codigo_escuela;
```

### 📊 NULL en SQL Server

**Reglas importantes:**
- `NULL` representa **ausencia de valor**, no es `0` ni cadena vacía
- Cualquier operación con `NULL` devuelve `NULL`:
  - `NULL + 5 = NULL`
  - `NULL = NULL` → No es `TRUE`, es `NULL`
- Para verificar `NULL` usa `IS NULL` / `IS NOT NULL`
- Para evitar `NULL` usa `ISNULL()` o `COALESCE()`

```sql
-- ❌ INCORRECTO
SELECT * FROM reserva_tipo_visita
WHERE Cantidad_alumnos_Reales = NULL;

-- ✅ CORRECTO
SELECT * FROM reserva_tipo_visita
WHERE Cantidad_alumnos_Reales IS NULL;
```

### 🔄 Producto Cartesiano vs Reunión

**Producto Cartesiano:**
- Combina **cada fila** de la tabla 1 con **cada fila** de la tabla 2
- Si tabla1 tiene 10 filas y tabla2 tiene 20 filas → 200 filas resultantes
- Raramente útil, generalmente es un error

```sql
-- Producto Cartesiano (generalmente no deseado)
SELECT * FROM escuela, tipo_visita;
-- Resultado: 37 escuelas × 17 tipos = 629 filas
```

**Reunión (JOIN):**
- Combina filas **que cumplen una condición**
- **Reunión Natural ≡ Producto Cartesiano Condicionado**

```sql
-- Reunión Natural (usando JOIN)
SELECT * FROM reserva r
INNER JOIN escuela e ON r.Codigo_escuela = e.Codigo_escuela;

-- Producto Cartesiano Condicionado (equivalente, sintaxis antigua)
SELECT * FROM reserva r, escuela e
WHERE r.Codigo_escuela = e.Codigo_escuela;
```

### 🎯 Buenas Prácticas

1. **Siempre usa alias de tabla en JOINs**
   ```sql
   -- ✅ BIEN
   SELECT r.Numero_Reserva, e.Nombre_escuela
   FROM reserva r
   INNER JOIN escuela e ON r.Codigo_escuela = e.Codigo_escuela;
   
   -- ❌ Confuso sin alias
   SELECT Numero_Reserva, Nombre_escuela
   FROM reserva
   INNER JOIN escuela ON reserva.Codigo_escuela = escuela.Codigo_escuela;
   ```

2. **Termina cada batch con GO**
   ```sql
   CREATE TABLE test (id INT);
   GO
   
   INSERT INTO test VALUES (1);
   GO
   ```

3. **Especifica columnas en INSERT**
   ```sql
   -- ✅ BIEN
   INSERT INTO escuela (Codigo_escuela, Nombre_escuela, Domicilio_escuela)
   VALUES (1, 'Escuela 1', 'Domicilio 1');
   
   -- ❌ Frágil (si cambia estructura, falla)
   INSERT INTO escuela VALUES (1, 'Escuela 1', 'Domicilio 1');
   ```

4. **Usa nombres descriptivos**
   ```sql
   -- ✅ BIEN
   SELECT COUNT(*) AS Total_Reservas
   
   -- ❌ Poco claro
   SELECT COUNT(*)
   ```

5. **Comenta consultas complejas**
   ```sql
   -- Calcular total de alumnos por escuela en 2021
   -- incluyendo solo reservas confirmadas
   SELECT 
       e.Nombre_escuela,
       SUM(rtv.Cantidad_alumnos_Reales) AS Total_Alumnos
   FROM escuela e
   INNER JOIN reserva r ON e.Codigo_escuela = r.Codigo_escuela
   INNER JOIN reserva_tipo_visita rtv ON r.Numero_Reserva = rtv.Numero_Reserva
   WHERE YEAR(r.FeCHa_VISITa_ReSeRVaDa) = 2021
       AND rtv.Cantidad_alumnos_Reales IS NOT NULL
   GROUP BY e.Nombre_escuela;
   ```

---

## Operadores de Conjuntos

Requieren **relaciones compatibles**: misma cantidad de columnas y dominios compatibles.

### UNION

Retorna las tuplas que están en R, **o** en S, **o en ambas** (elimina duplicados).

```sql
-- Reservas actuales más reservas históricas con una fecha específica
SELECT Cod_Reserva, Fecha
FROM Reserva
WHERE Fecha = '30/04/2009'

UNION

SELECT Cod_Reserva, Fecha_Hist
FROM Reserva_Historica
WHERE Fecha_Hist = '01/04/2005';
```

**Para incluir duplicados:** `UNION ALL`

### EXCEPT (Diferencia)

Retorna las tuplas que están en R **pero no en S**.

```sql
SELECT Cod_Reserva, Fecha
FROM Reserva

EXCEPT

SELECT Cod_Reserva, Fecha_Hist
FROM Reserva_Historica
WHERE cod_escuela = 100;
```

### INTERSECT (Intersección)

Retorna las tuplas que están en R **y también en S**.

```sql
SELECT Cod_Reserva, Fecha
FROM Reserva

INTERSECT

SELECT Cod_Reserva, Fecha_Hist
FROM Reserva_Historica;
```

---

## Transacciones

Permiten establecer puntos de "restauración" antes de ejecutar operaciones de modificación sensibles. Mientras una transacción está activa, los objetos afectados quedan **bloqueados** para otros usuarios.

```sql
BEGIN TRAN         -- o BEGIN TRANSACTION
    operaciones...
COMMIT             -- Confirma y finaliza la transacción
ROLLBACK           -- Revierte y finaliza la transacción
```

**Ejemplo — UPDATE sin WHERE (error), luego ROLLBACK:**

```sql
BEGIN TRAN

UPDATE Tipo_Visita
SET Arancel = 2;   -- ¡Afecta toda la tabla!

-- Detectamos el error, revertimos:
ROLLBACK;

SELECT * FROM Tipo_Visita;  -- Los datos vuelven a su estado original
```

**Ejemplo — UPDATE correcto, luego COMMIT:**

```sql
BEGIN TRAN

UPDATE Tipo_Visita
SET Arancel = 2
WHERE Codigo IN (4, 5, 7);

-- Verificamos el resultado y confirmamos:
COMMIT;
```

**Reglas clave:**
- `INSERT`, `UPDATE` y `DELETE` son **irreversibles** fuera de una transacción
- Usar transacciones cuando se ejecutan múltiples operaciones relacionadas
- En caso de error, hacer siempre `ROLLBACK` para no dejar la BD en estado inconsistente

---

## Procedimientos Almacenados

Un **Procedimiento Almacenado** (Stored Procedure) es un programa escrito en T-SQL, almacenado como objeto de la base de datos. Se crea una vez y se puede llamar múltiples veces.

**Ventajas:**
- Programación modular y reutilizable
- Ejecución más rápida (se compilan y optimizan en la primera ejecución)
- Reducen el tráfico de red
- Pueden usarse como mecanismo de seguridad

### Sintaxis

```sql
CREATE PROCEDURE nombre_procedimiento
    @parametro1 tipo_de_dato [= default],
    @parametro2 tipo_de_dato OUTPUT
AS
    codigo_sql
GO
```

### Ejemplo sin parámetros

```sql
CREATE PROCEDURE ListarEscuelas
AS
    SELECT Nombre_escuela, Domicilio_escuela
    FROM escuela
    ORDER BY Nombre_escuela;
GO

-- Ejecución:
EXEC ListarEscuelas;
```

### Ejemplo con parámetro de entrada

```sql
-- Lista las escuelas cuyo nombre comienza con una cadena dada
-- Valor predeterminado: 'Esc%'
CREATE PROCEDURE ListaEscuelas
    @Nombre CHAR(20) = 'Esc%'
AS
    SELECT Nombre_Escuela
    FROM Escuela
    WHERE Nombre_Escuela LIKE @Nombre;
GO

-- Ejecución con valor explícito:
EXEC ListaEscuelas 'Esc%';

-- Ejecución con valor predeterminado:
EXEC ListaEscuelas;
```

### Ejemplo con parámetro de salida (OUTPUT)

```sql
-- Devuelve la cantidad de reservas de una escuela
CREATE PROCEDURE ContarReservas
    @CodigoEscuela SMALLINT,
    @Total INT OUTPUT
AS
    SELECT @Total = COUNT(*)
    FROM reserva
    WHERE Codigo_escuela = @CodigoEscuela;
GO

-- Ejecución:
DECLARE @Resultado INT;
EXEC ContarReservas 5, @Resultado OUTPUT;
SELECT @Resultado AS Total_Reservas;
```

### Ejemplo con lógica condicional

```sql
CREATE PROCEDURE ObtenerReservasPorAnio
    @Anio INT
AS
    IF @Anio IS NULL
        SELECT * FROM reserva;
    ELSE
        SELECT * FROM reserva
        WHERE YEAR(FeCHa_VISITa_ReSeRVaDa) = @Anio;
GO

EXEC ObtenerReservasPorAnio 2021;
```

### Modificar y eliminar

```sql
-- Modificar:
ALTER PROCEDURE ListaEscuelas
    @Nombre CHAR(20) = 'Esc%'
AS
    SELECT Nombre_Escuela, Domicilio_escuela
    FROM Escuela
    WHERE Nombre_Escuela LIKE @Nombre;
GO

-- Eliminar:
DROP PROCEDURE ListaEscuelas;
```

---

## Triggers (Disparadores)

Un **Trigger** es una rutina autónoma asociada a una tabla o vista que se ejecuta **automáticamente** ante un evento (INSERT, UPDATE o DELETE). **Nunca se llama directamente.**

**Tres componentes:**
- **Evento**: la operación que lo dispara (INSERT / UPDATE / DELETE)
- **Condición**: verificación opcional antes de ejecutar la acción
- **Acción**: lo que hace el trigger (modificar datos, cancelar operación, auditar, etc.)

**Ventajas:**
- Validaciones y reglas de negocio automáticas
- Mantenimiento de integridad referencial adicional
- Auditoría de cambios
- Mantenimiento de valores derivados

### Tablas especiales en SQL Server

SQL Server provee dos tablas virtuales dentro del trigger:

| Tabla | Contiene |
|-------|----------|
| `inserted` | Las filas nuevas (en INSERT y UPDATE) |
| `deleted` | Las filas eliminadas o anteriores (en DELETE y UPDATE) |

### Sintaxis

```sql
CREATE TRIGGER nombre_trigger
ON tabla  -- o vista
FOR | AFTER | INSTEAD OF
    INSERT, UPDATE, DELETE
AS
    codigo_sql
GO
```

- **`AFTER`** (o `FOR`): se ejecuta **después** de que la operación se complete
- **`INSTEAD OF`**: **reemplaza** la operación original

### Ejemplo AFTER DELETE

```sql
-- Cuando se borra una fila de reserva_tipo_visita,
-- elimina las filas correspondientes en la tabla guia
CREATE TRIGGER trig_delete
ON reserva_tipo_visita
FOR DELETE
AS
    DELETE FROM Guia
    WHERE codigo_guia IN (
        SELECT codigo_guia FROM deleted
    );
GO
```

### Ejemplo AFTER INSERT

```sql
-- Registra en una tabla de auditoría cada nueva reserva insertada
CREATE TRIGGER trig_audit_reserva
ON reserva
AFTER INSERT
AS
    INSERT INTO auditoria_reservas (Numero_Reserva, Fecha_Operacion)
    SELECT Numero_Reserva, GETDATE()
    FROM inserted;
GO
```

### Ejemplo AFTER UPDATE

```sql
-- Impide que el arancel baje a menos de 1
CREATE TRIGGER trig_check_arancel
ON tipo_visita
AFTER UPDATE
AS
    IF EXISTS (SELECT 1 FROM inserted WHERE Arancel_por_alumno < 1)
    BEGIN
        ROLLBACK;
        PRINT 'Error: el arancel no puede ser menor a 1.';
    END
GO
```

### Ejemplo INSTEAD OF DELETE

```sql
-- En lugar de borrar la escuela, la marca como inactiva
CREATE TRIGGER trig_soft_delete_escuela
ON escuela
INSTEAD OF DELETE
AS
    UPDATE escuela
    SET Activa = 0
    WHERE Codigo_escuela IN (
        SELECT Codigo_escuela FROM deleted
    );
GO
```

### Modificar y eliminar triggers

```sql
-- Modificar:
ALTER TRIGGER trig_delete ON reserva_tipo_visita
FOR DELETE
AS
    -- nuevo código
GO

-- Eliminar:
DROP TRIGGER trig_delete;

-- Deshabilitar temporalmente:
DISABLE TRIGGER trig_delete ON reserva_tipo_visita;

-- Volver a habilitar:
ENABLE TRIGGER trig_delete ON reserva_tipo_visita;
```

### Diferencia clave: Stored Procedure vs Trigger

| Característica | Stored Procedure | Trigger |
|---------------|-----------------|---------|
| **Se llama** | Directamente con `EXEC` | Automáticamente ante un evento |
| **Parámetros** | Acepta parámetros IN/OUT | No acepta parámetros |
| **Evento** | Cuando el usuario lo invoca | INSERT, UPDATE, DELETE |
| **Control** | Total (el programador lo decide) | Automático e implícito |
| **Uso típico** | Lógica reutilizable, consultas complejas | Validaciones, auditoría, integridad |

---

## 📚 Recursos Adicionales

**Archivos del proyecto:**
- `UT_3_Script Jurasik Park_SQL_Server_V2.sql` — Script completo de la BD de ejemplo
- `TUTORIAL_SQLSERVER_CMDLINE.md` — Guía detallada de `sqlcmd`
- `Ejercicios-SQL-caso-impocheck-v1.pdf` — Ejercicios adicionales
- `Guia-de-ejercicios-de-parcial-sql-v1-completos.pdf` — Ejercicios tipo parcial

**Documentación oficial:**
- [Transact-SQL Reference](https://learn.microsoft.com/es-es/sql/t-sql/language-reference)
- [SQL Server Tutorials](https://learn.microsoft.com/es-es/sql/sql-server/tutorials-for-sql-server-2016)

---

## ✅ Checklist Pre-Parcial

- [ ] Puedo conectarme a SQL Server desde `sqlcmd` o VS Code
- [ ] Conozco la diferencia entre DDL y DML
- [ ] Sé crear tablas con PRIMARY KEY y FOREIGN KEY
- [ ] Domino INSERT, UPDATE, DELETE
- [ ] Entiendo SELECT con WHERE, ORDER BY, TOP
- [ ] Puedo usar funciones de agregación (COUNT, SUM, AVG, MAX, MIN)
- [ ] Comprendo GROUP BY y la regla de las columnas
- [ ] Sé cuándo usar HAVING vs WHERE
- [ ] Domino INNER JOIN, LEFT JOIN y sus diferencias
- [ ] Puedo escribir subconsultas en WHERE, FROM y SELECT
- [ ] Entiendo el manejo de NULL con IS NULL e ISNULL()
- [ ] Conozco funciones de fecha (YEAR, MONTH, DATEADD, DATEDIFF)
- [ ] Sé usar CASE para expresiones condicionales
- [ ] Comprendo la diferencia entre Producto Cartesiano y Reunión
- [ ] Conozco UNION, EXCEPT e INTERSECT y sus condiciones de compatibilidad
- [ ] Sé usar BEGIN TRAN / COMMIT / ROLLBACK
- [ ] Puedo crear un Procedimiento Almacenado con parámetros de entrada y salida
- [ ] Sé ejecutar un SP con EXEC y pasar parámetros
- [ ] Comprendo qué es un Trigger y cuándo se dispara
- [ ] Conozco las tablas `inserted` y `deleted` de SQL Server
- [ ] Distingo AFTER/FOR de INSTEAD OF
- [ ] Sé la diferencia conceptual entre SP y Trigger

---

**¡Éxitos en el parcial! 🚀**

*Documento creado: Junio 2026*  
*Materia: Bases de Datos — TGAD, FCE-UBA*
