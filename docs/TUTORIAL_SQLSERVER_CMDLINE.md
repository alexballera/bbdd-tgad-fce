# Tutorial: SQL Server desde Línea de Comandos (sqlcmd)

## ¿Qué es sqlcmd?

`sqlcmd` es la **interfaz de línea de comandos de SQL Server**, similar a:
- `mysql` en MySQL
- `psql` en PostgreSQL
- `node` en Node.js

Te permite conectarte a una instancia de SQL Server y ejecutar comandos SQL directamente desde PowerShell.

---

## Instalación

SQL Server Express ya incluye `sqlcmd`, pero está ubicado en una ruta larga:

```
C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\180\Tools\Binn\sqlcmd.exe
```

### Crear un alias para facilitar el uso (opcional pero recomendado)

Abre tu archivo de perfil de PowerShell:

```powershell
notepad $PROFILE
```

Si no existe, PowerShell te preguntará si lo crear. Pon sí.

Agrega esta línea al final del archivo:

```powershell
Set-Alias -Name sqlcmd -Value 'C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\180\Tools\Binn\sqlcmd.exe'
```

Guarda el archivo.

Cierra PowerShell completamente y vuelve a abrirla.

Ahora podés usar `sqlcmd` directamente sin la ruta completa.

---

## Conectarse a SQL Server

### Opción 1: Conexión interactiva (abrir un prompt)

```powershell
sqlcmd -S .\SQLEXPRESS -E -C
```

