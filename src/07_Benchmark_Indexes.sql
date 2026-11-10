-- =====================================================================
-- PASO 07:    BENCHMARK DE ÍNDICES
-- =====================================================================
-- A. Pruebas de Rendimiento (Benchmark con Estadísticas de IO y CPU)
SET STATISTICS IO ON;
SET STATISTICS TIME ON;

PRINT '--- PRUEBA 1: Búsqueda utilizando Index Seek (Non-Clustered Index) ---';
SELECT cliente_id, nombre, email 
FROM tbl_clientes 
WHERE email = 'usuario_15000@customer360.com';

PRINT '--- PRUEBA 2: Análisis de rangos salariales mediante Índice ---';
SELECT cliente_id, salario_mensual, telefono 
FROM tbl_perfil_sensible 
WHERE salario_mensual BETWEEN 20000.00 AND 30000.00;

SET STATISTICS IO OFF;
SET STATISTICS TIME OFF;
GO