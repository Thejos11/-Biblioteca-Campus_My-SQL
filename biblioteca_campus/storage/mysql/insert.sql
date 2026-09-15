-- =====================================================================
-- PROYECTO: Biblioteca Campus
-- ARCHIVO : insert.sql
-- DESCRIP.: Datos de prueba (solo INSERT, con integridad referencial)
-- =====================================================================

USE biblioteca_campus;

-- ---------------------------------------------------------------------
-- autores
-- ---------------------------------------------------------------------
INSERT INTO autores (id_autor, nombre, apellido, nacionalidad, fecha_nacimiento) VALUES
(1, 'Gabriel', 'García Márquez', 'Colombiana', '1927-03-06'),
(2, 'Isabel',  'Allende',        'Chilena',    '1942-08-02'),
(3, 'Jorge',   'Luis Borges',    'Argentina',  '1899-08-24'),
(4, 'Mario',   'Vargas Llosa',   'Peruana',    '1936-03-28'),
(5, 'Julio',   'Cortázar',       'Argentina',  '1914-08-26'),
(6, 'Laura',   'Esquivel',       'Mexicana',   '1950-09-30');

-- ---------------------------------------------------------------------
-- libros
-- ---------------------------------------------------------------------
INSERT INTO libros (id_libro, titulo, genero, isbn, disponibilidad) VALUES
(1, 'Cien años de soledad',      'Realismo mágico', '978-0307474728', TRUE),
(2, 'La casa de los espíritus',  'Realismo mágico', '978-1501117015', TRUE),
(3, 'Ficciones',                 'Cuento',           '978-0802130303', TRUE),
(4, 'La ciudad y los perros',    'Novela',           '978-8420471860', FALSE),
(5, 'Rayuela',                   'Novela',           '978-8437604572', TRUE),
(6, 'Como agua para chocolate',  'Realismo mágico', '978-0385420174', TRUE);

-- ---------------------------------------------------------------------
-- libro_autor (relación N:M)
-- ---------------------------------------------------------------------
INSERT INTO libro_autor (id_libro, id_autor) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5),
(6, 6),
(1, 5);   -- ejemplo de libro con más de un autor asociado

-- ---------------------------------------------------------------------
-- editoriales
-- ---------------------------------------------------------------------
INSERT INTO editoriales (id_editorial, nombre, pais, contacto) VALUES
(1, 'Editorial Sudamericana',   'Argentina', 'contacto@sudamericana.com'),
(2, 'Penguin Random House',     'España',    'info@penguinrandomhouse.es'),
(3, 'Editorial Alfaguara',      'España',    'contacto@alfaguara.com'),
(4, 'Emecé Editores',           'Argentina', 'info@emece.com.ar'),
(5, 'Editorial Planeta',        'España',    'contacto@planeta.es');

-- ---------------------------------------------------------------------
-- publicaciones (ediciones)
-- ---------------------------------------------------------------------
INSERT INTO publicaciones (id_publicacion, id_libro, id_editorial, edicion, fecha_publicacion, isbn_edicion, num_paginas) VALUES
(1, 1, 1, '1ra edición',  '1967-05-30', '978-0307474728-A', 417),
(2, 2, 2, '2da edición',  '1982-01-01', '978-1501117015-A', 448),
(3, 3, 4, '1ra edición',  '1944-01-01', '978-0802130303-A', 174),
(4, 4, 3, '3ra edición',  '1963-01-01', '978-8420471860-A', 419),
(5, 5, 1, '1ra edición',  '1963-06-28', '978-8437604572-A', 736),
(6, 6, 5, '1ra edición',  '1989-01-01', '978-0385420174-A', 246);

-- ---------------------------------------------------------------------
-- miembros
-- ---------------------------------------------------------------------
INSERT INTO miembros (id_miembro, nombres, apellidos, email, telefono, fecha_registro) VALUES
(1, 'Ana',     'Torres',   'ana.torres@campus.edu',     '3001234567', '2024-02-10'),
(2, 'Carlos',  'Ramírez',  'carlos.ramirez@campus.edu', '3007654321', '2024-03-05'),
(3, 'Sofía',   'Gómez',    'sofia.gomez@campus.edu',    '3009876543', '2024-04-18'),
(4, 'Daniel',  'Pérez',    'daniel.perez@campus.edu',   '3012345678', '2024-05-22'),
(5, 'Valeria', 'López',    'valeria.lopez@campus.edu',  '3019876543', '2024-06-30'),
(6, 'Andrés',  'Martínez', 'andres.martinez@campus.edu','3021456789', '2024-07-14');

-- ---------------------------------------------------------------------
-- prestamos
-- ---------------------------------------------------------------------
INSERT INTO prestamos (id_prestamo, id_publicacion, id_miembro, fecha_prestamo, fecha_limite, fecha_devolucion, estado) VALUES
(1, 1, 1, '2025-01-10', '2025-01-24', '2025-01-20', 'devuelto'),
(2, 2, 2, '2025-02-05', '2025-02-19', NULL,          'prestado'),
(3, 3, 3, '2025-02-15', '2025-03-01', '2025-03-05',  'devuelto'),
(4, 4, 4, '2025-03-01', '2025-03-15', NULL,          'atrasado'),
(5, 5, 5, '2025-03-20', '2025-04-03', '2025-04-01',  'devuelto'),
(6, 6, 6, '2025-04-02', '2025-04-16', NULL,          'prestado');
