
use saludtotal

-- Consulta de base de datos
SELECT * FROM clientes;

-- Consulta de cuantos datos hay en las tablas escritas
SELECT COUNT (*) FROM medicinas;

SELECT COUNT (*) FROM clientes;

SELECT COUNT (*) FROM clientesfrecuentes;

-- consultar los datos de un cliente por su numero de cedula
-- Ejemplo : 0226722297

SELECT * 
from clientes 
where cedula = '0226722297' 

-- proyeccion: consultar el correo electronico de un cliente por su cedula

SELECT 
    email 
from clientes 
WHERE cedula = '0226722297'

SELECT 
    nombre,
    email 
from clientes 
WHERE cedula = '0226722297'



SELECT * 
from medicinas
where id = '9'


SELECT 
    nombre,
    precio
from medicinas
where id = '9'

-- Caso consultar todos los clientes cuyo nombre empiece por la letra (a)


SELECT 
    cedula,
    nombre
from clientes
WHERE nombre like 'A%' ; 


SELECT 
    id,
    nombre
from medicinas
WHERE nombre like 'F%' ;



SELECT 
    cedula,
    nombre
from clientes
WHERE nombre Like 'Alisson%' ;


SELECT 
    cedula,
    nombre,
    tipo
from clientes
WHERE 
    tipo = 'OCA' 
    AND
    nombre like 'J%'


SELECT 
    cedula,
    nombre
from clientes
WHERE nombre like '%Enner%'

SELECT 
    cedula,
    nombre,
    tipo,
    email
from clientes
WHERE     
    tipo = 'OCA' 
    AND
    email like '%gmail.com%'

SELECT 
    id,
    nombre,
    precio,
    tipo
from medicinas
WHERE     
    tipo = 'COM' 
    AND
    nombre like 'A%'

SELECT 
    id,
    nombre,
    precio,
    tipo
FROM medicinas
WHERE precio <= 10;


-- CONSULTAR LOS PACIENTES DE MEDICINA FRECUENTE EN UNA LISTA QUE INCLUYA: 
-- NOMBRE Y CEDULA DEL PACIENTE, NOMBRE E ID DE LA MEDICINA  Y EL DESCUENTO.

SELECT
    Cliente_Cedula AS Cedula,
    (SELECT nombre from clientes WHERE cedula = Cliente_Cedula) AS cliente,
    id_medicinas AS medicinas,
    (SELECT nombre from medicinas WHERE id = id_medicinas)AS nombremedicina,
    descuento
FROM
    clientesfrecuentes;

-- caso: LIstar los clientes y las medicinas que tiene unn descuento
--       menor al descuento del cliente con la cedula '1755582348' 

 SELECT
    Cliente_Cedula AS Cedula,
    (SELECT nombre from clientes WHERE cedula = Cliente_Cedula) AS cliente,
    id_medicinas AS medicinas,
    (SELECT nombre from medicinas WHERE id = id_medicinas) AS nombremedicina,
    descuento
FROM
    clientesfrecuentes
WHERE descuento < (
                 SELECT descuento
                 from clientesfrecuentes
                 WHERE Cliente_Cedula = '1755582348'
                );
    



-- Caso: Listado de pacientes del plan de clientes frecuente presente el precio final de la medicina
--       junto con el precio sin descuento 


SELECT
    Cliente_Cedula AS cedula,

    (SELECT nombre 
     FROM clientes
     WHERE cedula = Cliente_Cedula) AS paciente,

    id_medicinas AS id_medicinas,

    (SELECT nombre 
     FROM medicinas 
     WHERE id = id_medicinas) AS nombre_medicina,

    (SELECT precio
     FROM medicinas
     WHERE id = id_medicinas) AS precio_sin_descuento,

    descuento AS descuento_porcentaje,
      (
         select precio *(1- descuento) as precio_final
         from medicinas
         where id = id_medicinas
      ) AS precio_final
FROM
    clientesfrecuentes;

-- Caso: las medicinas comerciales pueden ser reemplazadas por sus correspondientes genericas.
--       Elaborar un listado que compare el precio de la medicina comercial con su equivalente generico

SELECT
    (SELECT nombre 
     FROM medicinas 
     WHERE id = id_comercial) AS Medicina_comercial,

    (SELECT precio 
     FROM medicinas 
     WHERE id = id_comercial) AS Precio_comercial,

    (SELECT nombre 
     FROM medicinas 
     WHERE id = id_generico) AS Medicina_generica,

    (SELECT precio 
     FROM medicinas 
     WHERE id = id_generico) AS Precio_generico,

    (
        (SELECT precio FROM medicinas WHERE id = id_comercial)
        -
        (SELECT precio FROM medicinas WHERE id = id_generico)
    ) AS Ahorro
