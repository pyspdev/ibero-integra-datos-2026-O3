-- =====================================================================
-- PASO 05: GOBERNANZA E INYECCIÓN DE METADATOS (PROPIEDADES EXTENDIDAS)
-- =====================================================================

USE DB_Customer360_Lab;
GO

-- Documentación a nivel de tabla
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Tabla maestra de clientes del proyecto integrador Customer360.',
    @level0type = N'SCHEMA', @level0name = N'dbo',
    @level1type = N'TABLE',  @level1name = N'tbl_clientes';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Tabla transaccional que almacena información financiera y sensible de perfiles.',
    @level0type = N'SCHEMA', @level0name = N'dbo',
    @level1type = N'TABLE',  @level1name = N'tbl_perfil_sensible';
GO

-- Documentación a nivel de columnas críticas
EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Correo electrónico corporativo y único del cliente sujeto a validación CHECK.',
    @level0type = N'SCHEMA', @level0name = N'dbo', 
    @level1type = N'TABLE',  @level1name = N'tbl_clientes', 
    @level2type = N'COLUMN', @level2name = 'email';
GO

EXEC sys.sp_addextendedproperty 
    @name = N'MS_Description', 
    @value = N'Salario mensual registrado; sujeto a la regla de calidad de mínimo 7,500.00.',
    @level0type = N'SCHEMA', @level0name = N'dbo', 
    @level1type = N'TABLE',  @level1name = N'tbl_perfil_sensible', 
    @level2type = N'COLUMN', @level2name = 'salario_mensual';
GO