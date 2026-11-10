-- =====================================================================
-- PASO 06: EXTRACCIÓN DE DICCIONARIO DE DATOS   BENCHMARK DE ÍNDICES
-- =====================================================================

USE DB_Customer360_Lab;
GO

-- 1. Extracción del Diccionario de Datos integrado con Propiedades Extendidas
SELECT 
    t.name AS Tabla,
    c.name AS Columna,
    tp.name AS TipoDato,
    c.max_length AS Longitud,
    ISNULL(ep.value, 'Sin descripción técnica/negocio') AS DescripcionGobernanza
FROM sys.tables t
INNER JOIN sys.columns c ON t.object_id = c.object_id
INNER JOIN sys.types tp ON c.user_type_id = tp.user_type_id
LEFT JOIN sys.extended_properties ep ON ep.major_id = t.object_id 
    AND ep.minor_id = c.column_id 
    AND ep.name = N'MS_Description';
GO