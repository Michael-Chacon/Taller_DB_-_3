-- gama
{
        INSERT INTO gama_producto VALUES (NULL,'Herbaceas','Plantas para jardin decorativas',NULL,NULL);
        INSERT INTO gama_producto VALUES (NULL,'Herramientas','Herramientas para todo tipo de acción',NULL,NULL);
        INSERT INTO gama_producto VALUES (NULL,'Aromáticas','Plantas aromáticas',NULL,NULL);
        INSERT INTO gama_producto VALUES (NULL,'Frutales','Árboles pequeños de producción frutal',NULL,NULL);
        INSERT INTO gama_producto VALUES (NULL,'Ornamentales','Plantas vistosas para la decoración del jardín',NULL,NULL);
}
-- pais
{
    INSERT INTO pais (nombre) VALUES ('USA');
    INSERT INTO pais (nombre) VALUES ('Spain');
    INSERT INTO pais (nombre) VALUES ('France');
    INSERT INTO pais (nombre) VALUES ('Australia');
    INSERT INTO pais (nombre) VALUES ('United Kingdom');
}
-- estado
{
    INSERT INTO estado (nombre_estado) VALUES ('Entregado');
    INSERT INTO estado (nombre_estado) VALUES ('Rechazado');
    INSERT INTO estado (nombre_estado) VALUES ('Pendiente');
}

-- region
{
    INSERT INTO region (id_region, nombre, codigo_pais) VALUES 
    (NULL, 'Comunidad Autónoma de Madrid', 2), 
    (NULL, 'Comunidad Autónoma de Cataluña', 2), (NULL, 'Floridad', 1),
    (NULL, 'Región de Île-de-France', 3), (NULL, 'Nueva Gales del Sur', 4), 
    (NULL, 'London', 5);
}

-- ciudad
{
    INSERT INTO ciudad (id_ciudad, nombre, codigo_region)
    VALUES (NULL, "Madrid", 1);

    INSERT INTO ciudad (id_ciudad, nombre, codigo_region)
    VALUES (NULL, "Fuenlabrada", 1);

    INSERT INTO ciudad (id_ciudad, nombre, codigo_region)
    VALUES (NULL, "Alcalá de Henares", 1);

    INSERT INTO ciudad (id_ciudad, nombre, codigo_region)
    VALUES (NULL, "Barcelona", 2);

    INSERT INTO ciudad (id_ciudad, nombre, codigo_region)
    VALUES (NULL, "Girona", 2);

    INSERT INTO ciudad (id_ciudad, nombre, codigo_region)
    VALUES (NULL, "París", 3);

    INSERT INTO ciudad (id_ciudad, nombre, codigo_region)
    VALUES (NULL, "Sídney", 4);

    INSERT INTO ciudad (id_ciudad, nombre, codigo_region)
    VALUES (NULL, "London", 5);
}
-- metodo pago
{
    INSERT INTO metodo_pago (nombre_metodo) VALUES ('PayPal');
    INSERT INTO metodo_pago (nombre_metodo) VALUES ('Transferencia');
    INSERT INTO metodo_pago (nombre_metodo) VALUES ('Cheque');
}
-- dimensiones
{
    INSERT INTO dimension (alto, ancho, largo)
    VALUES (2.5, 1.8, 0.7);  -- Insert 1: Small dimensions

    INSERT INTO dimension (alto, ancho, largo)
    VALUES (5.0, 3.0, 1.5);  -- Insert 2: Medium dimensions

    INSERT INTO dimension (alto, ancho, largo)
    VALUES (10.0, 8.0, 4.0);
}
-- puesto
{
    INSERT INTO cargo (nombre_cargo)
    VALUES ('Director General');

    INSERT INTO cargo (nombre_cargo)
    VALUES ('Subdirector Marketing');

    INSERT INTO cargo (nombre_cargo)
    VALUES ('Subdirector Ventas');

    INSERT INTO cargo (nombre_cargo)
    VALUES ('Secretaria');

    INSERT INTO cargo (nombre_cargo)
    VALUES ('Representante Ventas');

    INSERT INTO cargo (nombre_cargo)
    VALUES ('Director Oficina');
}

--tipo telefono
{
    INSERT INTO tipo_telefono (descripcion)
    VALUES ('Móvil');

    INSERT INTO tipo_telefono (descripcion)
    VALUES ('Fijo');

    INSERT INTO tipo_telefono (descripcion)
    VALUES ('Fax');
}

-- direccion
{
    INSERT INTO direccion (linea_direccion1, linea_direccion2, codigo_ciudad_d)
    VALUES ('Calle Mayor, 123', NULL, 1);

    INSERT INTO direccion (linea_direccion1, linea_direccion2, codigo_ciudad_d)
    VALUES ('Avenida de la Libertad, 456', 'Piso 3, Puerta 2', 2);

    INSERT INTO direccion (linea_direccion1, linea_direccion2, codigo_ciudad_d)
    VALUES ('Plaza de España, 789', NULL, 1);

    INSERT INTO direccion (linea_direccion1, linea_direccion2, codigo_ciudad_d)
    VALUES ('Paseo del Mar, 1011', NULL, 1);

    INSERT INTO direccion (linea_direccion1, linea_direccion2, codigo_ciudad_d)
    VALUES ('Calle del Sol, 1213', 'Urbanización Los Rosales', 2);

    INSERT INTO direccion (linea_direccion1, linea_direccion2, codigo_ciudad_d)
    VALUES ('Carrer de Ferran, 7', NULL, 4); -- Barcelona address

    INSERT INTO direccion (linea_direccion1, linea_direccion2, codigo_ciudad_d)
    VALUES ('Avinguda Diagonal, 500', 'Planta 12', 4); -- Barcelona address

    INSERT INTO direccion (linea_direccion1, linea_direccion2, codigo_ciudad_d)
    VALUES ('Plaça Reial, 10', NULL, 5); -- Barcelona address

    INSERT INTO direccion (linea_direccion1, linea_direccion2, codigo_ciudad_d)
    VALUES ('Carrer Ballesteries, 9', NULL, 2); -- Girona address

    INSERT INTO direccion (linea_direccion1, linea_direccion2, codigo_ciudad_d)
    VALUES ('Passeig Arqueològic, 2', NULL, 1); -- Girona address
}

-- proveedores
{
    INSERT INTO proveedor (nombre, codigo_direccion_p)
    VALUES ('Acme Corporation', 1);

    INSERT INTO proveedor (nombre, codigo_direccion_p)
    VALUES ('Global Tech Solutions', 5);

    INSERT INTO proveedor (nombre, codigo_direccion_p)
    VALUES ('Northwind Traders', 6);

    INSERT INTO proveedor (nombre, codigo_direccion_p)
    VALUES ('Exotic Imports', 10);
}

-- oficina
{
    INSERT INTO oficina (codigo_direccion_o)
    VALUES (1);

    INSERT INTO oficina (codigo_direccion_o)
    VALUES (2);

    INSERT INTO oficina (codigo_direccion_o)
    VALUES (7);

    INSERT INTO oficina (codigo_direccion_o)
    VALUES (10);
}

-- empleado
{
-- oficina madrid
    git 

}

Laura Hernández González
Carlos López Rodríguez
Sofía Pérez Martínez
Diego Ramírez López
Andrea García Fernández

SELECT  p.nombre AS 'pais', r.linea_direccion1,  c.nombre AS 'ciu'
FROM proveedor As p, direccion AS r, ciudad as c
WHERE p.codigo_direccion_p = r.id_direccion AND c.id_ciudad = r.codigo_ciudad_d;


