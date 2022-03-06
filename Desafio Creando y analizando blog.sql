--Desafío Creando y analizando nuestro propio blog - Hans Contreras

-- 1. Crear base de datos llamada blog.
-- ************************************
CREATE DATABASE blog;

-- 2. Crear las tablas indicadas de acuerdo al modelo de datos.
-- ************************************************************
CREATE TABLE usuario(
    id SERIAL PRIMARY KEY, 
    email VARCHAR(50) NOT NULL
);

CREATE TABLE post(
    id SERIAL PRIMARY KEY, 
    usuario_id SMALLINT, titulo VARCHAR(50), 
    fecha DATE NOT NULL, 
    FOREIGN KEY (usuario_id) 
    REFERENCES usuario(id)
);

CREATE TABLE comentario(
	id SERIAL PRIMARY KEY,
	post_id SMALLINT,
	usuario_id SMALLINT,
	texto VARCHAR(50),
	fecha DATE,
	FOREIGN KEY (post_id) REFERENCES post(id),
	FOREIGN KEY (usuario_id) REFERENCES usuario(id)
);

-- 3. Insertar los siguientes registros.
-- *************************************
INSERT INTO usuario (email) 
VALUES
('usuario01@hotmail.com'),
('usuario02@gmail.com'),
('usuario03@gmail.com'),
('usuario04@hotmail.com'),
('usuario05@yahoo.com'),
('usuario06@hotmail.com'),
('usuario07@yahoo.com'),
('usuario08@yahoo.com'),
('usuario09@yahoo.com');

SELECT * FROM usuario;

INSERT INTO post (usuario_id, titulo, fecha)
VALUES
(1,'Post 1: Esto es malo','2020-06-29'),
(5,'Post 2: Esto es malo','2020-06-20'),
(1,'Post 3: Esto es excelente','2020-05-30'),
(9,'Post 4: Esto es bueno','2020-05-09'),
(7,'Post 5: Esto es bueno','2020-07-10'),
(5,'Post 6: Esto es excelente','2020-07-18'),
(8,'Post 7: Esto es excelente','2020-07-07'),
(5,'Post 8: Esto es excelente','2020-05-14'),
(2,'Post 9: Esto es bueno','2020-05-08'),
(6,'Post 10: Esto es bueno','2020-06-02'),
(4,'Post 11: Esto es bueno','2020-05-05'),
(9,'Post 12: Esto es malo','2020-07-23'),
(5,'Post 13: Esto es excelente','2020-05-30'),
(8,'Post 14: Esto es excelente','2020-05-01'),
(7,'Post 15: Esto es malo','2020-06-17');

SELECT * FROM post;

INSERT INTO comentario (post_id, usuario_id, texto, fecha) 
VALUES
(6,3,'Este es el comentario 1','2020-07-08'),
(2,4,'Este es el comentario 2','2020-06-07'),
(4,6,'Este es el comentario 3','2020-06-16'),
(13,2,'Este es el comentario 4','2020-06-15'),
(6,6,'Este es el comentario 5','2020-05-14'),
(3,3,'Este es el comentario 6','2020-07-08'),
(1,6,'Este es el comentario 7','2020-05-22'),
(7,6,'Este es el comentario 8','2020-07-09'),
(13,8,'Este es el comentario 9','2020-06-30'),
(6,8,'Este es el comentario 10','2020-06-19'),
(1,5,'Este es el comentario 11','2020-05-09'),
(15,8,'Este es el comentario 12','2020-06-17'),
(9,1,'Este es el comentario 13','2020-05-01'),
(5,2,'Este es el comentario 14','2020-05-31'),
(3,4,'Este es el comentario 15','2020-06-28');

SELECT * FROM comentario;


-- 4. Seleccionar el correo, id y título de todos los post publicados por el usuario 5.
-- ************************************************************************************
SELECT email, post.id, titulo FROM post INNER JOIN usuario ON post.usuario_id = usuario.id WHERE usuario.id = 5;

-- 5. Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados por el usuario con email usuario06@hotmail.com.
-- ******************************************************************************************************************************************
SELECT email, comentario.id, post_id, texto, fecha FROM comentario INNER JOIN usuario 
ON comentario.usuario_id = usuario.id WHERE email !='usuario06@hotmail.com';

-- 6. Listar los usuarios que no han publicado ningún post.
-- ********************************************************
SELECT * FROM usuario LEFT JOIN post ON usuario.id = post.usuario_id WHERE post.usuario_id IS NULL;

-- 7. Listar todos los post con sus comentarios (incluyendo aquellos que no poseen comentarios).
-- *********************************************************************************************
SELECT * FROM post FULL OUTER JOIN comentario ON post.id = comentario.post_id;


-- 8. Listar todos los usuarios que hayan publicado un post en Junio.
-- ******************************************************************
SELECT * FROM usuario LEFT JOIN post ON usuario.id = post.usuario_id WHERE post.fecha::TEXT LIKE '2020-06-%';

SELECT * FROM usuario LEFT JOIN post ON usuario.id = post.usuario_id WHERE post.fecha BETWEEN '2020-06-01' AND '2020-06-30'