**Parámetros explicados:**
- `-S .\SQLEXPRESS` → Servidor (`.\` significa local, `SQLEXPRESS` es el nombre de la instancia)
- `-E` → Usa autenticación de Windows (con tus credenciales actuales)

Si el driver sigue mostrando error de certificado, usa esta variante recomendada:

```powershell
sqlcmd -S .\SQLEXPRESS -E -C
```

**Resultado:** Se abre un prompt `1>` donde podés escribir comandos SQL.

```sql
1> SELECT @@VERSION;
2> GO
```

(Presioná Enter dos veces: una para terminar la línea, otra para ejecutar `GO`)

---


```powershell
sqlcmd -S .\SQLEXPRESS -E -C -d Jurasik_Park
```

**Parámetro nuevo:**
- `-d Jurasik_Park` → Selecciona la base de datos `Jurasik_Park`

Ahora ya estás dentro de esa base sin necesidad de `USE Jurasik_Park;`.

---

## Ejecutar un script SQL desde la terminal

Sin necesidad de abrir un prompt interactivo, ejecutá un script directamente:

```powershell
sqlcmd -S .\SQLEXPRESS -E -C -d Jurasik_Park -i "C:\ruta\al\archivo.sql"
```

**Parámetro nuevo:**
- `-i "ruta_del_archivo"` → Ejecuta el archivo SQL especificado

**Para este proyecto específico:**

```powershell
sqlcmd -S .\SQLEXPRESS -E -C -d Jurasik_Park -i "C:\Users\Alexander\Proyectos\educacion\datos\bbdd-tgad-fce\sesiones\primer-parcial\UT_3_Script Jurasik Park_SQL_Server_V2.sql"
```

---

## Crear una base de datos


```sql
1> CREATE DATABASE Jurasik_Park;
2> GO
```

Verifica que se creó:

```sql
1> SELECT name FROM sys.databases WHERE name = 'Jurasik_Park';
2> GO
```

---

## Comandos básicos en el prompt de sqlcmd

| Comando | Significado |
|---------|------------|
| `GO` | Ejecuta los comandos anteriores |
| `EXIT` | Sale de sqlcmd |
| `QUIT` | Sale de sqlcmd (equivalente a EXIT) |
| `RESET` | Limpia el buffer actual |

---
---

## 🔷 FLUJO COMPLETO: VS Code + MSSQL (RECOMENDADO)

> **Nota:** El script `UT_3_Script Jurasik Park_SQL_Server_V2.sql` ya tiene comentados los comandos `CREATE DATABASE` y `USE` (líneas 2 y 6) para evitar errores en re-ejecuciones. Esto es intencional.

### Paso 1: Crear la base de datos desde `master`

1. **Abre VS Code** con el archivo `UT_3_Script Jurasik Park_SQL_Server_V2.sql`.
2. **Conecta a `.\SQLEXPRESS`:**
   - Extensión `mssql` instalada → Click en **Connect** (arriba del editor)
   - **Create Connection Profile:**
     - Server: `.\SQLEXPRESS`
     - Authentication: `Windows Authentication`
     - ☑ Trust server certificate
     - Encrypt: `Optional`
   - Click Connect

3. **Abre una pestaña nueva** en el editor y ejecuta (asegúrate de estar en contexto `master`):

```sql
CREATE DATABASE Jurasik_Park;
GO
```

4. **Verifica:**

```sql
SELECT name FROM sys.databases WHERE name = 'Jurasik_Park';
GO
```

---

### Paso 2: Ejecutar el script principal

El script **ya tiene comentados** `CREATE DATABASE` y `USE`:

```sql
-- Base de datos : `Jurasik_Park`
-- CREATE database Jurasik_Park;     ← COMENTADO (ya existe)
-- ...
-- USE Jurasik_Park;                 ← COMENTADO (se crea en Step 1)
```

1. Abre `UT_3_Script Jurasik Park_SQL_Server_V2.sql` en el editor.
2. Selecciona todo `Ctrl+A`.
3. Ejecuta (botón **Run** / Execute Query).
4. **Observa el panel `OUTPUT (MSSQL)`** para confirmar que las tablas se crearon y los datos se insertaron.

---

### Paso 3: Verificar en VS Code

Ejecuta (en una pestaña nueva):

```sql
USE Jurasik_Park;
GO

SELECT TOP 5 * FROM escuela;
GO

SELECT name FROM sys.tables ORDER BY name;
GO
```

Verifica que ves los datos y las 8 tablas.

---

### Paso 4: Verificar en SSMS (opcional)

1. Abre **SQL Server Management Studio**.
2. Conecta a `.\SQLEXPRESS` (Windows Auth, Trust certificate, Encrypt=Optional).
3. **Object Explorer** → `Databases` → click derecho → **Refresh**.
4. Expande `Jurasik_Park` → `Tables` → verifica:
   - `escuela`, `guia`, `reserva`, `telefono_escuela`, `tipo_visita`, `grado`, `reserva_tipo_visita`, `reserva_por_grado`

---

## 🔷 FLUJO ALTERNATIVO: CLI (sqlcmd)

### Paso 1: Crear la base de datos

```powershell
sqlcmd -S .\SQLEXPRESS -E -C
```

```sql
1> CREATE DATABASE Jurasik_Park;
2> GO
1> EXIT
```

### Paso 2: Ejecutar el script

```powershell
sqlcmd -S .\SQLEXPRESS -E -C -d Jurasik_Park -i "C:\Users\Alexander\Proyectos\educacion\datos\bbdd-tgad-fce\sesiones\primer-parcial\UT_3_Script Jurasik Park_SQL_Server_V2.sql"
```

### Paso 3: Verificar que se creó todo

```powershell
sqlcmd -S .\SQLEXPRESS -E -C -d Jurasik_Park
```

```sql
1> SELECT * FROM escuela;
2> GO
1> SELECT name FROM sys.tables;
2> GO
```

---

## 🔷 FLUJO ALTERNATIVO: SSMS (SQL Server Management Studio)

### Paso 1: Crear la base de datos

1. Abre **SQL Server Management Studio**.
2. Server name: `.\SQLEXPRESS` → Authentication: `Windows Authentication`.
3. **Options** → marca `Trust server certificate`, `Encrypt` = `Optional`.
4. **Connect**.
5. **New Query** (asegúrate que el contexto es `master`).
6. Ejecuta:

```sql
CREATE DATABASE Jurasik_Park;
GO
```

---

### Paso 2: Ejecutar el script

1. **File** → **Open** → **File...** → abre `UT_3_Script Jurasik Park_SQL_Server_V2.sql`.
2. Selecciona todo `Ctrl+A`.
3. Ejecuta `F5` o botón **Execute**.
4. Observa en el panel inferior (Messages) que se crearon las tablas e insertos.

---

### Paso 3: Verificar

1. **Object Explorer** (lado izquierdo) → **Databases** → click derecho → **Refresh**.
2. Expande `Jurasik_Park` → `Tables` → verifica las 8 tablas.
3. Click derecho en tabla `escuela` → **Select Top 1000 Rows** para ver datos.

---

## Resolver errores comunes


**Causa:** El servicio de SQL Server no está corriendo.

**Solución:**

```powershell
Get-Service -Name *SQL* | Select-Object Name, Status
```

Si está "Stopped", inícialos:

```powershell
Start-Service -Name "MSSQL$SQLEXPRESS"
```

---

### Error: "Proveedor de SSL: La cadena de certificación fue emitida por una entidad en la que no se confía"

**Causa:** SQL Server usa cifrado SSL pero el certificado no es de confianza local.

**Solución:** Usa `sqlcmd -S .\SQLEXPRESS -E -C`:

```powershell
sqlcmd -S .\SQLEXPRESS -E -C
```

---

### Error: "The term 'sqlcmd' is not recognized"

**Causa:** `sqlcmd` no está en el PATH.

**Solución 1 (temporal):** Usa la ruta completa:

```powershell
& "C:\Program Files\Microsoft SQL Server\Client SDK\ODBC\180\Tools\Binn\sqlcmd.exe" -S .\SQLEXPRESS -E
```

**Solución 2 (permanente):** Crea el alias en tu `$PROFILE` (ver sección "Crear un alias" arriba).

---

## Comparación: sqlcmd vs MySQL vs Node.js

| Operación | sqlcmd | mysql | node |
|-----------|--------|-------|------|
| Conectar | `sqlcmd -S servidor -E -C` | `mysql -u usuario -p` | `node` |
| Abrir prompt | `sqlcmd -S .\SQLEXPRESS -E -C` | `mysql -u root -p` | `node` |
| Salir | `EXIT` o `QUIT` | `EXIT` o `QUIT` | `.exit` o `CTRL+D` |
| Ejecutar archivo | `sqlcmd -i archivo.sql` | `mysql < archivo.sql` | `node archivo.js` |
| Ejecutar comando | Tipear y presionar `GO` | Tipear y presionar `;` | Tipear y presionar Enter |

---

## Próximos pasos

1. Ejecuta el script completo de Jurasik_Park
2. Practica con consultas SELECT simples
3. Haz JOINs entre tablas
4. Aprende sobre GROUP BY y agregaciones

¡Listo para empezar!
