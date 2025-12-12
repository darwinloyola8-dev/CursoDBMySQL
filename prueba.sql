-- Crear base de datos
CREATE DATABASE saludtotal;
USE saludtotal;

-- Tabla medicinas
CREATE TABLE medicinas (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo CHAR(3),   -- GEN = genérico, COM = comercial
    precio DECIMAL(15,2),
    stock INT,
    fechacaducidad DATETIME
);

-- Insertar medicinas
INSERT INTO medicinas VALUES (1, 'Paracetamol', 'GEN', 1.50, 50, '2027-01-01 00:00:00');
INSERT INTO medicinas VALUES (2, 'Ibuprofeno', 'GEN', 2.00, 60, '2027-02-01 00:00:00');
INSERT INTO medicinas VALUES (3, 'Naproxeno', 'GEN', 1.80, 45, '2027-03-01 00:00:00');
INSERT INTO medicinas VALUES (4, 'Levotiroxina', 'GEN', 3.00, 70, '2027-04-01 00:00:00');
INSERT INTO medicinas VALUES (5, 'Insulina Glargina', 'GEN', 15.00, 30, '2027-05-01 00:00:00');
INSERT INTO medicinas VALUES (6, 'Amoxicilina', 'GEN', 1.20, 80, '2026-12-01 00:00:00');
INSERT INTO medicinas VALUES (7, 'Azitromicina', 'GEN', 3.50, 55, '2027-06-01 00:00:00');
INSERT INTO medicinas VALUES (8, 'Ciprofloxacino', 'GEN', 2.10, 40, '2027-07-01 00:00:00');
INSERT INTO medicinas VALUES (9,  'Finalín',   'COM', 2.50, 40, '2027-01-01 00:00:00');
INSERT INTO medicinas VALUES (10, 'Panadol',   'COM', 3.00, 35, '2027-02-01 00:00:00');
INSERT INTO medicinas VALUES (11, 'Tempra',    'COM', 2.80, 30, '2027-03-01 00:00:00');
INSERT INTO medicinas VALUES (12, 'Advil',     'COM', 4.20, 25, '2027-04-01 00:00:00');
INSERT INTO medicinas VALUES (13, 'Motrin',    'COM', 4.00, 20, '2027-05-01 00:00:00');
INSERT INTO medicinas VALUES (14, 'Aleve',     'COM', 3.50, 15, '2027-06-01 00:00:00');
INSERT INTO medicinas VALUES (15, 'Flanax',    'COM', 3.20, 18, '2027-07-01 00:00:00');
INSERT INTO medicinas VALUES (16, 'Eutirox',   'COM', 5.00, 22, '2027-08-01 00:00:00');
INSERT INTO medicinas VALUES (17, 'Lantus',    'COM', 35.00, 10, '2027-09-01 00:00:00');
INSERT INTO medicinas VALUES (18, 'Amoxil',    'COM', 2.50, 60, '2026-11-01 00:00:00');
INSERT INTO medicinas VALUES (19, 'Zithromax', 'COM', 6.80, 32, '2027-03-01 00:00:00');
INSERT INTO medicinas VALUES (20, 'Cipro',     'COM', 5.75, 28, '2027-04-01 00:00:00');

SELECT * FROM medicinas;

-- Tabla clientes
CREATE TABLE clientes (
    Cedula CHAR(10) PRIMARY KEY,
    nombre VARCHAR(100),
    FechaNacimiento DATE,
    tipo CHAR(3),
    email VARCHAR(100)
);

-- Insertar clientes
INSERT INTO clientes VALUES ('1716410210','Alisson Chiguano', '2004-05-24', 'JUR', 'alison.chiguano@gmail.com');
INSERT INTO clientes VALUES ('1710982348','Roger Tallana', '2001-02-04', 'NAT', 'roger.tallana@gmail.com');
INSERT INTO clientes VALUES ('1716938210','Erick Analuisa', '2005-06-02', 'JUR', 'erick.analuisa@gmail.com');
INSERT INTO clientes VALUES ('1716410320','Cristian Benites', '1997-05-24', 'JUR', 'cristian.benites@gmail.com');
INSERT INTO clientes VALUES ('1755582348','Antonio Valencia', '1991-02-04', 'NAT', 'antonio.valencia@gmail.com');
INSERT INTO clientes VALUES ('1716238210','Enner Valencia', '2001-02-02', 'JUR', 'enner.valencia@gmail.com');

