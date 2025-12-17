-- Consulta de base de datos
SELECT * FROM clientes;

-- Consulta de cuantos datos hay en las tablas escritas
SELECT COUNT (*) FROM medicinas;

SELECT COUNT (*) FROM clientes;

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

