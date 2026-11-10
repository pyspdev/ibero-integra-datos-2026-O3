-- =====================================================================
-- PASO 04: CREACIÓN Y OPTIMIZACIÓN DE ÍNDICES
-- =====================================================================

USE DB_Customer360_Lab;
GO

-- Eliminar índices previos si existieran para evitar conflictos
IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_tbl_clientes_email' AND object_id = OBJECT_ID('tbl_clientes'))
    DROP INDEX IX_tbl_clientes_email ON tbl_clientes;
GO

IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'IX_tbl_perfil_salario' AND object_id = OBJECT_ID('tbl_perfil_sensible'))
    DROP INDEX IX_tbl_perfil_salario ON tbl_perfil_sensible;
GO

-- Creación de Índices Non-Clustered orientados a consultas frecuentes y filtros analíticos
CREATE NONCLUSTERED INDEX IX_tbl_clientes_email 
ON tbl_clientes(email)
INCLUDE (nombre, ciudad);
GO

CREATE NONCLUSTERED INDEX IX_tbl_perfil_salario 
ON tbl_perfil_sensible(salario_mensual)
INCLUDE (cliente_id, telefono);
GO

PRINT 'Índices creados e inyectados correctamente.';
GO