SELECT * FROM clientes;

-- Tabla clientesFrecuentes
CREATE TABLE clientesFrecuentes (
    Cliente_Cedula CHAR(10),
    descuento DECIMAL(5,2),
    Enfermedad VARCHAR(100),
    Frecuencia CHAR(3),
    id_medicinas INT,
    PRIMARY KEY (id_medicinas, Cliente_Cedula),
    FOREIGN KEY (Cliente_Cedula) REFERENCES clientes(Cedula),
    FOREIGN KEY (id_medicinas) REFERENCES medicinas(id)
);

-- Insertar clientes frecuentes
INSERT INTO clientesFrecuentes VALUES ('1716410320', 0.10,'Diabetes','MEN', 6);
INSERT INTO clientesFrecuentes VALUES ('1716238210', 0.30,'Hipertension','MEN', 5);
INSERT INTO clientesFrecuentes VALUES ('1755582348', 0.50,'Hipertension','SEM', 4);

SELECT * FROM clientesFrecuentes;

-- Tabla equivalencia
CREATE TABLE equivalencia (
    id_generico INT,
    id_comercial INT,
    PRIMARY KEY (id_generico, id_comercial),
    FOREIGN KEY (id_generico)  REFERENCES medicinas(id),
    FOREIGN KEY (id_comercial) REFERENCES medicinas(id)
);

-- Insertar equivalencias
INSERT INTO equivalencia VALUES (1, 9);
INSERT INTO equivalencia VALUES (1, 10);
INSERT INTO equivalencia VALUES (1, 11);
INSERT INTO equivalencia VALUES (2, 12);
INSERT INTO equivalencia VALUES (2, 13);
INSERT INTO equivalencia VALUES (3, 14);
INSERT INTO equivalencia VALUES (3, 15);
INSERT INTO equivalencia VALUES (4, 16);
INSERT INTO equivalencia VALUES (5, 17);
INSERT INTO equivalencia VALUES (6, 18);
INSERT INTO equivalencia VALUES (7, 19);
INSERT INTO equivalencia VALUES (8, 20);

SELECT * FROM medicinas;
SELECT * FROM equivalencia;

-- Tabla facturas
CREATE TABLE facturas (
    facturanumero char (10),
    fechafactura date,
    cedula char(11),
    total decimal (15,2),
    PRIMARY KEY (facturanumero),
    FOREIGN KEY (cedula) REFERENCES clientes(Cedula)
);

-- Insertar facturas
INSERT INTO facturas VALUES ('0000000001', '2025-12-12','1716410210', 5.15);
INSERT INTO facturas VALUES ('0000000002', '2025-12-12','1710982348', 3.75);
INSERT INTO facturas VALUES ('0000000003', '2025-12-12','1716410210', 1.50);

SELECT * FROM facturas;

-- Tabla facturadetalle
CREATE TABLE facturadetalle (
    facturanumero char(10),
    medicamento_id int,
    CANTIDAD INT,
    PRECIO DECIMAL(15,3),
    PRIMARY KEY (facturanumero, medicamento_id),
    CHECK (cantidad > 0),
    FOREIGN KEY (facturanumero) REFERENCES facturas(facturanumero)
);

-- Insertar detalle de facturas
INSERT INTO facturadetalle VALUES ('0000000001', 3,12,2.75);
INSERT INTO facturadetalle VALUES ('0000000002', 3,1,5.75);
INSERT INTO facturadetalle VALUES ('0000000002', 2,2,3.50);
INSERT INTO facturadetalle VALUES ('0000000002', 4,4,4.50);
INSERT INTO facturadetalle VALUES ('0000000003', 2,2,3.50);

SELECT * FROM facturadetalle;


