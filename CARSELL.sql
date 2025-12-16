

CREATE DATABASE CARSELL;

USE CARSELL;

CREATE TABLE Vehiculos
(
    vehiculoID CHAR(7) PRIMARY KEY, -- Placa
    marca VARCHAR(50),
    modelo VARCHAR(50),
    año INT,
    tipo VARCHAR(30),
    precio DECIMAL(10,2),
    estadoMecanico VARCHAR(100),
    disponibilidad VARCHAR(20), -- Disponible / Reservado / Vendido / Mantenimiento
    fechaIngresoInventario DATE,
    descripcion VARCHAR(255),
    proveedorID CHAR(10)
);

INSERT INTO Vehiculos
VALUES ('ABC1234', 'Toyota', 'Corolla', 2020, 'Sedán', 16500.00, 'Excelente',
        'Disponible', '2024-03-10', 'Vehículo en perfecto estado', 'PROV001');

INSERT INTO Vehiculos
VALUES ('XYZ5678', 'Chevrolet', 'Spark', 2018, 'Hatchback', 9200.00, 'Bueno',
        'Reservado', '2024-02-15', 'Eficiente y económico', 'PROV002');

INSERT INTO Vehiculos
VALUES ('PQR8910', 'Hyundai', 'Tucson', 2022, 'SUV', 28500.00, 'Nuevo',
        'Disponible', '2024-05-01', 'Último modelo, pocas unidades', 'PROV003');

INSERT INTO Vehiculos
VALUES ('DEF4567', 'Kia', 'Rio', 2019, 'Sedán', 11000.00, 'Muy bueno',
        'Vendido', '2024-01-20', 'Recién afinado', 'PROV001');


CREATE TABLE Clientes
(
    clienteID CHAR(10) PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    telefono CHAR(10),
    email VARCHAR(100),
    direccion VARCHAR(150)
);


INSERT INTO Clientes
VALUES ('1716410210', 'Alisson', 'Chiguano', '0987654321',
        'alisson@gmail.com', 'Quito, Ecuador');

INSERT INTO Clientes
VALUES ('1710982348', 'Roger', 'Tallana', '0991234567',
        'roger@gmail.com', 'Latacunga, Ecuador');

INSERT INTO Clientes
VALUES ('1716938210', 'Erick', 'Analuisa', '0981122334',
        'erick@gmail.com', 'Ambato, Ecuador');

INSERT INTO Clientes
VALUES ('1755582348', 'Antonio', 'Valencia', '0979988776',
        'antonio@gmail.com', 'Ibarra, Ecuador');


CREATE TABLE Empleados
(
    empleadoID CHAR(10) PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    telefono CHAR(10),
    email VARCHAR(100),
    puesto VARCHAR(50)
);

INSERT INTO Empleados
VALUES ('EMP001', 'Carlos', 'Mendoza', '0981112233',
        'carlos.mendoza@empresa.com', 'Vendedor');

INSERT INTO Empleados
VALUES ('EMP002', 'María', 'López', '0993322110',
        'maria.lopez@empresa.com', 'Administradora');

INSERT INTO Empleados
VALUES ('EMP003', 'Javier', 'Suarez', '0975544332',
        'javier.suarez@empresa.com', 'Técnico');

INSERT INTO Empleados
VALUES ('EMP004', 'Fernanda', 'Pérez', '0987766554',
        'fernanda.perez@empresa.com', 'Vendedora');


select * from Vehiculos;

select * from Clientes;

select * from Empleados;

