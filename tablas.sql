-- tabla SOCIOS
SELECT * FROM socios;
    rut    | nombre  | apellido |      direccion      | telefono  
-----------+---------+----------+---------------------+-----------
 1111111-1 | JUAN    | SOTO     | AVENIDA 1, SANTIAGO | 911111111
 2222222-2 | ANA     | PÉREZ    | PASAJE 2, SANTIAGO  | 922222222
 3333333-3 | SANDRA  | AGUILAR  | AVENIDA 2, SANTIAGO | 933333333
 4444444-4 | ESTEBAN | JEREZ    | AVENIDA 3, SANTIAGO | 944444444
 5555555-5 | SILVANA | MUÑOZ    | PASAJE 3, SANTIAGO  | 955555555
(5 rows)

-- tabla LIBROS
SELECT * FROM libros;
     isbn      |         titulo         | paginas 
---------------+------------------------+---------
 1111111111111 | CUENTOS DE TERROR      |     344
 2222222222222 | POESIAS CONTEMPORANEAS |     167
 3333333333333 | HISTORIA DE ASIA       |     511
 4444444444444 | MANUAL DE MECANICA     |     298
(4 rows)

-- tabla PRÉSTAMOS
SELECT * FROM prestamos;
 socio_id | libro_id | fecha_prestamo | fecha_devolucion 
----------+----------+----------------+------------------
(0 rows)

tabla AUTORES
SELECT * FROM autores;
 id | nombre | apellido | fecha_nacimiento | fecha_muerte 
----+--------+----------+------------------+--------------
  3 | JOSE   | SALGADO  | 1968-01-01       | 2020-01-01
  4 | ANA    | SALGADO  | 1972-01-01       | 
  1 | ANDRÉS | ULLOA    | 1982-01-01       | 
  2 | SERGIO | MARDONES | 1950-01-01       | 2012-01-01
  5 | MARTIN | PORTA    | 1976-01-01       | 
(5 rows)

tabla AUTORES_LIBROS
 SELECT * FROM autores_libros;
 libro_id | autor_id | tipo_autor_id 
----------+----------+---------------
(0 rows)

a. Mostrar todos los libros que posean menos de 300 páginas
SELECT * FROM libros WHERE paginas < 300;
     isbn      |         titulo         | paginas 
---------------+------------------------+---------
 2222222222222 | POESIAS CONTEMPORANEAS |     167
 4444444444444 | MANUAL DE MECANICA     |     298
(2 rows)

b. Mostrar todos los autores que hayan nacido despues del 01-01-1970
SELECT * FROM autores
WHERE fecha_nacimiento > '1970-01-01';
id | nombre | apellido | fecha_nacimiento | fecha_muerte 
----+--------+----------+------------------+--------------
  4 | ANA    | SALGADO  | 1972-01-01       | 
  1 | ANDRÉS | ULLOA    | 1982-01-01       | 
  5 | MARTIN | PORTA    | 1976-01-01       | 
(3 rows)

-- ¿Cuál es el libro más solicitado?--

libro_id | titulo | veces_solicitado 
----------+--------+------------------
(0 rows)

-- d. Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto debería pagar cada usuario que entregue el préstamo después de 7 días.
socio_id | nombre | apellido | dias_atraso | multa 
----------+--------+----------+-------------+-------
(0 rows)
