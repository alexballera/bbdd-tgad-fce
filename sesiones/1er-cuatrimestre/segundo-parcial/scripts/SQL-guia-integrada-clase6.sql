-- ===================================================================
-- EJERCICIOS CLASE 6: PROCEDIMIENTOS ALMACENADOS Y TRIGGERS
-- ===================================================================
USE Jurassic_Park_Practica;
GO
-- ===================================================================

-- ===================================================================
-- EJERCICIOS: PROCEDIMIENTOS ALMACENADOS
-- ===================================================================

-- ===================================================================
-- 1. Procedimiento que recibe Codigo_Guia y devuelve la cantidad total
--    de alumnos reales asignados a ese guia.
-- ===================================================================

CREATE OR ALTER PROCEDURE sp_TotalAlumnosRealesPorGuia
    @Codigo_Guia smallint
AS
BEGIN
    SELECT SUM(cantidad_alumnos_reales) AS total_alumnos_reales
    FROM Reserva_Tipo_Visita
    WHERE codigo_guia = @Codigo_Guia;
END;
GO

-- Prueba:
EXEC sp_TotalAlumnosRealesPorGuia @Codigo_Guia = 1;

-- ===================================================================
-- 2. Procedimiento para ingresar nuevas escuelas.
--    Parametros: Codigo_Escuela, Nombre_Escuela, Calle_Escuela, Altura_Escuela.
--    (El esquema actual reemplaza Domicilio_Escuela por calle + altura).
-- ===================================================================

CREATE OR ALTER PROCEDURE sp_InsertarEscuela
    @Codigo_Escuela   smallint,
    @Nombre_Escuela   varchar(50),
    @Calle_Escuela    varchar(50),
    @Altura_Escuela   smallint
AS
BEGIN
    INSERT INTO Escuela (codigo_escuela, nombre_escuela, calle_escuela, altura_escuela)
    VALUES (@Codigo_Escuela, @Nombre_Escuela, @Calle_Escuela, @Altura_Escuela);
END;
GO

-- Prueba:
EXEC sp_InsertarEscuela @Codigo_Escuela = 100, @Nombre_Escuela = 'Escuela Test',
                        @Calle_Escuela = 'Av. Test', @Altura_Escuela = 123;

-- ===================================================================
-- 3. Procedimiento que lista guias cuyos apellidos comienzan con una
--    cadena determinada por parametro (valor predeterminado: 'A').
-- ===================================================================

CREATE OR ALTER PROCEDURE sp_GuiasPorApellido
    @Prefijo varchar(50) = 'A'
AS
BEGIN
    SELECT codigo_guia, nombre_guia, apellido_guia
    FROM Guia
    WHERE apellido_guia LIKE @Prefijo + '%';
END;
GO

-- Prueba con valor predeterminado:
EXEC sp_GuiasPorApellido;
-- Prueba con parametro explicito:
EXEC sp_GuiasPorApellido @Prefijo = 'Z';

-- ===================================================================
-- EJERCICIOS: TRIGGERS
-- ===================================================================

-- ===================================================================
-- 4. Trigger sobre Escuela: al borrar una fila, elimina las filas
--    correspondientes en Telefono_Escuela.
-- ===================================================================

CREATE OR ALTER TRIGGER trg_Escuela_Delete
ON Escuela
AFTER DELETE
AS
BEGIN
    DELETE FROM Telefono_Escuela
    WHERE codigo_escuela IN (
        SELECT codigo_escuela FROM deleted
    );
END;
GO

-- ===================================================================
-- 5. Trigger sobre Guia: al actualizar codigo_guia, actualiza el
--    codigo_guia correspondiente en Reserva_Tipo_Visita.
-- ===================================================================

CREATE OR ALTER TRIGGER trg_Guia_Update_Codigo
ON Guia
AFTER UPDATE
AS
BEGIN
    IF UPDATE(codigo_guia)
    BEGIN
        UPDATE Reserva_Tipo_Visita
        SET codigo_guia = i.codigo_guia
        FROM Reserva_Tipo_Visita rtv
        JOIN deleted d ON rtv.codigo_guia = d.codigo_guia
        JOIN inserted i ON d.codigo_guia != i.codigo_guia;
    END;
END;
GO