FROM
    equivalencia;



--Uso de Join


-- Caso: Listado de pacientes del plan de clientes frecuente presente el precio final de la medicina
--       junto con el precio sin descuento 

SELECT
    clientesfrecuentes.Cliente_Cedula AS cedula,
    clientes.nombre AS paciente,
    clientesfrecuentes.id_medicinas AS id_medicinas,
    medicinas.nombre AS nombre_medicina,
    medicinas.precio AS precio_sin_descuento,
    clientesfrecuentes.descuento AS descuento_porcentaje,
    (medicinas.precio * (1 - clientesfrecuentes.descuento)) AS precio_final
FROM clientesfrecuentes
JOIN clientes
    ON clientes.cedula = clientesfrecuentes.Cliente_Cedula
JOIN medicinas
    ON medicinas.id = clientesfrecuentes.id_medicinas;


-- Caso: las medicinas comerciales pueden ser reemplazadas por sus correspondientes genericas.
--       Elaborar un listado que compare el precio de la medicina comercial con su equivalente generico


SELECT
    medicinas.nombre AS Medicina_comercial,
    medicinas.precio AS Precio_comercial,
    medicinas_generica.nombre AS Medicina_generica,
    medicinas_generica.precio AS Precio_generico,
    (medicinas.precio - medicinas_generica.precio) AS Ahorro
FROM equivalencia
JOIN medicinas
    ON medicinas.id = equivalencia.id_comercial
JOIN medicinas AS medicinas_generica
    ON medicinas_generica.id = equivalencia.id_generico;


-- Crear todas las combinaciones posibles entre la tacla cientes y clientesfrecuentes


SELECT *
from 
    clientes,
    clientesfrecuentes
WHERE 
    clientes.Cedula = clientesfrecuentes.Cliente_Cedula;


SELECT *
from 
    medicinas,
    clientesfrecuentes
WHERE 
    medicinas.id = clientesfrecuentes.id_medicinas;

SELECT 
    c.cedula,
    c.nombre,
    m.nombre,
    cf.descuento,
    m.tipo
from 
    clientes c,
    medicinas m,
    clientesfrecuentes cf
WHERE 
     m.id = cf.id_medicinas
    and c.Cedula = cf.Cliente_Cedula
    and m.tipo = 'COM'

SELECT * from clientesfrecuentes;


SELECT
    medicinas.nombre AS Medicina_comercial,
    medicinas.precio AS Precio_comercial,
    medicinas_generica.nombre AS Medicina_generica,
    medicinas_generica.precio AS Precio_generico,
    (medicinas.precio - medicinas_generica.precio) AS Ahorro
FROM equivalencia
JOIN medicinas
    ON medicinas.id = equivalencia.id_comercial
JOIN medicinas AS medicinas_generica
    ON medicinas_generica.id = equivalencia.id_generico;



--Caso: Presentar una factura y sus detalles, que incluya,  
--Los datos de la farmacia: nombre, ruc, ...  
--Los del cliente: ...  
--Los datos de la cabecera de la factura: numero, fecha  
--Las medicinas vendidas: nombre medicina, id, cant, precio, subtotal  
--Los datos al pie de la factura: Total y la forma de pago

-- 1. Carga de datos en facturas cabecera y detalles usar los datos ya existentes
-- 2. Select para cabera de factura
-- 3. Select para los detalles de factura
-- 4. Select para el pie factura.



SELECT 
    'FARMACIA SALUD TOTAL' titulo,
    razonsocial nombre_farmacia,
    ruc,
    direccion,
    telefono,
    email
FROM empresa;


SELECT 
    c.nombre nombre_cliente,
    c.cedula,
    c.direccion,
    c.telefono,
    c.correo,
    f.facturanumero numero_factura,
    f.fecha
FROM facturas f
JOIN clientes c ON f.cedula = c.cedula
WHERE f.facturanumero = '0000000002';
 

SELECT 
    m.nombre nombre_medicina,
    m.id id_medicina,
    fd.cantidad,
    fd.precio precio_unitario,
    (fd.cantidad * fd.precio) subtotal
FROM facturadetalle fd
JOIN medicinas m ON fd.medicamento_id = m.id
WHERE fd.facturanumero = '0000000001';



SELECT 
   SUM (fd.cantidad * fd.precio) subtotal,
   'Efectivo' forma_pago
FROM facturadetalle fd
JOIN medicinas m ON fd.medicamento_id = m.id
WHERE fd.facturanumero = '0000000001';



SELECT
    c.cedula,
    c.nombre,
    m.nombre,
    cf.descuento,
    m.tipo
