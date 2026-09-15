-- =====================================================================
-- PROYECTO: Biblioteca Campus
-- ARCHIVO : db.sql
-- MOTOR   : MySQL / MariaDB (InnoDB, utf8mb4)
-- DESCRIP.: Script de creación de la base de datos y sus tablas
-- =====================================================================

DROP DATABASE IF EXISTS biblioteca_campus;
CREATE DATABASE biblioteca_campus
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE biblioteca_campus;

-- ---------------------------------------------------------------------
-- Tabla: autores
-- ---------------------------------------------------------------------
CREATE TABLE autores (
    id_autor          INT UNSIGNED AUTO_INCREMENT,
    nombre            VARCHAR(100)    NOT NULL,
    apellido          VARCHAR(100)    NOT NULL,
    nacionalidad      VARCHAR(80),
    fecha_nacimiento  DATE,
    creado_en         TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_autor),
    INDEX idx_autores_apellido (apellido)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Tabla: libros
-- ---------------------------------------------------------------------
CREATE TABLE libros (
    id_libro        INT UNSIGNED AUTO_INCREMENT,
    titulo          VARCHAR(200)    NOT NULL,
    genero          VARCHAR(80)     NOT NULL,
    isbn            VARCHAR(20)     NOT NULL,
    disponibilidad  BOOLEAN         NOT NULL DEFAULT TRUE,
    creado_en       TIMESTAMP       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id_libro),
    UNIQUE KEY uq_libros_isbn (isbn),
    INDEX idx_libros_titulo (titulo),
    INDEX idx_libros_genero (genero)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Tabla: libro_autor (tabla intermedia N:M entre libros y autores)
-- ---------------------------------------------------------------------
CREATE TABLE libro_autor (
    id_libro    INT UNSIGNED NOT NULL,
    id_autor    INT UNSIGNED NOT NULL,
    PRIMARY KEY (id_libro, id_autor),
    CONSTRAINT fk_libroautor_libro
        FOREIGN KEY (id_libro) REFERENCES libros(id_libro)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_libroautor_autor
        FOREIGN KEY (id_autor) REFERENCES autores(id_autor)
        ON DELETE CASCADE ON UPDATE CASCADE,
    INDEX idx_libroautor_autor (id_autor)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Tabla: editoriales
-- ---------------------------------------------------------------------
CREATE TABLE editoriales (
    id_editorial  INT UNSIGNED AUTO_INCREMENT,
    nombre        VARCHAR(150)  NOT NULL,
    pais          VARCHAR(80),
    contacto      VARCHAR(120),
    PRIMARY KEY (id_editorial),
    INDEX idx_editoriales_nombre (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Tabla: publicaciones (ediciones de un libro)
-- ---------------------------------------------------------------------
CREATE TABLE publicaciones (
    id_publicacion      INT UNSIGNED AUTO_INCREMENT,
    id_libro            INT UNSIGNED    NOT NULL,
    id_editorial        INT UNSIGNED    NOT NULL,
    edicion             VARCHAR(50)     NOT NULL,
    fecha_publicacion   DATE            NOT NULL,
    isbn_edicion        VARCHAR(20)     NOT NULL,
    num_paginas         SMALLINT UNSIGNED,
    PRIMARY KEY (id_publicacion),
    UNIQUE KEY uq_publicaciones_isbn_edicion (isbn_edicion),
    CONSTRAINT fk_publicaciones_libro
        FOREIGN KEY (id_libro) REFERENCES libros(id_libro)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_publicaciones_editorial
        FOREIGN KEY (id_editorial) REFERENCES editoriales(id_editorial)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX idx_publicaciones_libro (id_libro),
    INDEX idx_publicaciones_editorial (id_editorial),
    INDEX idx_publicaciones_fecha (fecha_publicacion)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Tabla: miembros
-- ---------------------------------------------------------------------
CREATE TABLE miembros (
    id_miembro      INT UNSIGNED AUTO_INCREMENT,
    nombres         VARCHAR(100)    NOT NULL,
    apellidos       VARCHAR(100)    NOT NULL,
    email           VARCHAR(150)    NOT NULL,
    telefono        VARCHAR(20),
    fecha_registro  DATE            NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY (id_miembro),
    UNIQUE KEY uq_miembros_email (email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Tabla: prestamos (transacciones de préstamo/devolución)
-- ---------------------------------------------------------------------
CREATE TABLE prestamos (
    id_prestamo         INT UNSIGNED AUTO_INCREMENT,
    id_publicacion      INT UNSIGNED    NOT NULL,
    id_miembro          INT UNSIGNED    NOT NULL,
    fecha_prestamo      DATE            NOT NULL,
    fecha_limite        DATE            NOT NULL,
    fecha_devolucion    DATE            NULL,
    estado              ENUM('prestado','devuelto','atrasado','perdido')
                                         NOT NULL DEFAULT 'prestado',
    PRIMARY KEY (id_prestamo),
    CONSTRAINT fk_prestamos_publicacion
        FOREIGN KEY (id_publicacion) REFERENCES publicaciones(id_publicacion)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_prestamos_miembro
        FOREIGN KEY (id_miembro) REFERENCES miembros(id_miembro)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX idx_prestamos_publicacion (id_publicacion),
    INDEX idx_prestamos_miembro (id_miembro),
    INDEX idx_prestamos_estado (estado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
