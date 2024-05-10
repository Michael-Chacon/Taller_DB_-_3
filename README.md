# Taller Nr 3

#### Los comando DDL están en el archivo llamado DDL.sql

#### Los comandos DML están en el archivo llamado DML.sql

## DER

![](https://github.com/Michael-Chacon/Taller_DB_-_3/blob/main/DER%20end.png?raw=true)

### Tablas

```
+---------------------+
| Tables_in_gardening |
+---------------------+
| cargo               |
| ciudad              |
| cliente             |
| contacto            |
| detalle_pedido      |
| dimension           |
| direccion           |
| empleado            |
| estado              |
| gama_producto       |
| metodo_pago         |
| oficina             |
| pago                |
| pais                |
| pedido              |
| producto            |
| proveedor           |
| proveedor_producto  |
| region              |
| telefono            |
| tipo_telefono       |
+---------------------+
```

## Formas normales 

#### 1NF

Apliqué la primera forma normal a todas las tablas, debido a que coloque una llave primaria auto incremental a todas, ya que no tenían.

#### 2NF

La segunda forma normal la aplique a las  tablas **cliente**, **producto** y **oficina**, ya que esta tablas tenían datos que se repetían en cada una, así que cree nuevas tablas, por ejemplo, la tabla país, región, ciudad, teléfono y dirección.

#### 3NF

La tercera forma normal la apliqué en la tabla **pedido**, dicha tabla tenia un campo llamado estado, dicho estado no dependía de la llave principal de dicha tabla, así que cree una tabla llamada **estado**, para hacer referencia al estado del pedido. También apliqué esta forma en la tabla **empleado**, creando una nueva tabla para almacenar todos los **cargos**.

#### 4NF

Creé una tabla intermedia para la relación proveedor y producto, dicha tabla se llama proveedor_producto



## Consultas

1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.

   ```sql
   SELECT o.id_oficina, c.nombre
   FROM oficina AS o
   INNER JOIN direccion AS d ON d.id_direccion = o.codigo_direccion_o
   INNER JOIN ciudad AS c ON c.id_ciudad = d.codigo_ciudad_d;
   +------------+-------------+
   | id_oficina | nombre      |
   +------------+-------------+
   |          1 | Madrid      |
   |          2 | Fuenlabrada |
   |          3 | Barcelona   |
   |          4 | Madrid      |
   +------------+-------------+
   ```

2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.

   ```sql
   SELECT c.nombre, t.numero
   FROM telefono AS t
   INNER JOIN oficina AS o ON t.codigo_oficina_te = o.id_oficina
   INNER JOIN direccion AS d ON o.codigo_direccion_o = d.id_direccion 
   INNER JOIN ciudad AS c ON d.codigo_ciudad_d = c.id_ciudad
   INNER JOIN region AS r ON r.id_region = c.codigo_region
   INNER JOIN pais AS p ON p.id_pais = r.codigo_pais
   WHERE p.id_pais = 2;
   +-------------+------------+
   | nombre      | numero     |
   +-------------+------------+
   | Madrid      | 3123456789 |
   | Madrid      | 5712345678 |
   | Fuenlabrada | 4123456789 |
   +-------------+------------+
   ```

3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo
    jefe tiene un código de jefe igual a 2.

  ```sql
  SELECT nombre_empleado, apellido1, apellido2, email
  FROM empleado
  WHERE id_jefe = 2;
  +-----------------+-----------+-----------+---------------------------+
  | nombre_empleado | apellido1 | apellido2 | email                     |
  +-----------------+-----------+-----------+---------------------------+
  | Pedro           | Romero    | Sánchez   | pedro.romero@empresa.com  |
  | Ana             | Martínez  | Fernández | ana.martinez@empresa.com  |
  | José            | Cala      | Marin     | jose.martinez@empresa.com |
  +-----------------+-----------+-----------+---------------------------+
  ```

4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la
    empresa.

  ```sql
  SELECT c.nombre_cargo, e.nombre_empleado, e.apellido1, e.apellido2, e.email
  FROM empleado AS e, cargo as c
  WHERE  id_empleado = 1 AND c.id_cargo = e.codigo_cargo;
  +------------------+-----------------+-----------+-----------+--------------------------+
  | nombre_cargo     | nombre_empleado | apellido1 | apellido2 | email                    |
  +------------------+-----------------+-----------+-----------+--------------------------+
  | Director General | María           | García    | López     | maria.garcia@empresa.com |
  +------------------+-----------------+-----------+-----------+--------------------------+
  ```

5. Devuelve un listado con el nombre, apellidos y puesto de aquellos
    empleados que no sean representantes de ventas.

  ```sql
  SELECT c.nombre_cargo, e.nombre_empleado, e.apellido1, e.apellido2
  FROM empleado AS e, cargo as c
  WHERE e.codigo_cargo = c.id_cargo AND e.codigo_cargo != 5;
  +------------------+-----------------+-----------+-----------+
  | nombre_cargo     | nombre_empleado | apellido1 | apellido2 |
  +------------------+-----------------+-----------+-----------+
  | Director General | María           | García    | López     |
  | Director General | Edwind          | Hernandez | NULL      |
  | Director Oficina | Juan            | Pérez     | Gómez     |
  | Director Oficina | Laura           | González  | NULL      |
  +------------------+-----------------+-----------+-----------+
  ```

6. Devuelve un listado con el nombre de los todos los clientes españoles.

   ```sql
   SELECT c.nombre_cliente
   FROM cliente AS c 
   INNER JOIN ciudad AS ci ON ci.id_ciudad = c.codigo_ciudad_c
   INNER JOIN region AS r ON r.id_region = ci.codigo_region
   INNER JOIN pais AS p ON p.id_pais = r.codigo_pais  
   WHERE p.id_pais = 2;
   +-------------------+
   | nombre_cliente    |
   +-------------------+
   | Roberto Martínez  |
   | Alejandra López   |
   | Fernando Sánchez  |
   | Isabel Gutiérrez  |
   | Gabriel Rodríguez |
   | Verónica Pérez    |
   | Marina Fernández  |
   | Andrés Ramírez    |
   +-------------------+
   ```

7. Devuelve un listado con los distintos estados por los que puede pasar un
    pedido.

  ```sql
  SELECT nombre_estado FROM estado;
  +---------------+
  | nombre_estado |
  +---------------+
  | Entregado     |
  | Rechazado     |
  | Pendiente     |    |
  +---------------+
  ```

8. Devuelve un listado con el código de cliente de aquellos clientes que
    realizaron algún pago en 2008. Tenga en cuenta que deberá eliminar
    aquellos códigos de cliente que aparezcan repetidos. Resuelva la consulta:
    • Utilizando la función YEAR de MySQL.
    • Utilizando la función DATE_FORMAT de MySQL.
    • Sin utilizar ninguna de las funciones anteriores.

  ```SQL 
  SELECT DISTINCT c.id_cliente AS 'cliente' 
  FROM pago AS p, cliente AS c
  WHERE c.id_cliente = p.codigo_cliente_pa AND YEAR(p.fecha_pago) = 2008;
  --
  SELECT DISTINCT c.id_cliente AS 'cliente' 
  FROM pago AS p, cliente AS c
  WHERE c.id_cliente = p.codigo_cliente_pa AND DATE_FORMAT(p.fecha_pago, '%Y') = 2008;
  --
  SELECT DISTINCT c.id_cliente AS 'cliente' 
  FROM pago AS p, cliente AS c
  WHERE c.id_cliente = p.codigo_cliente_pa AND SUBSTRING(p.fecha_pago, 1, 4) = 2008;
  +---------+
  | cliente |
  +---------+
  |       1 |
  |       3 |
  +---------+
  ```

9. Devuelve un listado con el código de pedido, código de cliente, fecha
    esperada y fecha de entrega de los pedidos que no han sido entregados a
    tiempo.

  ```sql
  SELECT p.id_pedido, c.id_cliente, p.fecha_esperado, p.fecha_entrega 
  FROM cliente AS c, pedido AS p
  WHERE c.id_cliente = p.codigo_client_pedido AND p.fecha_entrega <= p.fecha_esperado;
  +-----------+------------+----------------+---------------+
  | id_pedido | id_cliente | fecha_esperado | fecha_entrega |
  +-----------+------------+----------------+---------------+
  |         1 |          1 | 2024-04-05     | 2024-04-03    |
  |         3 |          1 | 2024-04-07     | 2024-04-05    |
  |         5 |          3 | 2024-04-09     | 2024-04-05    |
  |         7 |          3 | 2024-04-11     | 2024-04-11    |
  |         8 |          3 | 2024-04-12     | 2024-04-05    |
  |         9 |          2 | 2024-04-13     | 2024-04-04    |
  +-----------+------------+----------------+---------------+
  ```

10. Devuelve un listado con el código de pedido, código de cliente, fecha
    esperada y fecha de entrega de los pedidos cuya fecha de entrega ha sido al
    menos dos días antes de la fecha esperada.
    • Utilizando la función ADDDATE de MySQL.
    • Utilizando la función DATEDIFF de MySQL.
    • ¿Sería posible resolver esta consulta utilizando el operador de suma + o
    resta -?

    ```sql
    SELECT p.id_pedido, c.id_cliente, p.fecha_esperado, p.fecha_entrega 
    FROM cliente AS c, pedido AS p
    WHERE c.id_cliente = p.codigo_client_pedido AND p.fecha_entrega <= ADDDATE(p.fecha_esperado, -2);
    
    SELECT p.id_pedido, c.id_cliente, p.fecha_esperado, p.fecha_entrega 
    FROM cliente AS c, pedido AS p
    WHERE c.id_cliente = p.codigo_client_pedido AND  DATEDIFF(p.fecha_esperado, p.fecha_entrega) >= 2;
    Si se puede utilizando el operador de suma + o resta -
    +-----------+------------+----------------+---------------+
    | id_pedido | id_cliente | fecha_esperado | fecha_entrega |
    +-----------+------------+----------------+---------------+
    |         1 |          1 | 2024-04-05     | 2024-04-03    |
    |         3 |          1 | 2024-04-07     | 2024-04-05    |
    |         5 |          3 | 2024-04-09     | 2024-04-05    |
    |         8 |          3 | 2024-04-12     | 2024-04-05    |
    |         9 |          2 | 2024-04-13     | 2024-04-04    |
    +-----------+------------+----------------+---------------+
    
    ```

11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.

    ```sql
    SELECT id_pedido,fecha_pedido, fecha_esperado, fecha_entrega, codigo_client_pedido,codigo_estado_pedido
    FROM pedido 
    WHERE YEAR(fecha_pedido) = 2009 AND codigo_estado_pedido = 2;
    Empty set (0.00 sec)
    ```

12. Devuelve un listado de todos los pedidos que han sido entregados en el
    mes de enero de cualquier año.

    ```sql
    SELECT id_pedido,fecha_pedido, fecha_esperado, fecha_entrega, codigo_client_pedido,codigo_estado_pedido
    FROM pedido 
    WHERE MONTH(fecha_entrega) = 01;
    Empty set (0.00 sec)
    ```

13. Devuelve un listado con todos los pagos que se realizaron en el
    año 2008 mediante Paypal. Ordene el resultado de mayor a menor.

    ```sql
    SELECT  id_pago, fecha_pago, total, codigo_metodo_pago, codigo_cliente_pa
    FROM pago
    WHERE YEAR(fecha_pago) = 2008 AND codigo_metodo_pago = 1;
    +---------+------------+-------+--------------------+-------------------+
    | id_pago | fecha_pago | total | codigo_metodo_pago | codigo_cliente_pa |
    +---------+------------+-------+--------------------+-------------------+
    |       6 | 2008-04-01 |   150 |                  1 |                 1 |
    +---------+------------+-------+--------------------+-------------------+
    ```

14. Devuelve un listado con todas las formas de pago que aparecen en la
    tabla pago. Tenga en cuenta que no deben aparecer formas de pago
    repetidas.

    ```sql
    SELECT id_metodo_pago, nombre_metodo
    FROM metodo_pago;
    +----------------+---------------+
    | id_metodo_pago | nombre_metodo |
    +----------------+---------------+
    |              1 | PayPal        |
    |              2 | Transferencia |
    |              3 | Cheque        |
    +----------------+---------------+
    ```

15. Devuelve un listado con todos los productos que pertenecen a la
    gama Ornamentales y que tienen más de 30 unidades en stock. El listado
    deberá estar ordenado por su precio de venta, mostrando en primer lugar
    los de mayor precio.

    ```sql
    SELECT  p.id_producto, p.nombre, p.cantidad_stock, p.precio_venta
    FROM producto AS p
    INNER JOIN gama_producto AS g ON g.id_gama = p.codigo_gama
    WHERE g.nombre = 'Ornamentales' AND p.cantidad_stock > 15
    ORDER BY p.precio_venta DESC;
    +-------------+-----------------------+----------------+--------------+
    | id_producto | nombre                | cantidad_stock | precio_venta |
    +-------------+-----------------------+----------------+--------------+
    |          19 | Orquídea Phalaenopsis |             20 |         8.99 |
    |          16 | Lirio Blanco          |             25 |         4.49 |
    |          17 | Begonia Escarlata     |             18 |         3.79 |
    +-------------+-----------------------+----------------+--------------+
    ```

16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y
    cuyo representante de ventas tenga el código de empleado 3 o 4 .

    ```sql
    SELECT id_cliente, nombre_cliente, limite_credito, codigo_ciudad_c, codigo_direccion_c, codigo_empleado_rep_ventas
    FROM cliente AS c 
    INNER JOIN empleado AS e ON e.id_empleado = c.codigo_empleado_rep_ventas
    WHERE c.codigo_ciudad_c = 1 AND c.codigo_empleado_rep_ventas IN (3, 4);
    +------------+------------------+----------------+-----------------+--------------------+----------------------------+
    | id_cliente | nombre_cliente   | limite_credito | codigo_ciudad_c | codigo_direccion_c | codigo_empleado_rep_ventas |
    +------------+------------------+----------------+-----------------+--------------------+----------------------------+
    |          1 | Roberto Martínez |           5000 |               1 |                 10 |                          3 |
    |          2 | Alejandra López  |           8000 |               1 |                  4 |                          4 |
    |          3 | Fernando Sánchez |          10000 |               1 |                  3 |                          4 |
    +------------+------------------+----------------+-----------------+--------------------+----------------------------+
    ```

    

## Consultas multitabla (Composición interna)

##### Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con

sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.

1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su
    representante de ventas.

  ```sql
  SELECT c.nombre_cliente, e.nombre_empleado, e.apellido1
  FROM cliente AS c
  INNER JOIN empleado AS e ON e.id_empleado = c.codigo_empleado_rep_ventas;
  +-------------------+-----------------+-----------+
  | nombre_cliente    | nombre_empleado | apellido1 |
  +-------------------+-----------------+-----------+
  | Roberto Martínez  | Pedro           | Romero    |
  | Alejandra López   | Ana             | Martínez  |
  | Fernando Sánchez  | Ana             | Martínez  |
  | Isabel Gutiérrez  | Andrea          | García    |
  | Gabriel Rodríguez | Sofía           | Pérez     |
  | Verónica Pérez    | Sofía           | Pérez     |
  +-------------------+-----------------+-----------+
  ```

  

2. Muestra el nombre de los clientes que hayan realizado pagos junto con el
    nombre de sus representantes de ventas.

  ```sql
  SELECT DISTINCT c.id_cliente, c.nombre_cliente, e.nombre_empleado
  FROM cliente AS c
  INNER JOIN pago AS p ON p.codigo_cliente_pa = c.id_cliente
  INNER JOIN empleado as e ON e.id_empleado = c.codigo_empleado_rep_ventas;
  +------------+------------------+-----------------+
  | id_cliente | nombre_cliente   | nombre_empleado |
  +------------+------------------+-----------------+
  |          1 | Roberto Martínez | Pedro           |
  |          2 | Alejandra López  | Ana             |
  |          3 | Fernando Sánchez | Ana             |
  +------------+------------------+-----------------+
  ```

  

3. Muestra el nombre de los clientes que no hayan realizado pagos junto con
    el nombre de sus representantes de ventas.

  ```sql
  SELECT c.nombre_cliente, e.nombre_empleado 
  FROM cliente c 
  LEFT JOIN pago p ON p.codigo_cliente_pa = c.id_cliente
  INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.id_empleado
  WHERE p.id_pago IS NULL;
  +------------+-------------------+-----------------+
  | id_cliente | nombre_cliente    | nombre_empleado |
  +------------+-------------------+-----------------+
  |          4 | Isabel Gutiérrez  | Andrea          |
  |          5 | Gabriel Rodríguez | Sofía           |
  |          6 | Verónica Pérez    | Sofía           |
  +------------+-------------------+-----------------+
  ```

  

4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus
    representantes junto con la ciudad de la oficina a la que pertenece el
    representante.

  ```sql
  SELECT DISTINCT c.nombre_cliente, e.nombre_empleado, ci.nombre
  FROM cliente AS c
  INNER JOIN pago AS p ON p.codigo_cliente_pa = c.id_cliente
  INNER JOIN empleado as e ON e.id_empleado = c.codigo_empleado_rep_ventas
  INNER JOIN oficina AS o ON o.id_oficina = e.codigo_oficina
  INNER JOIN direccion AS d ON d.id_direccion = o.codigo_direccion_o
  INNER JOIN ciudad As ci ON ci.id_ciudad = d.codigo_ciudad_d;
  +------------------+-----------------+--------+
  | nombre_cliente   | nombre_empleado | nombre |
  +------------------+-----------------+--------+
  | Roberto Martínez | Pedro           | Madrid |
  | Alejandra López  | Ana             | Madrid |
  | Fernando Sánchez | Ana             | Madrid |
  +------------------+-----------------+--------+
  ```

  

5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre
    de sus representantes junto con la ciudad de la oficina a la que pertenece el
    representante.

  ```sql
  SELECT DISTINCT c.nombre_cliente, e.nombre_empleado, ci.nombre
  FROM cliente AS c
  INNER JOIN empleado as e ON e.id_empleado = c.codigo_empleado_rep_ventas
  INNER JOIN oficina AS o ON o.id_oficina = e.codigo_oficina
  INNER JOIN direccion AS d ON d.id_direccion = o.codigo_direccion_o
  INNER JOIN ciudad As ci ON ci.id_ciudad = d.codigo_ciudad_d
  WHERE c.id_cliente NOT IN (
      SELECT codigo_cliente_pa
      FROM pago
  );
  
  +-------------------+-----------------+-------------+
  | nombre_cliente    | nombre_empleado | nombre      |
  +-------------------+-----------------+-------------+
  | Gabriel Rodríguez | Sofía           | Fuenlabrada |
  | Verónica Pérez    | Sofía           | Fuenlabrada |
  | Isabel Gutiérrez  | Andrea          | Fuenlabrada |
  +-------------------+-----------------+-------------+
  ```

6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.

   ```sql
   SELECT DISTINCT d.linea_direccion1, d.linea_direccion2
   FROM cliente AS c
   INNER JOIN empleado AS e ON e.id_empleado = c.codigo_empleado_rep_ventas
   INNER JOIN oficina AS o ON o.id_oficina = e.codigo_oficina
   INNER JOIN direccion AS d ON d.id_direccion = o.codigo_direccion_o
   WHERE c.codigo_ciudad_c = 2; 
   +-----------------------------+------------------+
   | linea_direccion1            | linea_direccion2 |
   +-----------------------------+------------------+
   | Avenida de la Libertad, 456 | Piso 3, Puerta 2 |
   +-----------------------------+------------------+
   ```

7. Devuelve el nombre de los clientes y el nombre de sus representantes junto
    con la ciudad de la oficina a la que pertenece el representante.

  ```sql
  SELECT c.nombre_cliente, e.nombre_empleado, ci.nombre
  FROM cliente AS c
  INNER JOIN empleado AS e ON e.id_empleado = c.codigo_empleado_rep_ventas
  INNER JOIN oficina AS o ON o.id_oficina = e.codigo_oficina
  INNER JOIN direccion AS d ON d.id_direccion = o.codigo_direccion_o
  INNER JOIN ciudad As ci ON ci.id_ciudad = d.codigo_ciudad_d;
  +-------------------+-----------------+-------------+
  | nombre_cliente    | nombre_empleado | nombre      |
  +-------------------+-----------------+-------------+
  | Roberto Martínez  | Pedro           | Madrid      |
  | Alejandra López   | Ana             | Madrid      |
  | Fernando Sánchez  | Ana             | Madrid      |
  | Gabriel Rodríguez | Sofía           | Fuenlabrada |
  | Verónica Pérez    | Sofía           | Fuenlabrada |
  | Isabel Gutiérrez  | Andrea          | Fuenlabrada |
  +-------------------+-----------------+-------------+
  ```

  

8. Devuelve un listado con el nombre de los empleados junto con el nombre
    de sus jefes.

  ```sql
  SELECT
    e.nombre_empleado AS Empleado,
    j.nombre_empleado AS Jefe
  FROM empleado e
  LEFT JOIN empleado j ON e.id_jefe = j.id_empleado;
  +----------+--------+
  | Empleado | Jefe   |
  +----------+--------+
  | María    | NULL   |
  | Juan     | María  |
  | Pedro    | Juan   |
  | Ana      | Juan   |
  | José     | Juan   |
  | Edwind   | NULL   |
  | Laura    | Edwind |
  | Sofía    | Laura  |
  | Diego    | Laura  |
  | Andrea   | Laura  |
  +----------+--------+
  ```

  

9. Devuelve un listado que muestre el nombre de cada empleados, el nombre
    de su jefe y el nombre del jefe de sus jefe.

  ```sql
  SELECT 
      e1.nombre_empleado AS Nombre_Empleado,
      CONCAT(e2.nombre_empleado, ' ', e2.apellido1) AS Nombre_Jefe,
      CONCAT(e3.nombre_empleado, ' ', e3.apellido1) AS Nombre_Jefe_De_Jefe
  FROM empleado AS e1
  LEFT JOIN empleado AS e2 ON e1.id_jefe = e2.id_empleado
  LEFT JOIN empleado AS e3 ON e2.id_jefe = e3.id_empleado;
  +-----------------+------------------+---------------------+
  | Nombre_Empleado | Nombre_Jefe      | Nombre_Jefe_De_Jefe |
  +-----------------+------------------+---------------------+
  | María           | NULL             | NULL                |
  | Juan            | María García     | NULL                |
  | Pedro           | Juan Pérez       | María García        |
  | Ana             | Juan Pérez       | María García        |
  | José            | Juan Pérez       | María García        |
  | Edwind          | NULL             | NULL                |
  | Laura           | Edwind Hernandez | NULL                |
  | Sofía           | Laura  González  | Edwind Hernandez    |
  | Diego           | Laura  González  | Edwind Hernandez    |
  | Andrea          | Laura  González  | Edwind Hernandez    |
  +-----------------+------------------+---------------------+
  ```

  

10. Devuelve el nombre de los clientes a los que no se les ha entregado a
    tiempo un pedido.

    ```sql
    SELECT
      c.nombre_cliente AS Cliente,
      p.id_pedido AS ID_Pedido,
      p.fecha_entrega AS Fecha_Entrega_Esperada,
      p.fecha_esperado AS Fecha_Entrega_Real
    FROM pedido AS p
    JOIN cliente AS c ON p.codigo_client_pedido = c.id_cliente
    WHERE p.fecha_entrega > p.fecha_esperado;
    +------------------+-----------+------------------------+--------------------+
    | Cliente          | ID_Pedido | Fecha_Entrega_Esperada | Fecha_Entrega_Real |
    +------------------+-----------+------------------------+--------------------+
    | Roberto Martínez |         2 | 2024-04-10             | 2024-04-06         |
    | Roberto Martínez |         4 | 2024-04-10             | 2024-04-08         |
    | Fernando Sánchez |         6 | 2024-04-15             | 2024-04-10         |
    | Alejandra López  |        10 | 2024-04-18             | 2024-04-14         |
    +------------------+-----------+------------------------+--------------------+
    ```

    

11. Devuelve un listado de las diferentes gamas de producto que ha comprado
    cada cliente.

    ```sql
    SELECT
        DISTINCT c.nombre_cliente AS Nombre_Cliente,
        gp.nombre AS Gama_Producto
    FROM cliente c
    INNER JOIN pedido p ON c.id_cliente = p.codigo_client_pedido
    INNER JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido_producto
    INNER JOIN producto pr ON dp.id_producto_pedido = pr.id_producto
    INNER JOIN gama_producto gp ON pr.codigo_gama = gp.id_gama
    ORDER BY Nombre_Cliente, Gama_Producto;
    +------------------+---------------+
    | Nombre_Cliente   | Gama_Producto |
    +------------------+---------------+
    | Alejandra López  | Frutales      |
    | Alejandra López  | Herbaceas     |
    | Alejandra López  | Ornamentales  |
    | Fernando Sánchez | Aromáticas    |
    | Fernando Sánchez | Frutales      |
    | Fernando Sánchez | Herbaceas     |
    | Fernando Sánchez | Herramientas  |
    | Roberto Martínez | Frutales      |
    | Roberto Martínez | Herbaceas     |
    | Roberto Martínez | Herramientas  |
    | Roberto Martínez | Ornamentales  |
    +------------------+---------------+
    ```
    
    

## Consultas multitabla (Composición externa)

###### Resuelva todas las consultas utilizando las cláusulas LEFT JOIN, RIGHT JOIN, NATURAL

###### LEFT JOIN y NATURAL RIGHT JOIN.

1. Devuelve un listado que muestre solamente los clientes que no han
    realizado ningún pago.

  ```sql
  SELECT c.nombre_cliente AS Nombre_Cliente
  FROM cliente c
  LEFT JOIN pago p ON c.id_cliente = p.codigo_cliente_pa
  WHERE p.id_pago IS NULL;
  +-------------------+
  | Nombre_Cliente    |
  +-------------------+
  | Isabel Gutiérrez  |
  | Gabriel Rodríguez |
  | Verónica Pérez    |
  | Marina Fernández  |
  | Andrés Ramírez    |
  +-------------------+
  ```

  

2. Devuelve un listado que muestre solamente los clientes que no han
    realizado ningún pedido.

  ```sql
  SELECT c.nombre_cliente AS Nombre_Cliente
  FROM cliente c
  LEFT JOIN pedido p ON c.id_cliente = p.codigo_client_pedido
  WHERE p.id_pedido IS NULL;
  +-------------------+
  | Nombre_Cliente    |
  +-------------------+
  | Isabel Gutiérrez  |
  | Gabriel Rodríguez |
  | Verónica Pérez    |
  | Marina Fernández  |
  | Andrés Ramírez    |
  +-------------------+
  ```

  

3. Devuelve un listado que muestre los clientes que no han realizado ningún
    pago y los que no han realizado ningún pedido.

  ```sql
  SELECT 
      c.nombre_cliente AS Nombre_Cliente,
      'Sin Pagos' AS Estado
  FROM cliente c
  LEFT JOIN pago pa ON c.id_cliente = pa.codigo_cliente_pa
  WHERE pa.id_pago IS NULL
  UNION
  SELECT 
      c2.nombre_cliente AS Nombre_Cliente,
      'Sin Pedidos' AS Estado
  FROM cliente c2
  LEFT JOIN pedido pe ON c2.id_cliente = pe.codigo_client_pedido
  WHERE pe.id_pedido IS NULL;
  +-------------------+-------------+
  | Nombre_Cliente    | Estado      |
  +-------------------+-------------+
  | Isabel Gutiérrez  | Sin Pagos   |
  | Gabriel Rodríguez | Sin Pagos   |
  | Verónica Pérez    | Sin Pagos   |
  | Marina Fernández  | Sin Pagos   |
  | Andrés Ramírez    | Sin Pagos   |
  | Isabel Gutiérrez  | Sin Pedidos |
  | Gabriel Rodríguez | Sin Pedidos |
  | Verónica Pérez    | Sin Pedidos |
  | Marina Fernández  | Sin Pedidos |
  | Andrés Ramírez    | Sin Pedidos |
  +-------------------+-------------+
  ```

  

4. Devuelve un listado que muestre solamente los empleados que no tienen
    una oficina asociada.

  ```
  SELECT e.nombre_empleado AS Nombre_Empleado
  FROM empleado e
  WHERE e.codigo_oficina IS NULL;
  +-----------------+
  | Nombre_Empleado |
  +-----------------+
  | María           |
  | Edwind          |
  +-----------------+
  ```

  

5. Devuelve un listado que muestre solamente los empleados que no tienen un
    cliente asociado.

  ```sql
  SELECT e.nombre_empleado
  FROM empleado e
  LEFT JOIN cliente c ON e.id_empleado = c.codigo_empleado_rep_ventas
  WHERE c.id_cliente IS NULL;
  +-----------------+
  | Nombre_Empleado |
  +-----------------+
  | María           |
  | Juan            |
  | José            |
  | Edwind          |
  | Laura           |
  | Diego           |
  +-----------------+
  ```

  

6. Devuelve un listado que muestre solamente los empleados que no tienen un
    cliente asociado junto con los datos de la oficina donde trabajan.

  ```sql
  SELECT 
      e.nombre_empleado AS Nombre_Empleado,
      o.id_oficina AS ID_Oficina,
      o.codigo_direccion_o AS Codigo_Direccion_Oficina
  FROM empleado e
  LEFT JOIN oficina o ON e.codigo_oficina = o.id_oficina
  WHERE e.id_empleado NOT IN (SELECT codigo_empleado_rep_ventas FROM cliente WHERE codigo_empleado_rep_ventas IS NOT NULL);
  +-----------------+------------+--------------------------+
  | Nombre_Empleado | ID_Oficina | Codigo_Direccion_Oficina |
  +-----------------+------------+--------------------------+
  | María           |       NULL |                     NULL |
  | Juan            |          1 |                        1 |
  | José            |          1 |                        1 |
  | Edwind          |       NULL |                     NULL |
  | Laura           |          2 |                        2 |
  | Diego           |          2 |                        2 |
  +-----------------+------------+--------------------------+
  ```

  

7. Devuelve un listado que muestre los empleados que no tienen una oficina
    asociada y los que no tienen un cliente asociado.

  ```sql
  SELECT e.nombre_empleado, 'Sin oficina' AS oficina, '-----' As clientes
  FROM empleado e 
  LEFT JOIN oficina o ON e.codigo_oficina = o.id_oficina
  WHERE o.id_oficina IS NULL 
  UNION
  SELECT e.nombre_empleado, '-----' AS oficina, 'sin cliente' As clientes
  FROM empleado e 
  LEFT JOIN cliente c ON e.id_empleado = c.codigo_empleado_rep_ventas
  WHERE c.id_cliente IS NULL;
  +-----------------+-------------+-------------+
  | nombre_empleado | oficina     | clientes    |
  +-----------------+-------------+-------------+
  | María           | Sin oficina | -----       |
  | Edwind          | Sin oficina | -----       |
  | María           | -----       | sin cliente |
  | Juan            | -----       | sin cliente |
  | José            | -----       | sin cliente |
  | Edwind          | -----       | sin cliente |
  | Laura           | -----       | sin cliente |
  | Diego           | -----       | sin cliente |
  +-----------------+-------------+-------------+
  ```

  

8. Devuelve un listado de los productos que nunca han aparecido en un
    pedido.

  ```sql
  SELECT 
      p.id_producto,
      p.nombre AS Nombre_Producto
  FROM producto p
  LEFT JOIN detalle_pedido dp ON p.id_producto = dp.id_producto_pedido
  WHERE dp.id_producto_pedido IS NULL;
  +-------------+-----------------+
  | id_producto | Nombre_Producto |
  +-------------+-----------------+
  |          14 | Fresas Frescas  |
  |          15 | Rosa Roja       |
  +-------------+-----------------+
  ```

  

9. Devuelve un listado de los productos que nunca han aparecido en un
    pedido. El resultado debe mostrar el nombre, la descripción y la imagen del
    producto.

  ```sql
  SELECT 
      p.nombre,
      p.descripcion_producto,
      gp.imagen
  FROM producto p
  LEFT JOIN gama_producto gp ON p.codigo_gama = gp.id_gama
  LEFT JOIN detalle_pedido dp ON p.id_producto = dp.id_producto_pedido
  WHERE dp.id_producto_pedido IS NULL;
  +----------------+----------------------------------+--------+
  | nombre         | descripcion_producto             | imagen |
  +----------------+----------------------------------+--------+
  | Fresas Frescas | Fresas maduras y jugosas.        | NULL   |
  | Rosa Roja      | Rosa roja de floración temprana. | NULL   |
  +----------------+----------------------------------+--------+
  ```

  

10. Devuelve las oficinas donde no trabajan ninguno de los empleados que
    hayan sido los representantes de ventas de algún cliente que haya realizado
    la compra de algún producto de la gama Frutales.

    ```sql
    SELECT DISTINCT
        o.id_oficina,
        d.linea_direccion1,
        d.linea_direccion2,
        c.nombre_cliente
    FROM cliente c
    JOIN pedido pe ON c.id_cliente = pe.codigo_client_pedido
    JOIN detalle_pedido dp ON pe.id_pedido = dp.id_pedido_producto
    JOIN producto p ON dp.id_producto_pedido = p.id_producto
    JOIN gama_producto gp ON p.codigo_gama = gp.id_gama
    JOIN empleado e ON c.codigo_empleado_rep_ventas = e.id_empleado
    JOIN oficina o ON e.codigo_oficina = o.id_oficina
    JOIN direccion d ON o.codigo_direccion_o = d.id_direccion
    WHERE gp.nombre = 'Frutales' AND o.id_oficina NOT IN (
        SELECT codigo_oficina
        FROM empleado
    );
    Empty set (0.00 sec)
    ```

    

11. Devuelve un listado con los clientes que han realizado algún pedido pero no
    han realizado ningún pago.

    ```sql
    SELECT c.id_cliente, c.nombre_cliente
    FROM cliente c
    JOIN pedido p ON c.id_cliente = p.codigo_client_pedido
    LEFT JOIN pago pa ON c.id_cliente = pa.codigo_cliente_pa
    WHERE pa.id_pago IS NULL;
    Empty set (0.00 sec)
    ```

    

12. Devuelve un listado con los datos de los empleados que no tienen clientes
    asociados y el nombre de su jefe asociado.

    ```sql
    SELECT e.id_empleado, e.nombre_empleado, e.apellido1, e.apellido2, j.nombre_empleado AS nombre_jefe
    FROM empleado e
    LEFT JOIN empleado j ON e.id_jefe = j.id_empleado
    LEFT JOIN cliente c ON e.id_empleado = c.codigo_empleado_rep_ventas
    WHERE c.id_cliente IS NULL;
    +-------------+-----------------+-----------------+-----------+-------------+
    | id_empleado | nombre_empleado | apellido1       | apellido2 | nombre_jefe |
    +-------------+-----------------+-----------------+-----------+-------------+
    |           1 | María           | García          | López     | NULL        |
    |           2 | Juan            | Pérez           | Gómez     | María       |
    |           5 | José            | Cala            | Marin     | Juan        |
    |           6 | Edwind          | Hernandez       | NULL      | NULL        |
    |           7 | Laura           | González        | NULL      | Edwind      |
    |           9 | Diego           | MarRamíreztínez | NULL      | Laura       |
    +-------------+-----------------+-----------------+-----------+-------------+
    ```

## Consultas resumen

1. ¿Cuántos empleados hay en la compañía?

   ```sql
   SELECT COUNT(id_empleado) AS total_empleados
   FROM empleado;
   +-----------------+
   | total_empleados |
   +-----------------+
   |              10 |
   +-----------------+
   ```

   

2. ¿Cuántos clientes tiene cada país?

   ```sql
   SELECT p.nombre AS pais, COUNT(c.id_cliente) AS total_clientes
   FROM pais p
   LEFT JOIN region r ON p.id_pais = r.codigo_pais
   LEFT JOIN ciudad ci ON r.id_region = ci.codigo_region
   LEFT JOIN cliente c ON ci.id_ciudad = c.codigo_ciudad_c
   GROUP BY p.nombre;
   +----------------+----------------+
   | pais           | total_clientes |
   +----------------+----------------+
   | USA            |              0 |
   | Spain          |              8 |
   | France         |              0 |
   | Australia      |              0 |
   | United Kingdom |              0 |
   +----------------+----------------+
   ```

   

3. ¿Cuál fue el pago medio en 2009?

   ```sql
   SELECT AVG(total) AS pago_medio_2009
   FROM pago
   WHERE YEAR(fecha_pago) = 2009;
   +-----------------+
   | pago_medio_2009 |
   +-----------------+
   |             250 |
   +-----------------+
   ```

   

4. ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma
    descendente por el número de pedidos.

  ```sql
  
  SELECT e.nombre_estado, COUNT(id_pedido) AS cantidad_pedidos
  FROM pedido p
  INNER JOIN estado e ON p.codigo_estado_pedido = e.id_estado
  GROUP BY e.nombre_estado
  ORDER BY cantidad_pedidos DESC;
  +---------------+------------------+
  | nombre_estado | cantidad_pedidos |
  +---------------+------------------+
  | Entregado     |                5 |
  | Rechazado     |                3 |
  | Pendiente     |                2 |
  +---------------+------------------+
  ```

  

5. Calcula el precio de venta del producto más caro y más barato en una
    misma consulta.

  ```sql
  SELECT 
      MAX(precio_venta) AS precio_mas_caro,
      MIN(precio_venta) AS precio_mas_barato
  FROM producto;
  +-----------------+-------------------+
  | precio_mas_caro | precio_mas_barato |
  +-----------------+-------------------+
  |          149.99 |              0.89 |
  +-----------------+-------------------+
  ```

  

6. Calcula el número de clientes que tiene la empresa.

   ```sql
   SELECT COUNT(id_cliente) AS numero_clientes
   FROM cliente;
   +-----------------+
   | numero_clientes |
   +-----------------+
   |               8 |
   +-----------------+
   ```

   

7. ¿Cuántos clientes existen con domicilio en la ciudad de Madrid?

   ```sql
   SELECT COUNT(id_cliente) AS total_clientes_madrid
   FROM cliente c
   JOIN ciudad ci ON c.codigo_ciudad_c = ci.id_ciudad
   WHERE ci.nombre = 'Madrid';
   +-----------------------+
   | total_clientes_madrid |
   +-----------------------+
   |                     3 |
   +-----------------------+
   ```

   

8. ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan
    por M?

  ```sql
  SELECT ci.nombre AS ciudad, COUNT(id_ciudad) AS total_clientes
  FROM cliente c
  JOIN ciudad ci ON c.codigo_ciudad_c = ci.id_ciudad
  WHERE ci.nombre LIKE 'M%'
  GROUP BY ci.nombre;
  +--------+----------------+
  | ciudad | total_clientes |
  +--------+----------------+
  | Madrid |              3 |
  +--------+----------------+
  ```

  

9. Devuelve el nombre de los representantes de ventas y el número de clientes
    al que atiende cada uno.

  ```sql
  SELECT e.nombre_empleado AS representante_ventas, COUNT(c.id_cliente) AS numero_clientes
  FROM empleado e
  LEFT JOIN cliente c ON e.id_empleado = c.codigo_empleado_rep_ventas
  WHERE e.codigo_cargo = 5
  GROUP BY e.nombre_empleado;
  +----------------------+-----------------+
  | representante_ventas | numero_clientes |
  +----------------------+-----------------+
  | Pedro                |               1 |
  | Ana                  |               2 |
  | José                 |               0 |
  | Sofía                |               2 |
  | Diego                |               0 |
  | Andrea               |               1 |
  +----------------------+-----------------+
  ```

  

10. Calcula el número de clientes que no tiene asignado representante de
    ventas.

    ```
    SELECT COUNT(id_cliente) AS clientes_sin_representante
    FROM cliente
    WHERE codigo_empleado_rep_ventas IS NULL;
    +----------------------------+
    | clientes_sin_representante |
    +----------------------------+
    |                          2 |
    +----------------------------+
    ```

    

11. Calcula la fecha del primer y último pago realizado por cada uno de los
    clientes. El listado deberá mostrar el nombre y los apellidos de cada cliente.

    ```sql
    SELECT
        c.nombre_cliente,
        MIN(pa.fecha_pago) AS primera_fecha_pago,
        MAX(pa.fecha_pago) AS ultima_fecha_pago
    FROM cliente c
    LEFT JOIN pago pa ON c.id_cliente = pa.codigo_cliente_pa
    GROUP BY c.nombre_cliente;
    +-------------------+--------------------+-------------------+
    | nombre_cliente    | primera_fecha_pago | ultima_fecha_pago |
    +-------------------+--------------------+-------------------+
    | Roberto Martínez  | 2008-04-01         | 2024-04-04        |
    | Alejandra López   | 2009-04-02         | 2024-04-02        |
    | Fernando Sánchez  | 2008-04-05         | 2024-04-05        |
    | Isabel Gutiérrez  | NULL               | NULL              |
    | Gabriel Rodríguez | NULL               | NULL              |
    | Verónica Pérez    | NULL               | NULL              |
    | Marina Fernández  | NULL               | NULL              |
    | Andrés Ramírez    | NULL               | NULL              |
    +-------------------+--------------------+-------------------+
    ```

    

12. Calcula el número de productos diferentes que hay en cada uno de los
    pedidos.

    ```sql
    SELECT id_pedido_producto, COUNT(DISTINCT id_producto_pedido) AS 'Número de productos'
    FROM detalle_pedido
    GROUP BY id_pedido_producto;
    +--------------------+---------------------+
    | id_pedido_producto | Número de productos |
    +--------------------+---------------------+
    |                  1 |                   4 |
    |                  2 |                   4 |
    |                  3 |                   3 |
    |                  4 |                   3 |
    |                  5 |                   3 |
    |                  6 |                   3 |
    |                  7 |                   2 |
    |                  8 |                   3 |
    |                  9 |                   1 |
    |                 10 |                   2 |
    +--------------------+---------------------+
    ```

    

13. Calcula la suma de la cantidad total de todos los productos que aparecen en
    cada uno de los pedidos.

    ```sql
    SELECT
        p.id_pedido,
        SUM(dp.cantidad) AS cantidad_total_productos
    FROM pedido p
    INNER JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido_producto
    GROUP BY p.id_pedido;
    +-----------+--------------------------+
    | id_pedido | cantidad_total_productos |
    +-----------+--------------------------+
    |         1 |                       13 |
    |         2 |                       11 |
    |         3 |                        6 |
    |         4 |                        3 |
    |         5 |                        3 |
    |         6 |                        4 |
    |         7 |                        8 |
    |         8 |                        5 |
    |         9 |                        2 |
    |        10 |                        6 |
    +-----------+--------------------------+
    ```

    

14. Devuelve un listado de los 20 productos más vendidos y el número total de
    unidades que se han vendido de cada uno. El listado deberá estar ordenado
    por el número total de unidades vendidas.

    ```sql
    SELECT p.nombre AS nombre_producto, 
           SUM(dp.cantidad) AS total_unidades_vendidas
    FROM detalle_pedido dp
    JOIN producto p ON dp.id_producto_pedido = p.id_producto
    GROUP BY p.nombre
    ORDER BY total_unidades_vendidas DESC
    LIMIT 20;
    +-----------------------------------+-------------------------+
    | nombre_producto                   | total_unidades_vendidas |
    +-----------------------------------+-------------------------+
    | Uvas Thompson                     |                      15 |
    | Plátanos Canarios                 |                       9 |
    | Lirio Blanco                      |                       5 |
    | Planta de Lavanda                 |                       4 |
    | Hierba de Limón                   |                       4 |
    | Manzanas Gala                     |                       3 |
    | Begonia Escarlata                 |                       3 |
    | Planta de Menta                   |                       2 |
    | Cortadora de Césped               |                       2 |
    | Set de Riego Automático           |                       2 |
    | Vela de Lavanda                   |                       2 |
    | Aceite Esencial de Eucalipto      |                       2 |
    | Naranjas Valencia                 |                       2 |
    | Girasol Gigante                   |                       2 |
    | Orquídea Phalaenopsis             |                       2 |
    | Set de Herramientas de Jardinería |                       1 |
    | Incienso de Sándalo               |                       1 |
    +-----------------------------------+-------------------------+
    ```

    

15. La facturación que ha tenido la empresa en toda la historia, indicando la
    base imponible, el IVA y el total facturado. La base imponible se calcula
    sumando el coste del producto por el número de unidades vendidas de la
    tabla detalle_pedido. El IVA es el 21 % de la base imponible, y el total la
    suma de los dos campos anteriores.

    ```sql
    SELECT 
        SUM(base_imponible) AS total_base_imponible,
        SUM(iva) AS total_iva,
        SUM(total_facturado) AS facturacion_total
    FROM (
        SELECT 
            SUM(dp.cantidad * p.precio_venta) AS base_imponible,
            SUM(dp.cantidad * p.precio_venta) * 0.21 AS iva,
            SUM(dp.cantidad * p.precio_venta) * 1.21 AS total_facturado
        FROM detalle_pedido dp
        JOIN producto p ON dp.id_producto_pedido = p.id_producto
        GROUP BY dp.id_pedido_producto
    ) AS facturacion;
    +----------------------+--------------------+-------------------+
    | total_base_imponible | total_iva          | facturacion_total |
    +----------------------+--------------------+-------------------+
    |               600.39 | 126.08190000000002 |          726.4719 |
    +----------------------+--------------------+-------------------+
    ```

    

16. La misma información que en la pregunta anterior, pero agrupada por
    código de producto.

    ```sql
    SELECT 
        dp.id_producto_pedido AS codigo_producto,
        SUM(dp.cantidad * p.precio_venta) AS base_imponible,
        SUM(dp.cantidad * p.precio_venta) * 0.21 AS iva,
        SUM(dp.cantidad * p.precio_venta) * 1.21 AS total_facturado
    FROM detalle_pedido dp
    JOIN producto p ON dp.id_producto_pedido = p.id_producto
    GROUP BY dp.id_producto_pedido;
    +-----------------+--------------------+--------------------+--------------------+
    | codigo_producto | base_imponible     | iva                | total_facturado    |
    +-----------------+--------------------+--------------------+--------------------+
    |               1 |              23.96 |             5.0316 | 28.991600000000002 |
    |               2 |               8.98 |             1.8858 |            10.8658 |
    |               3 |              15.96 |             3.3516 | 19.311600000000002 |
    |               4 |              39.99 |             8.3979 |            48.3879 |
    |               5 |             299.98 |            62.9958 |           362.9758 |
    |               6 |              59.98 | 12.595799999999999 |            72.5758 |
    |               7 |               2.99 |             0.6279 |             3.6179 |
    |               8 |               5.98 |             1.2558 |             7.2358 |
    |               9 |              19.98 |             4.1958 |            24.1758 |
    |              10 | 2.9699999999999998 | 0.6236999999999999 | 3.5936999999999997 |
    |              11 |               2.98 |             0.6258 |             3.6058 |
    |              12 |               8.01 |             1.6821 |             9.6921 |
    |              13 |              44.85 |             9.4185 |            54.2685 |
    |              16 | 22.450000000000003 |             4.7145 | 27.164500000000004 |
    |              17 | 11.370000000000001 |             2.3877 | 13.757700000000002 |
    |              18 |              11.98 |             2.5158 | 14.495800000000001 |
    |              19 |              17.98 |             3.7758 |            21.7558 |
    +-----------------+--------------------+--------------------+--------------------+
    ```

    

17. La misma información que en la pregunta anterior, pero agrupada por
    código de producto filtrada por los códigos que empiecen por OR.

    ```
    Los codigos de mis productos no tienen esa nomeclatura
    ```

    

18. Lista las ventas totales de los productos que hayan facturado más de 3000
    euros. Se mostrará el nombre, unidades vendidas, total facturado y total
    facturado con impuestos (21% IVA).

    ```sql
    SELECT 
        p.nombre AS nombre_producto,
        SUM(dp.cantidad) AS unidades_vendidas,
        ROUND(SUM(dp.cantidad * p.precio_venta), 2) AS total_facturado_sin_iva,
        ROUND(SUM(dp.cantidad * p.precio_venta) * 1.21, 2) AS total_facturado_con_iva
    FROM detalle_pedido dp
    JOIN producto p ON dp.id_producto_pedido = p.id_producto
    GROUP BY p.nombre
    HAVING total_facturado_con_iva > 3000;
    Empty set (0.03 sec)
    Mis precios no superan los 3000 euros
    ```

    

19. Muestre la suma total de todos los pagos que se realizaron para cada uno
    de los años que aparecen en la tabla pagos.

    ```sql
    SELECT 
        YEAR(fecha_pago) AS ano,
        SUM(total) AS total_pagado
    FROM pago
    GROUP BY YEAR(fecha_pago);
    +------+--------------+
    | ano  | total_pagado |
    +------+--------------+
    | 2024 |         1080 |
    | 2008 |          580 |
    | 2009 |          500 |
    +------+--------------+
    ```

    ## Subconsultas 
    
    #### Con operadores básicos de comparación 
    
    1. Devuelve el nombre del cliente con mayor límite de crédito.
    
       ```sql
       SELECT nombre_cliente
       FROM cliente
       WHERE limite_credito = (
           SELECT MAX(limite_credito)
           FROM cliente
       );
       +------------------+
       | nombre_cliente   |
       +------------------+
       | Fernando Sánchez |
       +------------------+
       ```
    
       
    
    2. Devuelve el nombre del producto que tenga el precio de venta más caro.
    
       ```sql
       SELECT nombre
       FROM producto
       WHERE precio_venta = (
           SELECT MAX(precio_venta)
           FROM producto
       );
       +---------------------+
       | nombre              |
       +---------------------+
       | Cortadora de Césped |
       +---------------------+
       ```
    
       
    
    3. Devuelve el nombre del producto del que se han vendido más unidades.
        (Tenga en cuenta que tendrá que calcular cuál es el número total de
        unidades que se han vendido de cada producto a partir de los datos de la
        tabla detalle_pedido)
    
      ```sql
      SELECT nombre 
      FROM producto 
      WHERE id_producto = (
          SELECT id_producto_pedido
          FROM detalle_pedido
          GROUP BY id_producto_pedido
          ORDER by SUM(cantidad) DESC
          LIMIT 1
      );
      +---------------+
      | nombre        |
      +---------------+
      | Uvas Thompson |
      +---------------+
      ```
    
      
    
    4. Los clientes cuyo límite de crédito sea mayor que los pagos que haya
        realizado. (Sin utilizar INNER JOIN).
    
      ```sql
      SELECT c.nombre_cliente
      FROM cliente AS c
      WHERE c.id_cliente IN (
          SELECT c.id_cliente
          FROM pago AS p
          GROUP BY c.id_cliente
          HAVING c.limite_credito > SUM(p.total) 
      );
      
      +-------------------+
      | nombre_cliente    |
      +-------------------+
      | Roberto Martínez  |
      | Alejandra López   |
      | Fernando Sánchez  |
      | Isabel Gutiérrez  |
      | Gabriel Rodríguez |
      | Verónica Pérez    |
      | Marina Fernández  |
      | Andrés Ramírez    |
      +-------------------+
      ```
    
      
    
    5. Devuelve el producto que más unidades tiene en stock.
    
       ```sql
       SELECT id_producto, nombre, cantidad_stock, precio_venta
       FROM producto
       WHERE cantidad_stock = (
           SELECT MAX(cantidad_stock)
           FROM producto
           LIMIT 1
       );
       +-------------+---------------------+----------------+--------------+
       | id_producto | nombre              | cantidad_stock | precio_venta |
       +-------------+---------------------+----------------+--------------+
       |           7 | Incienso de Sándalo |             50 |         2.99 |
       +-------------+---------------------+----------------+--------------+
       ```
    
       
    
    6. Devuelve el producto que menos unidades tiene en stock.
    
       ```sql
       SELECT id_producto, nombre, cantidad_stock, precio_venta
       FROM producto
       WHERE cantidad_stock = (
           SELECT MIN(cantidad_stock)
           FROM producto
           LIMIT 1
       );
       +-------------+---------------------+----------------+--------------+
       | id_producto | nombre              | cantidad_stock | precio_venta |
       +-------------+---------------------+----------------+--------------+
       |           5 | Cortadora de Césped |              5 |       149.99 |
       +-------------+---------------------+----------------+--------------+
       ```
    
       
    
    7. Devuelve el nombre, los apellidos y el email de los empleados que están a
        cargo de Juan Pérez.
    
      ```sql
      SELECT nombre_empleado, CONCAT_WS(' ', apellido1, apellido2) AS 'apellidos', email
      FROM empleado
      WHERE id_empleado IN (
          SELECT id_empleado
          FROM empleado 
          WHERE id_jefe = (
              SELECT id_empleado
              FROM empleado
              WHERE nombre_empleado = 'Juan' AND apellido1 = 'Pérez'
          )
      );
      +-----------------+--------------------+---------------------------+
      | nombre_empleado | apellidos          | email                     |
      +-----------------+--------------------+---------------------------+
      | Pedro           | Romero Sánchez     | pedro.romero@empresa.com  |
      | Ana             | Martínez Fernández | ana.martinez@empresa.com  |
      | José            | Cala Marin         | jose.martinez@empresa.com |
      +-----------------+--------------------+---------------------------+
      ```
    
      
    
      ### Subconsultas con ALL y ANY
    
    8. Devuelve el nombre del cliente con mayor límite de crédito.
    
       ```sql
       SELECT nombre_cliente
       FROM cliente
       WHERE limite_credito >= ALL (
           SELECT limite_credito
           FROM cliente
       );
       +------------------+
       | nombre_cliente   |
       +------------------+
       | Fernando Sánchez |
       +------------------+
       ```
    
       
    
    9. Devuelve el nombre del producto que tenga el precio de venta más caro.
    
       ```sql
       SELECT nombre
       FROM producto 
       WHERE precio_venta >= ALL(
           SELECT precio_venta 
           FROM producto
       );
       +---------------------+
       | nombre              |
       +---------------------+
       | Cortadora de Césped |
       +---------------------+
       ```
    
       
    
    10. Devuelve el producto que menos unidades tiene en stock.
    
        ```sql
        SELECT nombre
        FROM producto 
        WHERE cantidad_stock <= ALL(
            SELECT cantidad_stock
            FROM producto
        );
        +---------------------+
        | nombre              |
        +---------------------+
        | Cortadora de Césped |
        +---------------------+
        ```
    
        
    
        ### Subconsultas con IN y NOT IN
    
    11. Devuelve el nombre, apellido1 y cargo de los empleados que no
        representen a ningún cliente.
    
        ```sql
        SELECT e.nombre_empleado, e.apellido1
        FROM empleado AS e
        WHERE e.id_empleado NOT IN(
            SELECT c.codigo_empleado_rep_ventas
            FROM cliente AS c
            WHERE c.codigo_empleado_rep_ventas = e.id_empleado
        );
        +-----------------+-----------------+
        | nombre_empleado | apellido1       |
        +-----------------+-----------------+
        | María           | García          |
        | Juan            | Pérez           |
        | José            | Cala            |
        | Edwind          | Hernandez       |
        | Laura           | González        |
        | Diego           | MarRamíreztínez |
        +-----------------+-----------------+
        ```
    
        
    
    12. Devuelve un listado que muestre solamente los clientes que no han
        realizado ningún pago.
    
        ```sql
        SELECT c.id_cliente, c.nombre_cliente, c.limite_credito
        FROM cliente AS c
        WHERE c.id_cliente NOT IN (
            SELECT p.codigo_cliente_pa
            FROM pago AS p
            WHERE p.codigo_cliente_pa = c.id_cliente
        );
        +------------+-------------------+----------------+
        | id_cliente | nombre_cliente    | limite_credito |
        +------------+-------------------+----------------+
        |          4 | Isabel Gutiérrez  |           6000 |
        |          5 | Gabriel Rodríguez |           7000 |
        |          6 | Verónica Pérez    |           9000 |
        |          7 | Marina Fernández  |           7500 |
        |          8 | Andrés Ramírez    |           8500 |
        +------------+-------------------+----------------+
        ```
    
        
    
    13. Devuelve un listado que muestre solamente los clientes que sí han realizado
        algún pago.
    
        ```sql
        SELECT c.id_cliente, c.nombre_cliente, c.limite_credito
        FROM cliente AS c
        WHERE c.id_cliente IN (
            SELECT p.codigo_cliente_pa
            FROM pago AS p
            WHERE p.codigo_cliente_pa = c.id_cliente
        );
        +------------+------------------+----------------+
        | id_cliente | nombre_cliente   | limite_credito |
        +------------+------------------+----------------+
        |          1 | Roberto Martínez |           5000 |
        |          2 | Alejandra López  |           8000 |
        |          3 | Fernando Sánchez |          10000 |
        +------------+------------------+----------------+
        ```
    
        
    
    14. Devuelve un listado de los productos que nunca han aparecido en un
        pedido.
    
        ```sql
        SELECT p.id_producto, p.nombre, p.cantidad_stock, p.precio_venta
        FROM producto AS p
        WHERE p.id_producto NOT IN (
            SELECT dp.id_producto_pedido
            FROM detalle_pedido AS dp 
            WHERE p.id_producto = dp.id_producto_pedido
        );
        +-------------+----------------+----------------+--------------+
        | id_producto | nombre         | cantidad_stock | precio_venta |
        +-------------+----------------+----------------+--------------+
        |          14 | Fresas Frescas |             20 |         3.49 |
        |          15 | Rosa Roja      |             15 |         3.99 |
        +-------------+----------------+----------------+--------------+
        ```
    
        
    
    15. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
        empleados que no sean representante de ventas de ningún cliente.
    
        ```sql
        SELECT e.nombre_empleado, e.apellido1, c.nombre_cargo, t.numero
        FROM empleado AS e
        INNER JOIN oficina AS o ON e.codigo_oficina = o.id_oficina
        INNER JOIN telefono AS t ON t.codigo_oficina_te = o.id_oficina
        INNER JOIN cargo AS c ON e.codigo_cargo = c.id_cargo
        WHERE e.id_empleado NOT IN (
            SELECT cl.codigo_empleado_rep_ventas
            FROM cliente AS cl 
            WHERE cl.codigo_empleado_rep_ventas = e.id_empleado
        ) AND c.id_cargo = 5;
        +-----------------+-----------------+----------------------+------------+
        | nombre_empleado | apellido1       | nombre_cargo         | numero     |
        +-----------------+-----------------+----------------------+------------+
        | José            | Cala            | Representante Ventas | 3123456789 |
        | José            | Cala            | Representante Ventas | 5712345678 |
        | Diego           | MarRamíreztínez | Representante Ventas | 4123456789 |
        +-----------------+-----------------+----------------------+------------+
        ```
    
        
    
    16. Devuelve las oficinas donde no trabajan ninguno de los empleados que
        hayan sido los representantes de ventas de algún cliente que haya realizado
        la compra de algún producto de la gama Frutales.
    
        ```sql
        SELECT DISTINCT o.id_oficina, ciu.nombre
        FROM oficina o
        INNER JOIN direccion as dir ON o.codigo_direccion_o = dir.id_direccion
        INNER JOIN ciudad as ciu ON dir.codigo_ciudad_d = ciu.id_ciudad
        INNER JOIN empleado AS e ON o.id_oficina = e.codigo_oficina
        WHERE e.id_empleado NOT IN(
            SELECT c.codigo_empleado_rep_ventas
            FROM cliente AS c
            INNER JOIN pedido AS p ON c.id_cliente = p.codigo_client_pedido
            INNER JOIN detalle_pedido AS dp ON  p.id_pedido = dp.id_producto_pedido
            INNER JOIN producto AS pr ON dp.id_producto_pedido = pr.id_producto
            INNER JOIN gama_producto AS gp ON pr.codigo_gama = gp.id_gama
            WHERE gp.id_gama = 4;
        );
        
        +------------+-------------+
        | id_oficina | nombre      |
        +------------+-------------+
        |          1 | Madrid      |
        |          2 | Fuenlabrada |
        +------------+-------------+
        ```
    
        
    
    17. Devuelve un listado con los clientes que han realizado algún pedido pero no
        han realizado ningún pago.
    
        ```sql
        SELECT c.id_cliente, c.nombre_cliente, c.limite_credito
        FROM cliente AS c 
        WHERE c.id_cliente IN (
            SELECT pe.codigo_client_pedido
            FROM pedido AS pe
            WHERE pe.codigo_client_pedido = c.id_cliente
        ) AND c.id_cliente NOT IN (
            SELECT p.codigo_cliente_pa
            FROM pago AS p
            WHERE p.codigo_cliente_pa = c.id_cliente
        );
        Empty set (0.04 sec)
        TODOS LOS QUE HICIERON PEDIDOS PAGARON
        ```
    
        
    
        #### Subconsultas con EXISTS y NOT EXISTS
    
    18. Devuelve un listado que muestre solamente los clientes que no han
        realizado ningún pago.
    
        ```sql
        SELECT c.id_cliente, c.nombre_cliente, c.limite_credito
        FROM cliente AS c
        WHERE NOT EXISTS (
            SELECT p.codigo_cliente_pa
            FROM pago AS p
            WHERE c.id_cliente = p.codigo_cliente_pa
        );
        +------------+-------------------+----------------+
        | id_cliente | nombre_cliente    | limite_credito |
        +------------+-------------------+----------------+
        |          4 | Isabel Gutiérrez  |           6000 |
        |          5 | Gabriel Rodríguez |           7000 |
        |          6 | Verónica Pérez    |           9000 |
        |          7 | Marina Fernández  |           7500 |
        |          8 | Andrés Ramírez    |           8500 |
        +------------+-------------------+----------------+
        ```
    
    19. Devuelve un listado que muestre solamente los clientes que sí han realizado
        algún pago.
    
        ```sql
        SELECT c.id_cliente, c.nombre_cliente, c.limite_credito
        FROM cliente AS c
        WHERE EXISTS (
            SELECT p.codigo_cliente_pa
            FROM pago AS p
            WHERE c.id_cliente = p.codigo_cliente_pa
        );
        +------------+------------------+----------------+
        | id_cliente | nombre_cliente   | limite_credito |
        +------------+------------------+----------------+
        |          1 | Roberto Martínez |           5000 |
        |          2 | Alejandra López  |           8000 |
        |          3 | Fernando Sánchez |          10000 |
        +------------+------------------+----------------+
        ```
    
        
    
    20. Devuelve un listado de los productos que nunca han aparecido en un
        pedido.
    
        ```sql
        SELECT p.id_producto, p.nombre, p.cantidad_stock, p.precio_venta
        FROM producto AS p
        WHERE NOT EXISTS(
            SELECT dp.id_producto_pedido
            FROM detalle_pedido AS dp
            WHERE p.id_producto = dp.id_producto_pedido
        );
        +-------------+----------------+----------------+--------------+
        | id_producto | nombre         | cantidad_stock | precio_venta |
        +-------------+----------------+----------------+--------------+
        |          14 | Fresas Frescas |             20 |         3.49 |
        |          15 | Rosa Roja      |             15 |         3.99 |
        +-------------+----------------+----------------+--------------+
        ```
    
    21. Devuelve un listado de los productos que han aparecido en un pedido
        alguna vez.
    
        ```sql
        SELECT p.id_producto, p.nombre, p.cantidad_stock, p.precio_venta
        FROM producto AS p
        WHERE EXISTS(
            SELECT dp.id_producto_pedido
            FROM detalle_pedido AS dp
            WHERE p.id_producto = dp.id_producto_pedido
        );
        +-------------+-----------------------------------+----------------+--------------+
        | id_producto | nombre                            | cantidad_stock | precio_venta |
        +-------------+-----------------------------------+----------------+--------------+
        |           1 | Planta de Lavanda                 |             10 |         5.99 |
        |           2 | Planta de Menta                   |             25 |         4.49 |
        |           3 | Hierba de Limón                   |             18 |         3.99 |
        |           4 | Set de Herramientas de Jardinería |             20 |        39.99 |
        |           5 | Cortadora de Césped               |              5 |       149.99 |
        |           6 | Set de Riego Automático           |              8 |        29.99 |
        |           7 | Incienso de Sándalo               |             50 |         2.99 |
        |           8 | Vela de Lavanda                   |             25 |         2.99 |
        |           9 | Aceite Esencial de Eucalipto      |             40 |         9.99 |
        |          10 | Manzanas Gala                     |             30 |         0.99 |
        |          11 | Naranjas Valencia                 |             25 |         1.49 |
        |          12 | Plátanos Canarios                 |             35 |         0.89 |
        |          13 | Uvas Thompson                     |             40 |         2.99 |
        |          16 | Lirio Blanco                      |             25 |         4.49 |
        |          17 | Begonia Escarlata                 |             18 |         3.79 |
        |          18 | Girasol Gigante                   |             12 |         5.99 |
        |          19 | Orquídea Phalaenopsis             |             20 |         8.99 |
        +-------------+-----------------------------------+----------------+--------------+
        ```
    
        

## Consultas variadas

1. Devuelve el listado de clientes indicando el nombre del cliente y cuántos
    pedidos ha realizado. Tenga en cuenta que pueden existir clientes que no
    han realizado ningún pedido.

  ```sql
  SELECT 
      c.nombre_cliente AS nombre_cliente,
      COUNT(p.id_pedido) AS cantidad_pedidos
  FROM cliente c
  LEFT JOIN pedido p ON c.id_cliente = p.codigo_client_pedido
  GROUP BY c.nombre_cliente;
  +-------------------+------------------+
  | nombre_cliente    | cantidad_pedidos |
  +-------------------+------------------+
  | Roberto Martínez  |                4 |
  | Alejandra López   |                2 |
  | Fernando Sánchez  |                4 |
  | Isabel Gutiérrez  |                0 |
  | Gabriel Rodríguez |                0 |
  | Verónica Pérez    |                0 |
  | Marina Fernández  |                0 |
  | Andrés Ramírez    |                0 |
  +-------------------+------------------+
  ```

2. Devuelve un listado con los nombres de los clientes y el total pagado por
    cada uno de ellos. Tenga en cuenta que pueden existir clientes que no han
    realizado ningún pago.

  ```sql
  SELECT 
      c.nombre_cliente AS nombre_cliente,
      COALESCE(SUM(pa.total), 0) AS total_pagado
  FROM cliente c
  LEFT JOIN pago pa ON c.id_cliente = pa.codigo_cliente_pa
  GROUP BY c.nombre_cliente;
  +-------------------+--------------+
  | nombre_cliente    | total_pagado |
  +-------------------+--------------+
  | Roberto Martínez  |          800 |
  | Alejandra López   |          400 |
  | Fernando Sánchez  |          960 |
  | Isabel Gutiérrez  |            0 |
  | Gabriel Rodríguez |            0 |
  | Verónica Pérez    |            0 |
  | Marina Fernández  |            0 |
  | Andrés Ramírez    |            0 |
  +-------------------+--------------+
  ```

3. Devuelve el nombre de los clientes que hayan hecho pedidos en 2008
    ordenados alfabéticamente de menor a mayor.

  ```sql
  SELECT 
      c.nombre_cliente
  FROM cliente c
  JOIN pedido p ON c.id_cliente = p.codigo_client_pedido
  WHERE YEAR(p.fecha_pedido) = 2008
  ORDER BY c.nombre_cliente ASC;
  Empty set (0.00 sec)
  ```

4. Devuelve el nombre del cliente, el nombre y primer apellido de su
    representante de ventas y el número de teléfono de la oficina del representante de ventas, de aquellos clientes que no hayan realizado ningún pago.

```sql
SELECT c.nombre_cliente, e.nombre_empleado, e.apellido1, t.numero
FROM cliente c 
LEFT JOIN pago p ON c.id_cliente = p.codigo_cliente_pa
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.id_empleado
INNER JOIN oficina o ON e.codigo_oficina = o.id_oficina
INNER JOIN telefono t ON o.id_oficina = t.codigo_oficina_te
WHERE p.id_pago IS NULL;
+-------------------+-----------------+-----------+------------+
| nombre_cliente    | nombre_empleado | apellido1 | numero     |
+-------------------+-----------------+-----------+------------+
| Verónica Pérez    | Sofía           | Pérez     | 4123456789 |
| Gabriel Rodríguez | Sofía           | Pérez     | 4123456789 |
| Isabel Gutiérrez  | Andrea          | García    | 4123456789 |
+-------------------+-----------------+-----------+------------+
```



5. Devuelve el listado de clientes donde aparezca el nombre del cliente, el
    nombre y primer apellido de su representante de ventas y la ciudad donde
    está su oficina.

  ```sql
  SELECT 
      c.nombre_cliente,
      CONCAT(e.nombre_empleado, ' ', e.apellido1) AS nombre_representante,
      ci.nombre AS ciudad_oficina
  FROM cliente c
  JOIN empleado e ON c.codigo_empleado_rep_ventas = e.id_empleado
  JOIN oficina o ON e.codigo_oficina = o.id_oficina
  JOIN direccion d ON o.codigo_direccion_o = d.id_direccion
  JOIN ciudad ci ON d.codigo_ciudad_d = ci.id_ciudad;
  +-------------------+----------------------+----------------+
  | nombre_cliente    | nombre_representante | ciudad_oficina |
  +-------------------+----------------------+----------------+
  | Roberto Martínez  | Pedro Romero         | Madrid         |
  | Alejandra López   | Ana Martínez         | Madrid         |
  | Fernando Sánchez  | Ana Martínez         | Madrid         |
  | Gabriel Rodríguez | Sofía Pérez          | Fuenlabrada    |
  | Verónica Pérez    | Sofía Pérez          | Fuenlabrada    |
  | Isabel Gutiérrez  | Andrea García        | Fuenlabrada    |
  +-------------------+----------------------+----------------+
  ```

  

6. Devuelve el nombre, apellidos, puesto y teléfono de la oficina de aquellos
    empleados que no sean representante de ventas de ningún cliente.

  ```sql
  SELECT e.nombre_empleado, e.apellido1, ca.nombre_cargo, t.numero
  FROM empleado e
  INNER JOIN cargo ca ON e.codigo_cargo = ca.id_cargo
  LEFT JOIN cliente c ON e.id_empleado = c.codigo_empleado_rep_ventas
  LEFT JOIN oficina o ON e.codigo_oficina = o.id_oficina
  INNER JOIN telefono t ON o.id_oficina = t.codigo_oficina_te
  WHERE c.codigo_empleado_rep_ventas IS NULL;
  +-----------------+-----------------+----------------------+------------+
  | nombre_empleado | apellido1       | nombre_cargo         | numero     |
  +-----------------+-----------------+----------------------+------------+
  | Juan            | Pérez           | Director Oficina     | 3123456789 |
  | José            | Cala            | Representante Ventas | 3123456789 |
  | Juan            | Pérez           | Director Oficina     | 5712345678 |
  | José            | Cala            | Representante Ventas | 5712345678 |
  | Laura           | González        | Director Oficina     | 4123456789 |
  | Diego           | MarRamíreztínez | Representante Ventas | 4123456789 |
  +-----------------+-----------------+----------------------+------------+
  ```

  

7. Devuelve un listado indicando todas las ciudades donde hay oficinas y el
    número de empleados que tiene.

  ```sql
  SELECT 
      ci.nombre AS ciudad,
      COUNT(e.id_empleado) AS numero_empleados
  FROM empleado e
  RIGHT JOIN oficina o ON e.codigo_oficina = o.id_oficina
  JOIN direccion d ON o.codigo_direccion_o = d.id_direccion
  JOIN ciudad ci ON d.codigo_ciudad_d = ci.id_ciudad
  GROUP BY ci.nombre;
  +-------------+------------------+
  | ciudad      | numero_empleados |
  +-------------+------------------+
  | Madrid      |                4 |
  | Fuenlabrada |                4 |
  | Barcelona   |                0 |
  +-------------+------------------+
  ```

  

## vistas

```sql
-- 1 Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.

CREATE VIEW clienteEmpleado AS 
SELECT c.nombre_cliente, e.nombre_empleado, ci.nombre
FROM cliente AS c
INNER JOIN empleado AS e ON e.id_empleado = c.codigo_empleado_rep_ventas
INNER JOIN oficina AS o ON o.id_oficina = e.codigo_oficina
INNER JOIN direccion AS d ON d.id_direccion = o.codigo_direccion_o
INNER JOIN ciudad As ci ON ci.id_ciudad = d.codigo_ciudad_d;

-- 2 listado de las diferentes gamas de producto que ha comprado cada cliente
CREATE VIEW clienteProducto AS 
SELECT DISTINCT c.nombre_cliente AS Nombre_Cliente, gp.nombre AS Gama_Producto
FROM cliente c
INNER JOIN pedido p ON c.id_cliente = p.codigo_client_pedido
INNER JOIN detalle_pedido dp ON p.id_pedido = dp.id_pedido_producto
INNER JOIN producto pr ON dp.id_producto_pedido = pr.id_producto
INNER JOIN gama_producto gp ON pr.codigo_gama = gp.id_gama
ORDER BY Nombre_Cliente, Gama_Producto;

-- 3 listado que muestre solamente los clientes que no han realizado ningún pedido
CREATE VIEW clietePedido AS 
SELECT c.nombre_cliente AS Nombre_Cliente
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.codigo_client_pedido
WHERE p.id_pedido IS NULL;

-- 4 Muestre la suma total de todos los pagos que se realizaron para cada uno de los años que aparecen en la tabla pagos.
CREATE VIEW pagosAño AS 
SELECT YEAR(fecha_pago) AS ano, SUM(total) AS total_pagado
FROM pago
GROUP BY YEAR(fecha_pago);

-- 5 listado de los productos que han aparecido en un pedido alguna vez
CREATE VIEW productoConVentas AS 
SELECT p.id_producto, p.nombre, p.cantidad_stock, p.precio_venta
FROM producto AS p
WHERE EXISTS(
    SELECT dp.id_producto_pedido
    FROM detalle_pedido AS dp
    WHERE p.id_producto = dp.id_producto_pedido
);

-- 6 listado de clientes indicando el nombre del cliente y cuántos pedidos ha realizado.
CREATE VIEW pedidosXCliene AS 
SELECT c.nombre_cliente AS nombre_cliente, COUNT(p.id_pedido) AS cantidad_pedidos
FROM cliente c
LEFT JOIN pedido p ON c.id_cliente = p.codigo_client_pedido
GROUP BY c.nombre_cliente;

-- 7  listado con los nombres de los clientes y el total pagado por cada uno de ellos
CREATE VIEW  pagosXCliente AS 
SELECT c.nombre_cliente AS nombre_cliente, COALESCE(SUM(pa.total), 0) AS total_pagado
FROM cliente c
LEFT JOIN pago pa ON c.id_cliente = pa.codigo_cliente_pa
GROUP BY c.nombre_cliente;

-- 8 listado de clientes donde aparezca el nombre del cliente, el nombre y primer apellido de su representante de ventas y la ciudad donde está su oficina
CREATE VIEW clienteRepresentante AS 
SELECT 
    c.nombre_cliente,
    CONCAT(e.nombre_empleado, ' ', e.apellido1) AS nombre_representante,
    ci.nombre AS ciudad_oficina
FROM cliente c
JOIN empleado e ON c.codigo_empleado_rep_ventas = e.id_empleado
JOIN oficina o ON e.codigo_oficina = o.id_oficina
JOIN direccion d ON o.codigo_direccion_o = d.id_direccion
JOIN ciudad ci ON d.codigo_ciudad_d = ci.id_ciudad;

-- 9 listado indicando todas las ciudades donde hay oficinas y el número de empleados que tiene
CREATE VIEW ciudadOficina AS 
SELECT 
    ci.nombre AS ciudad,
    COUNT(e.id_empleado) AS numero_empleados
FROM empleado e
JOIN oficina o ON e.codigo_oficina = o.id_oficina
JOIN direccion d ON o.codigo_direccion_o = d.id_direccion
JOIN ciudad ci ON d.codigo_ciudad_d = ci.id_ciudad
GROUP BY ci.nombre;

-- 10 listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 30 unidades en stock
CREATE VIEW productoGrama AS 
SELECT  p.id_producto, p.nombre, p.cantidad_stock, p.precio_venta
FROM producto AS p
INNER JOIN gama_producto AS g ON g.id_gama = p.codigo_gama
WHERE g.nombre = 'Ornamentales' AND p.cantidad_stock > 15
ORDER BY p.precio_venta DESC;
```

## Procedimientos almacenados 

```sql
-- 1 Insertar un método de pago
DELIMITER $$
DROP PROCEDURE IF EXISTS insert_metodo_pago $$
CREATE PROCEDURE insert_metodo_pago(
    IN metodoPago VARCHAR(15)
)
BEGIN 
    INSERT INTO  metodo_pago (id_metodo_pago, nombre_metodo) VALUES (NULL, metodoPago);
END $$
DELIMITER ;
CALL insert_metodo_pago('Efectivo');

-- 2 Insertar un cargo 
DELIMITER $$
DROP PROCEDURE IF EXISTS insert_cargo $$
CREATE PROCEDURE insert_cargo(
    IN cargo VARCHAR(40)
)
BEGIN 
    INSERT INTO cargo (id_cargo, nombre_cargo) VALUES (NULL, cargo);
END $$
DELIMITER ;
CALL insert_cargo('Portero');

-- 3 Insertar pais
DELIMITER $$
DROP PROCEDURE IF EXISTS insert_pais $$
CREATE PROCEDURE insert_pais(
    IN nombrePais VARCHAR(30)
)
BEGIN 
    INSERT INTO pais (id_pais, nombre) VALUES (NULL, nombrePais);
END $$
DELIMITER ;
CALL insert_pais('Portugal');

-- 4  listado con el código de oficina y la ciudad donde hay oficinas
DELIMITER $$
DROP PROCEDURE IF EXISTS oficina_ciudad $$
CREATE PROCEDURE oficina_ciudad()
BEGIN 
    SELECT o.id_oficina, c.nombre
    FROM oficina AS o
    INNER JOIN direccion AS d ON d.id_direccion = o.codigo_direccion_o
    INNER JOIN ciudad AS c ON c.id_ciudad = d.codigo_ciudad_d;
END $$
DELIMITER ;
CALL oficina_ciudad();

-- 5 listado con el nombre de los todos los clientes españole
DELIMITER $$
DROP PROCEDURE IF EXISTS clientes_españa $$
CREATE PROCEDURE clientes_españa()
BEGIN 
    SELECT c.nombre_cliente
    FROM cliente AS c 
    INNER JOIN ciudad AS ci ON ci.id_ciudad = c.codigo_ciudad_c
    INNER JOIN region AS r ON r.id_region = ci.codigo_region
    INNER JOIN pais AS p ON p.id_pais = r.codigo_pais  
    WHERE p.id_pais = 2;
END $$
DELIMITER ;
CALL clientes_españa();

-- 6 Listar los estados 
DELIMITER $$
DROP PROCEDURE IF EXISTS estado_pedido $$
CREATE PROCEDURE estado_pedido()
BEGIN 
    SELECT nombre_estado FROM estado;
END $$
DELIMITER ;
CALL estado_pedido();

-- 7 Pagos por año
DELIMITER $$
DROP PROCEDURE IF EXISTS promedio_pagos_año $$
CREATE PROCEDURE promedio_pagos_año(
    IN año INT,
    OUT promedio DOUBLE
)
BEGIN 
    SELECT AVG(total) AS pago_medio_2009
    FROM pago
    WHERE YEAR(fecha_pago) = año;
END $$
DELIMITER ;
CALL promedio_pagos_año(2009, @promedio);

-- 8 Eliminar cargo
DELIMITER $$
DROP PROCEDURE IF EXISTS elimiar_cargo $$
CREATE PROCEDURE elimiar_cargo(
    IN id INT(11)
)
BEGIN 
    DELETE FROM cargo WHERE id_cargo =  id;
END $$
DELIMITER ;
CALL elimiar_cargo(7);

-- 9 Actualizar nombre de los metodos de pago
DELIMITER $$
DROP PROCEDURE IF EXISTS actualizar_metodo_pago $$
CREATE PROCEDURE actualizar_metodo_pago(
    IN id INT(11),
    IN metodoPago VARCHAR(15)
)
BEGIN 
    UPDATE metodo_pago SET  nombre_metodo = metodoPago WHERE id_metodo_pago = id;
END $$
DELIMITER ;
CALL actualizar_metodo_pago(4, 'Efectiva');

-- 10 Consultar la dirección de x oficina que tenga clientes
DELIMITER $$
DROP PROCEDURE IF EXISTS direccion_oficina $$
CREATE PROCEDURE direccion_oficina(
    IN id_ciudad INT(11)
)
BEGIN 
    SELECT DISTINCT d.linea_direccion1, d.linea_direccion2
    FROM cliente AS c
    INNER JOIN empleado AS e ON e.id_empleado = c.codigo_empleado_rep_ventas
    INNER JOIN oficina AS o ON o.id_oficina = e.codigo_oficina
    INNER JOIN direccion AS d ON d.id_direccion = o.codigo_direccion_o
    WHERE c.codigo_ciudad_c = id_ciudad; 
END $$
DELIMITER ;
CALL direccion_oficina(2);
```

​	
