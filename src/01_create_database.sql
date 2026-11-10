-- =====================================================================
-- PASO 01: CREACIÓN DE LA BASE DE DATOS Y CONFIGURACIÓN INICIAL
-- Proyecto: DB_Customer360_Lab
-- =====================================================================

USE MASTER;
GO

IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'DB_Customer360_Lab')
    CREATE DATABASE DB_Customer360_Lab;
GO

USE DB_Customer360_Lab;
GO

-- Creación de un esquema dedicado para la arquitectura 360 (opcional pero recomendado)
IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'customer360')
    EXEC('CREATE SCHEMA customer360');
GO