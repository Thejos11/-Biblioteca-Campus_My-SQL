# Consultas SQL - Biblioteca Campus

## 1. Consultas básicas

**Libros disponibles:**
```sql
SELECT id_libro, titulo, genero, isbn
FROM libros
WHERE disponibilidad = TRUE;
```

**Autores ordenados por apellido:**
```sql
SELECT id_autor, nombre, apellido, nacionalidad
FROM autores
ORDER BY apellido ASC;
```

**Buscar un libro por título (búsqueda parcial):**
```sql
SELECT id_libro, titulo, genero, isbn
FROM libros
WHERE titulo LIKE '%soledad%';
```

**Miembros registrados en 2024:**
```sql
SELECT id_miembro, nombres, apellidos, email, fecha_registro
FROM miembros
WHERE fecha_registro BETWEEN '2024-01-01' AND '2024-12-31';
```

**Préstamos aún no devueltos:**
```sql
SELECT id_prestamo, id_publicacion, id_miembro, fecha_prestamo, fecha_limite, estado
FROM prestamos
WHERE fecha_devolucion IS NULL;
```

---

## 2. Consultas con JOIN

**Libros junto con su(s) autor(es):**
```sql
SELECT l.titulo, a.nombre, a.apellido
FROM libros l
INNER JOIN libro_autor la ON la.id_libro = l.id_libro
INNER JOIN autores a       ON a.id_autor = la.id_autor
ORDER BY l.titulo;
```

**Publicaciones con datos del libro y de la editorial:**
```sql
SELECT p.id_publicacion, l.titulo, p.edicion, p.fecha_publicacion, e.nombre AS editorial
FROM publicaciones p
INNER JOIN libros l       ON l.id_libro = p.id_libro
INNER JOIN editoriales e  ON e.id_editorial = p.id_editorial
ORDER BY p.fecha_publicacion;
```

**Detalle completo de préstamos (miembro + libro + edición):**
```sql
SELECT
    pr.id_prestamo,
    m.nombres,
    m.apellidos,
    l.titulo,
    pub.edicion,
    pr.fecha_prestamo,
    pr.fecha_limite,
    pr.fecha_devolucion,
    pr.estado
FROM prestamos pr
INNER JOIN miembros m        ON m.id_miembro = pr.id_miembro
INNER JOIN publicaciones pub ON pub.id_publicacion = pr.id_publicacion
INNER JOIN libros l          ON l.id_libro = pub.id_libro
ORDER BY pr.fecha_prestamo;
```

**Préstamos atrasados con datos de contacto del miembro:**
```sql
SELECT m.nombres, m.apellidos, m.email, m.telefono, l.titulo, pr.fecha_limite
FROM prestamos pr
INNER JOIN miembros m        ON m.id_miembro = pr.id_miembro
INNER JOIN publicaciones pub ON pub.id_publicacion = pr.id_publicacion
INNER JOIN libros l          ON l.id_libro = pub.id_libro
WHERE pr.estado = 'atrasado';
```

**Libros sin ningún préstamo registrado (LEFT JOIN):**
```sql
SELECT l.id_libro, l.titulo
FROM libros l
LEFT JOIN publicaciones pub ON pub.id_libro = l.id_libro
LEFT JOIN prestamos pr      ON pr.id_publicacion = pub.id_publicacion
WHERE pr.id_prestamo IS NULL;
```

---

## 3. Consultas con funciones de agregación

**Cantidad de libros por género:**
```sql
SELECT genero, COUNT(*) AS total_libros
FROM libros
GROUP BY genero
ORDER BY total_libros DESC;
```

**Cantidad de libros escritos por cada autor:**
```sql
SELECT a.nombre, a.apellido, COUNT(la.id_libro) AS total_libros
FROM autores a
INNER JOIN libro_autor la ON la.id_autor = a.id_autor
GROUP BY a.id_autor, a.nombre, a.apellido
ORDER BY total_libros DESC;
```

**Cantidad de préstamos realizados por cada miembro:**
```sql
SELECT m.nombres, m.apellidos, COUNT(pr.id_prestamo) AS total_prestamos
FROM miembros m
LEFT JOIN prestamos pr ON pr.id_miembro = m.id_miembro
GROUP BY m.id_miembro, m.nombres, m.apellidos
ORDER BY total_prestamos DESC;
```

**Cantidad de publicaciones por editorial:**
```sql
SELECT e.nombre AS editorial, COUNT(p.id_publicacion) AS total_publicaciones
FROM editoriales e
LEFT JOIN publicaciones p ON p.id_editorial = e.id_editorial
GROUP BY e.id_editorial, e.nombre
ORDER BY total_publicaciones DESC;
```

**Promedio de páginas de las publicaciones registradas:**
```sql
SELECT ROUND(AVG(num_paginas), 0) AS promedio_paginas
FROM publicaciones;
```

**Distribución de préstamos por estado:**
```sql
SELECT estado, COUNT(*) AS cantidad
FROM prestamos
GROUP BY estado
ORDER BY cantidad DESC;
```

**Editoriales con más de una publicación (HAVING):**
```sql
SELECT e.nombre AS editorial, COUNT(p.id_publicacion) AS total_publicaciones
FROM editoriales e
INNER JOIN publicaciones p ON p.id_editorial = e.id_editorial
GROUP BY e.id_editorial, e.nombre
HAVING COUNT(p.id_publicacion) > 1;
```
