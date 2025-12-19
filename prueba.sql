-- Crear base de datos


CREATE DATABASE saludtotal;
USE saludtotal;

-- Tabla medicinas
CREATE TABLE medicinas (
    id INT PRIMARY KEY,
    nombre VARCHAR(100),
    tipo CHAR(3)  DEFAULT 'GEN',
    precio DECIMAL(15,2),
    stock INT,
    fechacaducidad DATETIME
);
-- atributo nombre_medicina unico (UNIQUE)
 alter Table medicinas
 add CONSTRAINT medicina_nombre_uq
 unique (nombre);


 alter Table medicinas
 MODIFY COLUMN nombre varchar (100) NOT NULL;  


 alter table medicinas 
 add CONSTRAINT madicinas_tipo_val
 check (
    tipo in ('GEN', 'COM')
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
INSERT INTO medicinas (id, nombre, precio, stock, fechacaducidad) VALUES (21, 'holamundo', 5.6,10,'2023-04-01 00:00:00'); 


SELECT * FROM medicinas;



-- Tabla clientes
CREATE TABLE clientes (
    Cedula CHAR(10) PRIMARY KEY,
    nombre VARCHAR(100),
    FechaNacimiento DATE,
    tipo CHAR(3) DEFAULT 'OCA',
    email VARCHAR(100)
);

alter table clientes
add direccion varchar (100);
-- atributo correo unico (UNIQUE)
 alter Table clientes
 add CONSTRAINT cliente_email_uq
 unique (email);
-- Insertar clientes
INSERT INTO clientes VALUES ('1716410210','Alisson Chiguano', '2004-05-24', 'OCA', 'alison.chiguano@gmail.com', 'Quito');
INSERT INTO clientes VALUES ('1710982348','Roger Tallana', '2001-02-04', 'OCA', 'roger.tallana@gmail.com', 'Quito');
INSERT INTO clientes VALUES ('1716938210','Erick Analuisa', '2005-06-02', 'FRE', 'erick.analuisa@gmail.com', 'Quito');
INSERT INTO clientes VALUES ('1716410320','Cristian Benites', '1997-05-24', 'FRE', 'cristian.benites@gmail.com', 'Quito');
INSERT INTO clientes VALUES ('1755582348','Antonio Valencia', '1991-02-04', 'FRE', 'antonio.valencia@gmail.com', 'Quito');
INSERT INTO clientes VALUES ('1716238210','Enner Valencia', '2001-02-02', 'OCA', 'enner.valencia@gmail.com', 'Quito');

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


CREATE TABLE empresa(
    ruc char(13),
    razonsocial VARCHAR(100),
    direccion VARCHAR(100),
    telefono VARCHAR (14),
    email VARCHAR(25)
);

INSERT INTO empresa VALUES('1756209837001', 'Salud Total', 'Av. 10 de agosto s/a', '0980596412','alissonchiguano@gmail.com');

SELECT * FROM empresa;



-- Tabla facturas
CREATE TABLE facturas (
    facturanumero char (10),
    fechafactura date,
    cedula char(11),
    PRIMARY KEY (facturanumero),
    FOREIGN KEY (cedula) REFERENCES clientes(Cedula)
);

-- Insertar facturas
-- Facturas (usando cédulas existentes de clientes)
INSERT INTO facturas (facturanumero, fechafactura, cedula) VALUES
('0000000001', '2025-12-12', '1716410210'),
('0000000002', '2025-12-12', '1710982348'),
('0000000003', '2025-12-12', '1716410210'),
('0000000004', '2025-12-13', '1716938210'),
('0000000005', '2025-12-13', '1716410320'),
('0000000006', '2025-12-14', '1755582348'),
('0000000007', '2025-12-14', '1716238210'),
('0000000008', '2025-12-15', '1716410210'),
('0000000009', '2025-12-15', '1710982348'),
('0000000010', '2025-12-16', '1716938210'),
('0000000011', '2025-12-16', '1716410320'),
('0000000012', '2025-12-17', '1755582348'),
('0000000013', '2025-12-17', '1716238210'),
('0000000014', '2025-12-18', '1716410210'),
('0000000015', '2025-12-18', '1710982348'),
('0000000016', '2025-12-19', '1716938210'),
('0000000017', '2025-12-19', '1716410320'),
('0000000018', '2025-12-20', '1755582348'),
('0000000019', '2025-12-20', '1716238210'),
('0000000020', '2025-12-21', '1716410210'),
('0000000021', '2025-12-21', '1710982348'),
('0000000022', '2025-12-22', '1716938210'),
('0000000023', '2025-12-22', '1716410320'),
('0000000024', '2025-12-23', '1755582348'),
('0000000025', '2025-12-23', '1716238210'),
('0000000026', '2025-12-24', '1716410210'),
('0000000027', '2025-12-24', '1710982348'),
('0000000028', '2025-12-25', '1716938210'),
('0000000029', '2025-12-25', '1716410320'),
('0000000030', '2025-12-26', '1755582348'),
('0000000031', '2025-12-26', '1716238210'),
('0000000032', '2025-12-27', '1716410210'),
('0000000033', '2025-12-27', '1710982348'),
('0000000034', '2025-12-28', '1716938210'),
('0000000035', '2025-12-28', '1716410320'),
('0000000036', '2025-12-29', '1755582348'),
('0000000037', '2025-12-29', '1716238210'),
('0000000038', '2025-12-30', '1716410210'),
('0000000039', '2025-12-30', '1710982348'),
('0000000040', '2025-12-31', '1716938210'),
('0000000041', '2025-12-31', '1716410320'),
('0000000042', '2026-01-01', '1755582348'),
('0000000043', '2026-01-01', '1716238210'),
('0000000044', '2026-01-02', '1716410210'),
('0000000045', '2026-01-02', '1710982348'),
('0000000046', '2026-01-03', '1716938210'),
('0000000047', '2026-01-03', '1716410320'),
('0000000048', '2026-01-04', '1755582348'),
('0000000049', '2026-01-04', '1716238210'),
('0000000050', '2026-01-05', '1716410210');


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
INSERT INTO facturadetalle VALUES ('0000000001', 1, 3, 1.50);
INSERT INTO facturadetalle VALUES ('0000000001', 3, 2, 1.80);
INSERT INTO facturadetalle VALUES ('0000000002', 2, 1, 2.00);
INSERT INTO facturadetalle VALUES ('0000000002', 5, 1, 15.00);
INSERT INTO facturadetalle VALUES ('0000000003', 4, 2, 3.00);
INSERT INTO facturadetalle VALUES ('0000000003', 6, 3, 1.20);
INSERT INTO facturadetalle VALUES ('0000000004', 7, 1, 3.50);
INSERT INTO facturadetalle VALUES ('0000000004', 8, 2, 2.10);
INSERT INTO facturadetalle VALUES ('0000000005', 9, 2, 2.50);
INSERT INTO facturadetalle VALUES ('0000000005', 10, 1, 3.00);
INSERT INTO facturadetalle VALUES ('0000000006', 11, 1, 2.80);
INSERT INTO facturadetalle VALUES ('0000000006', 12, 2, 4.20);
INSERT INTO facturadetalle VALUES ('0000000007', 13, 1, 4.00);
INSERT INTO facturadetalle VALUES ('0000000007', 14, 1, 3.50);
INSERT INTO facturadetalle VALUES ('0000000008', 15, 2, 3.20);
INSERT INTO facturadetalle VALUES ('0000000008', 16, 1, 5.00);
INSERT INTO facturadetalle VALUES ('0000000009', 17, 1, 35.00);
INSERT INTO facturadetalle VALUES ('0000000010', 18, 2, 2.50);
INSERT INTO facturadetalle VALUES ('0000000010', 19, 1, 6.80);
INSERT INTO facturadetalle VALUES ('0000000011', 20, 2, 5.75);
INSERT INTO facturadetalle VALUES ('0000000012', 1, 1, 1.50);
INSERT INTO facturadetalle VALUES ('0000000013', 2, 3, 2.00);
INSERT INTO facturadetalle VALUES ('0000000014', 3, 1, 1.80);
INSERT INTO facturadetalle VALUES ('0000000015', 4, 2, 3.00);
INSERT INTO facturadetalle VALUES ('0000000016', 5, 1, 15.00);
INSERT INTO facturadetalle VALUES ('0000000017', 6, 2, 1.20);
INSERT INTO facturadetalle VALUES ('0000000018', 7, 1, 3.50);
INSERT INTO facturadetalle VALUES ('0000000019', 8, 2, 2.10);
INSERT INTO facturadetalle VALUES ('0000000020', 9, 1, 2.50);


SELECT * FROM facturadetalle;


-- TABLA PROVEEDOR
CREATE TABLE proveedor (
    ruc CHAR(13) PRIMARY KEY,
    nombre VARCHAR(100),
    contacto VARCHAR(100),
    email VARCHAR(100)
);


-- DATOS DE PROVEEDORES
INSERT INTO proveedor VALUES ('1700000000001', 'Bayer Ecuador', 'Luis Mayorga', 'mayorga@bayer.com');
INSERT INTO proveedor VALUES ('1700000000002', 'HealthCom', 'Andres Zotoz', 'soto@health.com');

SELECT * FROM proveedor;
-- TABLA PROVEEDOR_MEDICINAS
CREATE TABLE proveedor_medicinas (
    proveedor_ruc CHAR(13),
    medicina_id INT,
    proveedor_precio DECIMAL(10,2),
    lote INT,
    plazo INT

);

    -- CLAVE PRIMARIA (evita repetir proveedor con mismo precio)
ALTER table proveedor_medicinas
add PRIMARY KEY (proveedor_ruc, proveedor_precio);

    -- CLAVE FORÁNEA: proveedor debe existir

alter TABLE proveedor_medicinas
add CONSTRAINT proveedor_fk
FOREIGN KEY (proveedor_ruc)
REFERENCES proveedor(ruc);

    -- CLAVE FORÁNEA: medicina debe existir
alter TABLE proveedor_medicinas
add CONSTRAINT medicina_proveedor_fk
FOREIGN KEY (medicina_id)
REFERENCES medicinas(id);

INSERT INTO proveedor_medicinas VALUES ('1700000000001', 1, 0.25, 100, 15);
INSERT INTO proveedor_medicinas VALUES ('1700000000001', 2, 0.12, 200, 30);
INSERT INTO proveedor_medicinas VALUES ('1700000000001', 3, 0.32, 300, 7);
INSERT INTO proveedor_medicinas VALUES ('1700000000002', 2, 0.10, 800, 7);
INSERT INTO proveedor_medicinas VALUES ('1700000000002', 3, 0.30, 250, 7);

SELECT * FROM proveedor_medicinas;





