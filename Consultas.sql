
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
     WHERE id = id_comercial) AS medicina_comercial,

    (SELECT precio 
     FROM medicinas 
     WHERE id = id_comercial) AS precio_comercial,

    (SELECT nombre 
     FROM medicinas 
     WHERE id = id_generico) AS medicina_generica,

    (SELECT precio 
     FROM medicinas 
     WHERE id = id_generico) AS precio_generico

FROM
    equivalencia;

