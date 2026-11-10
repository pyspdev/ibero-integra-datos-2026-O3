-- =====================================================================
-- PASO 02: CREACIÓN DE TABLAS Y RESTRICCIONES DE CALIDAD (ACID / CHECK)
-- =====================================================================

USE DB_Customer360_Lab;
GO

-- Limpieza previa si existen
IF OBJECT_ID('dbo.tbl_perfil_sensible', 'U') IS NOT NULL
    DROP TABLE dbo.tbl_perfil_sensible;
IF OBJECT_ID('dbo.tbl_clientes', 'U') IS NOT NULL
    DROP TABLE dbo.tbl_clientes;
GO

-- Tabla Maestra de Clientes
CREATE TABLE tbl_clientes (
    cliente_id INT IDENTITY(1,1) PRIMARY KEY CLUSTERED,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    ciudad VARCHAR(100) NULL,
    fecha_registro DATETIME DEFAULT GETDATE(),
    CONSTRAINT CK_clientes_email_valido CHECK (email LIKE '%_@_%._%')
);
GO

-- Tabla Transaccional / Perfil Sensible (Vinculada por Clave Foránea)
CREATE TABLE tbl_perfil_sensible (
    perfil_id INT IDENTITY(1,1) PRIMARY KEY CLUSTERED,
    cliente_id INT NOT NULL,
    salario_mensual DECIMAL(12,2) NOT NULL,
    telefono VARCHAR(20) NULL,
    CONSTRAINT FK_perfil_cliente FOREIGN KEY (cliente_id) REFERENCES tbl_clientes(cliente_id),
    CONSTRAINT CK_perfil_salario_positivo CHECK (salario_mensual >= 7500.00)
);
GO