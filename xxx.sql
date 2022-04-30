\c claudia

-- 1.- Crear el modelo en una base de datos llamada xxx, considerando las tablas definidas y sus atributos. (2 puntos).

-- Primero se crea la base de datos
DROP DATABASE xxx;
CREATE DATABASE xxx;

-- Luego nos movemos hacia la base de datos creada
\c xxx

-- Se crea la tabla libros
CREATE TABLE libros(
  isbn VARCHAR(15) NOT NULL UNIQUE,
  titulo VARCHAR(100) NOT NULL,
  paginas INT NOT NULL,
  PRIMARY KEY (isbn)
);

-- Se crea la tabla socios
CREATE TABLE socios(
  rut VARCHAR(10) NOT NULL UNIQUE,
  nombre VARCHAR(20) NOT NULL,
  apellido VARCHAR(20) NOT NULL,
  direccion VARCHAR(50) NOT NULL,
  telefono VARCHAR(9) NOT NULL,
  PRIMARY KEY(rut)
);

-- Se crea la tabla préstamos
--La relación que existirá entre las entidades: SOCIOS y LIBROS se llama 'prestamos'
CREATE TABLE prestamos(
  socio_id VARCHAR,
  libro_id VARCHAR,
  fecha_prestamo DATE NOT NULL,
  fecha_devolucion DATE,
  FOREIGN KEY (socio_id) REFERENCES socios(rut),
  FOREIGN KEY (libro_id) REFERENCES libros(isbn)
);

-- Se crea la tabla autores
--La relación que existirá entre las entidades LIBROS con AUTORES DE LIBROS
CREATE TABLE autores(
  id INT NOT NULL UNIQUE,
  nombre VARCHAR(20) NOT NULL,
  apellido VARCHAR(20) NOT NULL,
  fecha_nacimiento DATE NOT NULL,
  fecha_muerte DATE,
  PRIMARY KEY(id)
);

-- Se crea la tabla tipos_autor
CREATE TABLE tipos_autor(
  id INT NOT NULL UNIQUE,
  tipo_autor VARCHAR(10) NOT NULL,
  PRIMARY KEY(id)
);

-- Se crea la tabla autores_libros
--La relación que existirá entre las entidades LIBROS y AUTORES 
CREATE TABLE autores_libros(
  libro_id VARCHAR,
  autor_id INT,
  tipo_autor_id INT,
  FOREIGN KEY (libro_id) REFERENCES libros(isbn),
  FOREIGN KEY (autor_id) REFERENCES autores(id),
  FOREIGN KEY (tipo_autor_id) REFERENCES tipos_autor(id)
);

-- 2. Se deben insertar los registros en las tablas correspondientes (1 punto).
-- Insertando datos en la tabla socios
--Insertar registros--

INSERT INTO socios (rut, nombre, apellido, direccion, telefono) VALUES ('1111111-1','JUAN','SOTO','AVENIDA 1, SANTIAGO ','911111111'),('2222222-2','ANA','PEREZ','PASAJE 2, SANTIAGO ','922222222'),('3333333-3','SANDRA','AGUILAR','AVENIDA 2, SANTIAGO','933333333'),('4444444-4','ESTEBAN','JEREZ','AVENIDA 3, SANTIAGO','944444444'),('5555555-5','SILVANA','MUNOZ','PASAJE 3, SANTIAGO ','955555555');
-- Verificando datos insertados
SELECT * FROM socios;

-- -- Insertando datos en la tabla libros

INSERT INTO libros (isbn, titulo, paginas) VALUES (1111111111111, 'CUENTOS DE TERROR', 344),(2222222222222, 'POESIAS CONTEMPORANEAS', 167),(3333333333333, 'HISTORIA DE ASIA', 511),(4444444444444, 'MANUAL DE MECANICA', 298);

-- Verificando datos insertados
SELECT * FROM libros;

-- -- Insertando datos en la tabla préstamos
INSERT INTO prestamos (socio_id, libro_id, fecha_prestamo, fecha_devolucion) VALUES ('1111111-1', '111-1111111-111', '20-01-2020', '27-01-2020'),('5555555-5', '222-2222222-222', '20-01-2020', '30-01-2020');('3333333-3', '333-3333333-333','22-01-2020', '30-01-2020'),('4444444-4', '444-4444444-444', '23-01-2020', '30-01-2020'),('2222222-2', '111-1111111-111','27-01-2020', '04-02-2020'),('1111111-1', '444-4444444-444', '31-01-2020', '12-02-2020'),('3333333-3', '222-2222222-222','31-01-2020', '12-02-2020');
-- Verificando datos insertados
SELECT * FROM prestamos;



-- -- Insertando datos en la tabla tipos_autor
INSERT INTO tipos_autor(id, tipo_autor)
VALUES(1, 'PRINCIPAL');


-- -- Insertando datos en la tabla autores
INSERT INTO autores(id, nombre, apellido, fecha_nacimiento, fecha_muerte)
VALUES(3, 'JOSE', 'SALGADO', '1968-01-01', '2020-01-01'),(4, 'ANA', 'SALGADO', '1972-01-01'),(1, 'ANDRÉS', 'ULLOA', '1982-01-01'),(2, 'SERGIO', 'MARDONES', '1950-01-01', '2012-01-01');(5, 'MARTIN', 'PORTA', '1976-01-01');
-- Verificando datos insertados
SELECT * FROM autores;

INSERT INTO tipos_autor(id, tipo_autor)
VALUES(2, 'COAUTOR');

-- Verificando datos insertados
SELECT * FROM tipos_autor;

-- -- Insertando datos en la tabla autores_libros
INSERT INTO autores_libros(libro_id, autor_id, tipo_autor_id)
VALUES('111-1111111-111', 3, 1),('111-1111111-111', 4, 2),('222-2222222-222', 1, 1),('333-3333333-333', 2, 1),('444-4444444-444', 5, 1);

-- Verificando datos insertados
SELECT * FROM autores_libros;


-- 3.- Realizar las siguientes consultas:
-- a. Mostrar todos los libros que posean menos de 300 páginas
SELECT * FROM libros
WHERE paginas < 300;

-- b. Mostrar todos los autores que hayan nacido despues del 01-01-1970
SELECT * FROM autores
WHERE fecha_nacimiento > '1970-01-01';

--¿Cuál es el libro más solicitado?--
--solicitud será el número de veces que ha sido prestado (cantidad de días prestados)--
--Asumiremos que es el número de veces que ha sido prestado, es posible que dos libros o más, puedan tener el mismo número de préstamos
SELECT prestamos.libro_id,
libros.titulo,
COUNT(libro_id) veces_solicitado
FROM libros
INNER JOIN prestamos 
ON prestamos.libro_id = libros.isbn
GROUP BY prestamos.libro_id, libros.titulo 
ORDER BY veces_solicitado DESC;

-- d. Si se cobrara una multa de $100 por cada día de atraso, mostrar cuánto debería pagar cada usuario que entregue el préstamo después de 7 días.

SELECT socio_id,
socios.nombre,
socios.apellido,
(fecha_devolucion - fecha_prestamo - 7) AS dias_atraso,
((fecha_devolucion - fecha_prestamo - 7) * 100) AS multa
FROM prestamos
INNER JOIN socios
ON socios.rut = prestamos.socio_id
WHERE (fecha_devolucion - fecha_prestamo) > 7;