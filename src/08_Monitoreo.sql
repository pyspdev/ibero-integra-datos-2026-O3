-- ============================================================================
-- PASO 1: consultas útiles para mostrar la carga masiva
-- ============================================================================
select COUNT(*) from dbo.tbl_clientes;

SELECT COUNT(*) AS total_registros 
FROM tbl_clientes;

SELECT COUNT(cliente_id) AS total 
FROM tbl_clientes;

select count(*) from dbo.tbl_perfil_sensible;

SELECT TOP 20 * FROM tbl_clientes;

use DB_Customer360_Lab
select * from tbl_clientes


-- ============================================================================
-- PASO 2: AUDITORÍA DE ÍNDICES ACTUALES
-- ============================================================================
PRINT '--- 2. AUDITORÍA DE ÍNDICES ACTUALES ---';
EXEC sp_helpindex 'tbl_clientes';
GO


-- ============================================================================
-- PASO 3: ACTIVAR EL CRONÓMETRO Y ESTADÍSTICAS (SIN ÍNDICE)
-- ============================================================================
-- Desactivamos temporalmente el índice no agrupado para simular el escenario costoso
ALTER INDEX IX_tbl_clientes_email ON tbl_clientes DISABLE;
PRINT '--- a. Desactivando los indices para la tabla de clientes---';
GO


PRINT '--- b. CONSULTA SIN ÍNDICE (TABLE SCAN) ---';
SET STATISTICS TIME ON;
SET STATISTICS IO ON;
-- Ejecutamos una búsqueda por correo electrónico
SELECT cliente_id, nombre, email, fecha_registro
FROM tbl_clientes
WHERE email = 'avega@customer360.com';

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;
GO


-- ============================================================================
-- PASO 4: HABILITAR NUEVAMENTE EL ÍNDICE Y REPETir LA MEDICIÓN
-- ============================================================================
PRINT '--- 4. RECONSTRUYENDO EL ÍNDICE ---';
ALTER INDEX IX_tbl_clientes_email ON tbl_clientes REBUILD;
GO

PRINT '--- 5. CONSULTA CON ÍNDICE (INDEX SEEK) ---';
SET STATISTICS TIME ON;
SET STATISTICS IO ON;

-- Ejecutamos exactamente la misma consulta para comparar el tiempo y lecturas
SELECT cliente_id, nombre, email, fecha_registro
FROM tbl_clientes
WHERE email = 'avega@customer360.com';

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;
GO