FROM
    clientesFrecuentes cf
JOIN clientes c ON c.cedula = cf.Cliente_Cedula
JOIN medicinas m ON m.id = cf.id_medicinas
WHERE
    m.tipo = 'COM';
SELECT 
    id,
    nombre,
    precio
from medicinas
WHERE not precio > 5;
        


--- Consultar medicinas plan  clientes frecuentes

SELECT COUNT (*) FROM clientesfrecuentes;
SELECT COUNT (*) FROM medicinas;

SELECT
*
from medicinas
WHERE id not in 
(
    SELECT id_medicinas from clientesfrecuentes
);

SELECT
*
from medicinas m
join clientesfrecuentes cf on m.id = cf.id_medicinas;


SELECT
*
from clientesfrecuentes cf
left join medicinas m on m.id = cf.id_medicinas;


--Caso: Lista ordenada
--ascendente
SELECT
*
from clientes
ORDER BY FechaNacimiento;
--descendente
SELECT
*
from clientes
ORDER BY FechaNacimiento DESC;

SELECT 
 nombre,
 FechaNacimiento
from 
    clientes
ORDER BY 
    FechaNacimiento DESC 
LIMIT 1;

--Caso: Conocer las 5 medicinas mas caras de la farmacia

SELECT 
    nombre, 
    tipo, 
    precio
FROM medicinas
ORDER BY precio DESC
LIMIT 5;


--Caso: Conocer las 5 medicinas mas barata de la farmacia

SELECT 
    nombre, 
    tipo, 
    precio
FROM medicinas
ORDER BY precio
LIMIT 5;

--Caso: la medicina comercial mas barata

SELECT 
    nombre, 
    precio
FROM medicinas
WHERE tipo = 'COM'
ORDER BY precio 
LIMIT 1;


--Caso: la medicina generica mas cara

SELECT id, nombre, precio
FROM medicinas
WHERE tipo = 'GEN'
ORDER BY precio DESC
LIMIT 1;

--Caso: las 5 medicinas comerciales con el menor descuento

SELECT DISTINCT
    m.id,
    m.nombre,
    m.precio,
    cf.descuento
FROM clientesFrecuentes cf
JOIN medicinas m 
    ON m.id = cf.id_medicinas
WHERE m.tipo = 'COM'
  AND cf.descuento IS  NULL
ORDER BY cf.descuento DESC
LIMIT 5;

SELECT * from  clientesfrecuentes WHERE id_medicinas = 39;

insert into clientesfrecuentes  VALUES('7120942169',0.50,'Diabetes','MEN', 39)

SELECT * from medicinas
WHERE nombre like 'paracetamol%'


SELECT
    id,
    nombre,
    descuento
from clientesfrecuentes
WHERE id in 
(  
    SELECT 
        id
    from clientesfrecuentes
    JOIN medicinas on id = id_medicinas
    WHERE tipo = 'COM'
    ORDER BY descuento 
);


--Caso: Agrupamientos

SELECT 
tipo,
COUNT(*) as numero 
 FROM clientes
 GROUP BY 
 tipo;

SELECT 
id,
nombre,
precio,
stock,
precio * stock
from medicinas;

SELECT 
tipo, SUM(precio * stock) As Suma
from medicinas 
GROUP BY tipo;

--Caso: facturas detalle. Cual es valor monetario por medicina vendida

SELECT
    medicamento_id,
    cantidad,
    precio,
    cantidad * precio AS subtotal
FROM facturadetalle
ORDER BY medicamento_id;


SELECT
    fd.medicamento_id,
    SUM(fd.cantidad * fd.precio) AS total_vendido
FROM facturadetalle fd
join medicinas m on m.id = fd.medicamento_id
GROUP BY fd.medicamento_id
ORDER BY fd.medicamento_id;


SELECT
    fd.medicamento_id,
    m.nombre AS nombre_medicamento,
    fd.cantidad,
    fd.precio,
    fd.cantidad * fd.precio AS subtotal
FROM facturadetalle fd
JOIN medicinas m
    ON m.id = fd.medicamento_id
ORDER BY fd.medicamento_id;


--Caso: Encontrar el mejor cliente 

SELECT
    c.Cedula,
    c.nombre,
    SUM(fd.cantidad * fd.precio) AS total_comprado
FROM clientes c
JOIN facturas f
    ON c.Cedula = f.cedula
JOIN facturadetalle fd
    ON f.facturanumero = fd.facturanumero
GROUP BY
    c.Cedula,
    c.nombre
ORDER BY
    total_comprado DESC
LIMIT 1;

