-- =====================================================================
-- PASO 03: CARGA MASIVA DE DATOS POR LOTES (STAGING / SIMULACIÓN)
-- =====================================================================

USE DB_Customer360_Lab;
GO

PRINT 'Iniciando carga masiva optimizada de clientes y perfiles...';
SET NOCOUNT ON;

DECLARE @i INT = 1;
DECLARE @batch_size INT = 5000;
DECLARE @total_records INT = 20000;

WHILE @i <= @total_records
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Inserción por lotes controlados
        DECLARE @j INT = @i;
        WHILE @j < @i + @batch_size AND @j <= @total_records
        BEGIN
            INSERT INTO tbl_clientes (nombre, email, ciudad, fecha_registro)
            VALUES (
                CONCAT('Cliente_', @j),
                CONCAT('usuario_', @j, '@customer360.com'),
                CASE (@j % 4) WHEN 0 THEN 'León' WHEN 1 THEN 'CDMX' WHEN 2 THEN 'Guadalajara' ELSE 'Monterrey' END,
                DATEADD(day, -(@j % 730), GETDATE())
            );

            DECLARE @last_id INT = SCOPE_IDENTITY();

            INSERT INTO tbl_perfil_sensible (cliente_id, salario_mensual, telefono)
            VALUES (
                @last_id,
                10000.00 + (@j % 45000),
                CONCAT('477', RIGHT(CONCAT('0000000', @j), 7))
            );

            SET @j = @j + 1;
        END

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        PRINT CONCAT('Error en el lote que inicia en: ', @i);
    END CATCH

    SET @i = @i + @batch_size;
END

SET NOCOUNT OFF;
PRINT '¡Carga masiva completada exitosamente!';
GO