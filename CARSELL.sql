CREATE DATABASE CARSELL;
USE CARSELL;


CREATE TABLE Proveedores (
    proveedorID CHAR(10) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    contacto VARCHAR(100),
    telefono CHAR(10),
    email VARCHAR(100) UNIQUE
);

INSERT INTO Proveedores VALUES
('PROV001','AutoImport','Luis Mayorga','0981112233','autoimport@gmail.com'),
('PROV002','ChevyCorp','Andrea Zoto','0993322110','chevycorp@gmail.com'),
('PROV003','Hyundai Ecuador','Carlos Mena','0975544332','hyundai@gmail.com'),
('PROV004','Kia Motors EC','Fernando Ruiz','0967788991','kia@gmail.com'),
('PROV005','Nissan Ecuador','María Torres','0956677889','nissan@gmail.com');


CREATE TABLE Vehiculos (
    vehiculoID CHAR(7) PRIMARY KEY, -- Placa
    marca VARCHAR(50) NOT NULL,
    modelo VARCHAR(50) NOT NULL,
    anio INT NOT NULL,
    tipo VARCHAR(30),
    precio DECIMAL(10,2) NOT NULL,
    estadoMecanico VARCHAR(100),
    disponibilidad VARCHAR(20) DEFAULT 'Disponible',
    fechaIngresoInventario DATE,
    descripcion VARCHAR(255),
    proveedorID CHAR(10),
    FOREIGN KEY (proveedorID) REFERENCES Proveedores(proveedorID)
);

INSERT INTO Vehiculos VALUES
('ABC1234','Toyota','Corolla',2020,'Sedán',16500,'Excelente','Disponible','2024-03-10','Vehículo en perfecto estado','PROV001'),
('XYZ5678','Chevrolet','Spark',2018,'Hatchback',9200,'Bueno','Reservado','2024-02-15','Eficiente y económico','PROV002'),
('PQR8910','Hyundai','Tucson',2022,'SUV',28500,'Nuevo','Disponible','2024-05-01','Último modelo, pocas unidades','PROV003'),
('DEF4567','Kia','Rio',2019,'Sedán',11000,'Muy bueno','Vendido','2024-01-20','Recién afinado','PROV001');



CREATE TABLE Clientes (
    clienteID CHAR(10) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono CHAR(10),
    email VARCHAR(100) UNIQUE,
    direccion VARCHAR(150)
);

INSERT INTO Clientes VALUES
('1716410210','Alisson','Chiguano','0987654321','alisson@gmail.com','Quito, Ecuador'),
('1710982348','Roger','Tallana','0991234567','roger@gmail.com','Latacunga, Ecuador'),
('1716938210','Erick','Analuisa','0981122334','erick@gmail.com','Ambato, Ecuador'),
('1755582348','Antonio','Valencia','0979988776','antonio@gmail.com','Ibarra, Ecuador');



CREATE TABLE Empleados (
    empleadoID CHAR(10) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono CHAR(10),
    email VARCHAR(100) UNIQUE,
    puesto VARCHAR(50) DEFAULT 'Vendedor'
);

INSERT INTO Empleados VALUES
('EMP001','Carlos','Mendoza','0981112233','carlos.mendoza@empresa.com','Vendedor'),
('EMP002','María','López','0993322110','maria.lopez@empresa.com','Administradora'),
('EMP003','Javier','Suarez','0975544332','javier.suarez@empresa.com','Técnico'),
('EMP004','Fernanda','Pérez','0987766554','fernanda.perez@empresa.com','Vendedora');


CREATE TABLE ClientesFrecuentes (
    clienteID CHAR(10),
    vehiculoID CHAR(7),
    descuento DECIMAL(5,2),
    nivelCliente VARCHAR(20),
    frecuenciaCompra CHAR(3),
    PRIMARY KEY (clienteID, vehiculoID),
    FOREIGN KEY (clienteID) REFERENCES Clientes(clienteID),
    FOREIGN KEY (vehiculoID) REFERENCES Vehiculos(vehiculoID)
);

INSERT INTO ClientesFrecuentes VALUES
('1716410210','ABC1234',0.10,'Frecuente','MEN'),
('1710982348','XYZ5678',0.15,'Frecuente','TRI'),
('1716938210','PQR8910',0.20,'VIP','ANU');


CREATE TABLE facturas (
    facturanumero CHAR(10) PRIMARY KEY,
    fechafactura DATE,
    clienteID CHAR(10),
    empleadoID CHAR(10),
    total DECIMAL(15,2),
    FOREIGN KEY (clienteID) REFERENCES Clientes(clienteID),
    FOREIGN KEY (empleadoID) REFERENCES Empleados(empleadoID)
);

INSERT INTO facturas VALUES ('0000000001', '2024-12-10', '1716410210', 'EMP001', 16500.00);
INSERT INTO facturas VALUES ('0000000002', '2024-12-11', '1710982348', 'EMP002', 9200.00);
INSERT INTO facturas VALUES ('0000000003', '2024-12-12', '1755582348', 'EMP003', 28500.00);

SELECT * FROM facturas;


CREATE TABLE facturadetalle (
    facturanumero CHAR(10),
    vehiculoID CHAR(7),
    cantidad INT,
    precio DECIMAL(15,2),
    PRIMARY KEY (facturanumero, vehiculoID),
    CHECK (cantidad > 0),
    FOREIGN KEY (facturanumero) REFERENCES facturas(facturanumero),
    FOREIGN KEY (vehiculoID) REFERENCES Vehiculos(vehiculoID)
);

INSERT INTO facturadetalle VALUES ('0000000001', 'ABC1234', 1, 16500.00);
INSERT INTO facturadetalle VALUES ('0000000002', 'XYZ5678', 1, 9200.00);
INSERT INTO facturadetalle VALUES ('0000000003', 'PQR8910', 1, 28500.00);

SELECT * FROM facturadetalle;