-- ===================================================================
-- 6. Trigger sobre Telefono_Escuela: al insertar, verifica que exista
--    el codigo_escuela; si no existe, cancela la insercion.
-- ===================================================================

CREATE OR ALTER TRIGGER trg_TelefonoEscuela_Insert
ON Telefono_Escuela
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM inserted i
        WHERE NOT EXISTS (
            SELECT 1 FROM Escuela e
            WHERE e.codigo_escuela = i.codigo_escuela
        )
    )
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('El codigo_escuela no existe en la tabla Escuela.', 16, 1);
    END;
END;
GO

-- ===================================================================
-- CLASE 6 - Adicionales
-- ===================================================================

-- ===================================================================
-- A1. Stored procedure que inserta 26 escuelas en forma secuencial.
--     Genera codigos consecutivos a partir del maximo existente + 1.
-- ===================================================================

CREATE OR ALTER PROCEDURE sp_Insertar26Escuelas
AS
BEGIN
    DECLARE @i         smallint = 1;
    DECLARE @base      smallint;
    DECLARE @codigo    smallint;

    SELECT @base = ISNULL(MAX(codigo_escuela), 0) FROM Escuela;

    WHILE @i <= 26
    BEGIN
        SET @codigo = @base + @i;
        INSERT INTO Escuela (codigo_escuela, nombre_escuela, calle_escuela, altura_escuela)
        VALUES (
            @codigo,
            'Escuela ' + CAST(@codigo AS varchar(10)),
            'Calle Generada',
            @codigo
        );
        SET @i = @i + 1;
    END;
END;
GO

-- Prueba:
-- EXEC sp_Insertar26Escuelas;

-- ===================================================================
-- A2. Stored procedure que inserta un Guia validando UserID y Password
--     contra la tabla USERID.
-- ===================================================================

-- Tabla requerida (crear si no existe):
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'USERID')
BEGIN
    CREATE TABLE USERID (
        user_id  char(20) NOT NULL PRIMARY KEY,
        password char(20) NOT NULL
    );
END;
GO

CREATE OR ALTER PROCEDURE sp_InsertarGuiaConAuth
    @Codigo_Guia   smallint,
    @Apellido_Guia varchar(50),
    @Nombre_Guia   varchar(50),
    @UserID        char(20),
    @Password      char(20)
AS
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM USERID
        WHERE user_id = @UserID AND password = @Password
    )
    BEGIN
        RAISERROR('Credenciales invalidas. Insercion cancelada.', 16, 1);
        RETURN;
    END;

    INSERT INTO Guia (codigo_guia, nombre_guia, apellido_guia, sueldo_hora, domicilio_guia)
    VALUES (@Codigo_Guia, @Nombre_Guia, @Apellido_Guia, 0, 'Sin domicilio asignado');
END;
GO

-- Prueba:
-- EXEC sp_InsertarGuiaConAuth @Codigo_Guia = 99, @Apellido_Guia = 'Test',
--      @Nombre_Guia = 'Usuario', @UserID = 'admin', @Password = 'pass123';

-- ===================================================================
-- A3. Trigger sobre Reserva_Tipo_Visita: si cantidad_alumnos_reales > 50,
--     inserta los valores en una tabla AUDITORIA.
-- ===================================================================

-- Tabla requerida (crear si no existe):
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'AUDITORIA')
BEGIN
    CREATE TABLE AUDITORIA (
        numero_reserva             smallint     NOT NULL,
        codigo_tipo_visita         smallint     NOT NULL,
        codigo_guia                smallint     NOT NULL,
        cantidad_alumnos_reservados smallint    NOT NULL,
        cantidad_alumnos_reales    smallint     NOT NULL,
        fecha_auditoria            datetime     NOT NULL DEFAULT GETDATE()
    );
END;
GO

CREATE OR ALTER TRIGGER trg_ReservaTipoVisita_Auditoria
ON Reserva_Tipo_Visita
AFTER INSERT
AS
BEGIN
    INSERT INTO AUDITORIA
        (numero_reserva, codigo_tipo_visita, codigo_guia,
         cantidad_alumnos_reservados, cantidad_alumnos_reales)
    SELECT
        numero_reserva, codigo_tipo_visita, codigo_guia,
        cantidad_alumnos_reservados, cantidad_alumnos_reales
    FROM inserted
    WHERE cantidad_alumnos_reales > 50;
END;
GO