--Caso: Proyeccion de la venta total del stock, tomando en cuenta 
--      el descuento para las medicinas en el plan clientesfrecuentes

create VIEW v_proyeccion_ventas
AS
SELECT 
    cf.id_medicinas AS medicina_id,
    m.nombre,
    m.precio,
    m.stock,
    cf.descuento,
    m.precio * (1-cf.descuento) AS nuevo_precio
FROM clientesFrecuentes cf
JOIN medicinas m 
    ON m.id = cf.id_medicinas

UNION

SELECT 
    m.id AS medicina_id,
    m.nombre,
    m.precio,
    m.stock,
    0 AS descuento,
    m.precio AS nuevo_precio
FROM medicinas m
LEFT JOIN clientesFrecuentes cf
    ON m.id = cf.id_medicinas
WHERE cf.descuento IS NULL
;

SELECT 
   sum(nuevo_precio*stock) AS Suma
FROM
    v_proyeccion_ventas;



SELECT @@lc_time_names;

SET lc_time_names = 'es_ES';

SELECT DAYNAME('2025-12-24')


--Caso: Averiguar que medicinas vencen en el proximo mes

SELECT 
  id, nombre, tipo, precio, stock, DATE(fechacaducidad) AS fecha_vencimiento
FROM medicinas
WHERE DATE(fechacaducidad) < CURDATE()
ORDER BY fechacaducidad;



SELECT 
  DATE_FORMAT(fechacaducidad, '%Y-%m') AS mes,
  COUNT(*) AS total_medicinas
FROM medicinas
GROUP BY DATE_FORMAT(fechacaducidad, '%Y-%m')
ORDER BY mes;



SELECT 
  id, nombre, tipo, precio, stock, DATE(fechacaducidad) AS fecha_vencimiento
FROM medicinas
WHERE DATE(fechacaducidad) >= DATE_ADD(LAST_DAY(CURDATE()), INTERVAL 1 DAY)
  AND DATE(fechacaducidad) <= LAST_DAY(DATE_ADD(CURDATE(), INTERVAL 1 MONTH))

UNION

SELECT 
  id, nombre, tipo, precio, stock, DATE(fechacaducidad) AS fecha_vencimiento
FROM medicinas
WHERE DATE(fechacaducidad) >= CURDATE()
  AND DATE(fechacaducidad) < DATE_ADD(CURDATE(), INTERVAL 3 MONTH)

ORDER BY fecha_vencimiento;

UPDATE medicinas SET fechacaducidad = '2026-03-23 00:00:00' WHERE id =8


--VISTA MOVIMIENTOS DE VENTAS

CREATE OR REPLACE VIEW v_mov_ventas AS
SELECT
    f.fechafactura AS fecha,
    fd.medicamento_id,
    m.nombre AS medicina,
    f.facturanumero AS documento,
    'VENTA' AS tipo_mov,
    m.stock AS stock_actual,
    fd.cantidad AS salida
FROM facturadetalle fd
JOIN facturas f
    ON f.facturanumero = fd.facturanumero
JOIN medicinas m
    ON m.id = fd.medicamento_id;


--CONSULTA KARDEX / SALDO
--(SOLO VENTAS)

SELECT
    fecha,
    medicamento_id,
    tipo_mov,
    stock_actual,
    0 AS entrada,
    salida,

    stock_actual
    - SUM(salida) OVER (
        PARTITION BY medicamento_id
        ORDER BY fecha
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
      ) AS saldo
FROM v_mov_ventas
WHERE medicamento_id = 1
ORDER BY fecha;

SELECT 
    tipo,
    COUNT (*)
    from 
    medicinas
    WHERE
    precio < 5
    GROUP BY
    tipo;

SELECT * FROM medicinas WHERE precio < 5;



SELECT
    id,
    nombre,
    stock,
    20 AS stock_minimo,
    CASE
        WHEN stock <= 20 THEN 'REABASTECER'
        ELSE 'OK'
    END AS estado
FROM medicinas;

use saludtotal;
SELECT COUNT (*) from medicinas;
--Caso:stock minimo
CREATE table control_stock(
    id_medicinas INT,
    stock_minimo int
);

alter TABLE control_stock
add PRIMARY KEY (id_medicinas);

alter TABLE control_stock
add CONSTRAINT control_stock_id_medicinas_fk
Foreign Key (id_medicinas)
REFERENCES medicinas(id);

insert into control_stock
VALUES (36,6);

SELECT 
    fecha,
    medicamento_id,
    medicinas,
    tipo_mov,
    cantidad,
    saldo
FROM
v_kartex K
join control_stock cs on cs.id_medicina = k.medicamento_id
WHERE  
medicamento_id = 36
and saldo < stock_minimo;



