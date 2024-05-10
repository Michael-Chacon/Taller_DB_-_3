CREATE DATABASE gardening;
USE gardening;

CREATE TABLE gama_producto(
    id_gama INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    descripcion_texto TEXT NULL,
    descripcion_html TEXT NULL,
    imagen VARCHAR(256) NULL,
    CONSTRAINT PK_gama_producto PRIMARY KEY (id_gama)
)ENGINE = InnoDB;

CREATE TABLE estado(
    id_estado INT AUTO_INCREMENT NOT NULL,
    nombre_estado VARCHAR(20) NOT NULL,
    CONSTRAINT PK_estado PRIMARY KEY(id_estado)
)ENGINE = InnoDB;

CREATE TABLE dimension(
    id_dimension INT AUTO_INCREMENT NOT NULL,
    alto DOUBLE NULL,
    ancho DOUBLE NULL,
    largo DOUBLE NULL,
    CONSTRAINT PK_dimension PRIMARY KEY (id_dimension)
)ENGINE = InnoDB;

CREATE TABLE metodo_pago(
    id_metodo_pago INT AUTO_INCREMENT NOT NULL,
    nombre_metodo VARCHAR(15),
    CONSTRAINT PK_metodo_pago PRIMARY KEY(id_metodo_pago)
)ENGINE = InnoDB;

CREATE TABLE cargo(
    id_cargo INT AUTO_INCREMENT NOT NULL,
    nombre_cargo VARCHAR(40) NOT NULL,
    CONSTRAINT PK_cargo PRIMARY KEY(id_cargo)
)ENGINE = InnoDB;

CREATE TABLE pais(
    id_pais INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    CONSTRAINT PK_pais PRIMARY KEY(id_pais)
)ENGINE = InnoDB;

CREATE TABLE region(
    id_region INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(50) NOT NULL, 
    codigo_pais INT(10) NOT NULL,
    CONSTRAINT PK_region PRIMARY KEY (id_region),
    CONSTRAINT FK_region_pais FOREIGN KEY (codigo_pais) REFERENCES pais(id_pais)
)ENGINE = InnoDB;

CREATE TABLE ciudad(
    id_ciudad INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(30) NOT NULL,
    codigo_region INT(10) NOT NULL,
    CONSTRAINT PK_ciudad PRIMARY KEY (id_ciudad),
    CONSTRAINT FK_ciudad_region FOREIGN KEY (codigo_region) REFERENCES region(id_region)
)ENGINE = InnoDB;

CREATE TABLE tipo_telefono(
    id_tipo_telefono INT AUTO_INCREMENT NOT NULL,
    descripcion VARCHAR(20) NOT NULL,
    CONSTRAINT PK_tipo_telefono PRIMARY KEY(id_tipo_telefono)
)ENGINE = InnoDB;

CREATE TABLE direccion(
    id_direccion INT AUTO_INCREMENT NOT NULL,
    linea_direccion1 VARCHAR(50) NOT NULL,
    linea_direccion2 VARCHAR(50) NULL,
    codigo_ciudad_d INT(10) NOT NULL,
    CONSTRAINT PK_id_direccion PRIMARY KEY (id_direccion),
    CONSTRAINT FK_direccion_ciudad FOREIGN KEY (codigo_ciudad_d) REFERENCES ciudad(id_ciudad)
)ENGINE = InnoDB;

CREATE TABLE proveedor(
    id_proveedor INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    codigo_direccion_p INT(10) NULL,
    CONSTRAINT PK_proveedor PRIMARY KEY (id_proveedor),
    CONSTRAINT FK_proveedor_direccion FOREIGN KEY (codigo_direccion_p) REFERENCES direccion(id_direccion)
)ENGINE = InnoDB;

CREATE TABLE oficina(
    id_oficina INT AUTO_INCREMENT NOT NULL,
    codigo_direccion_o INT(10) NOT NULL,
    CONSTRAINT PK_oficina PRIMARY KEY (id_oficina),
    CONSTRAINT FK_oficina_direccion FOREIGN KEY (codigo_direccion_o) REFERENCES direccion(id_direccion)
)ENGINE = InnoDB;

CREATE TABLE empleado(
    id_empleado INT AUTO_INCREMENT NOT NULL,
    nombre_empleado VARCHAR(50) NOT NULL,
    apellido1 VARCHAR(50) NOT NULL,
    apellido2 VARCHAR(50) NULL,
    extension VARCHAR(10) NOT NULL,
    email VARCHAR(100) NOT NULL,
    id_jefe INT(10) NULL,
    codigo_oficina INT(10) NULL,
    codigo_cargo INT(10) NULL,
    CONSTRAINT PK_emplado PRIMARY KEY(id_empleado),
    CONSTRAINT PK_empleado_oficina FOREIGN KEY (codigo_oficina) REFERENCES oficina(id_oficina),
    CONSTRAINT Pk_empleado_cargo FOREIGN KEY (codigo_cargo) REFERENCES cargo(id_cargo)
)ENGINE = InnoDB;

CREATE TABLE cliente(
    id_cliente INT AUTO_INCREMENT NOT NULL,
    nombre_cliente VARCHAR(50) NOT NULL,
    limite_credito DOUBLE NULL,
    codigo_ciudad_c INT(10) NOT NULL,
    codigo_direccion_c INT(10) NOT NULL,
    codigo_empleado_rep_ventas INT(10) NULL,
    CONSTRAINT PK_cliente PRIMARY KEY(id_cliente),
    CONSTRAINT FK_cliente_ciudad FOREIGN KEY (codigo_ciudad_c) REFERENCES ciudad(id_ciudad),
    CONSTRAINT FK_cliente_direccion FOREIGN KEY (codigo_direccion_c) REFERENCES direccion(id_direccion),
    CONSTRAINT FK_cliente_empleado_rep FOREIGN KEY (codigo_empleado_rep_ventas) REFERENCES empleado(id_empleado)
)ENGINE = InnoDB;

CREATE TABLE contacto(
    id_contacto INT AUTO_INCREMENT NOT NULL,
    nombre_contacto VARCHAR(30) NOT NULL,
    apellido_contacto VARCHAR(30) NOT NULL,
    email_contacto VARCHAR(50) NULL,
    codigo_cliente_co INT NOT NULL,
    CONSTRAINT PK_contacto PRIMARY KEY (id_contacto),
    CONSTRAINT FK_contacto_cliente FOREIGN KEY (codigo_cliente_co) REFERENCES cliente(id_cliente)
)ENGINE = InnoDB;

CREATE TABLE telefono (
  id_telefono INT AUTO_INCREMENT NOT NULL,
  numero BIGINT NOT NULL,
  prefijo TINYINT NULL,
  codigo_cliente_te INT(10) NULL,
  codigo_tipo_telefono INT(10) NOT NULL,
  codigo_oficina_te INT(10) NULL,
  codigo_proveedor_te INT(10) NULL,
  CONSTRAINT PK_telefono PRIMARY KEY (id_telefono),
  CONSTRAINT FK_telefono_cliente FOREIGN KEY (codigo_cliente_te) REFERENCES cliente(id_cliente),
  CONSTRAINT FK_telefono_tipo_telefono FOREIGN KEY (codigo_tipo_telefono) REFERENCES tipo_telefono(id_tipo_telefono),
  CONSTRAINT FK_telefono_proveedor FOREIGN KEY (codigo_proveedor_te) REFERENCES proveedor(id_proveedor),
  CONSTRAINT FK_telefono_oficina FOREIGN KEY (codigo_oficina_te) REFERENCES oficina(id_oficina)
)ENGINE = InnoDB;

CREATE TABLE pago(
    id_pago INT AUTO_INCREMENT NOT NULL,
    fecha_pago DATE NOT NULL,
    total DOUBLE NOT NULL,
    codigo_metodo_pago INT(10) NOT NULL,
    codigo_cliente_pa INT(10) NOT NULL,
    CONSTRAINT PK_pago PRIMARY KEY (id_pago),
    CONSTRAINT FK_pago_metodoPago FOREIGN KEY (codigo_metodo_pago) REFERENCES metodo_pago(id_metodo_pago),
    CONSTRAINT FK_pago_cliente FOREIGN KEY (codigo_cliente_pa) REFERENCES cliente(id_cliente)
)ENGINE = InnoDB;

CREATE TABLE pedido(
    id_pedido INT AUTO_INCREMENT NOT NULL,
    fecha_pedido DATE NOT NULL,
    fecha_esperado DATE NOT NULL,
    fecha_entrega DATE NULL,
    comentario TEXT NULL,
    codigo_client_pedido INT(10) NOT NULL,
    codigo_estado_pedido INT(10) NOT NULL,
    CONSTRAINT PK_pedido PRIMARY KEY(id_pedido),
    CONSTRAINT FK_pedido_cliente FOREIGN KEY (codigo_client_pedido) REFERENCES cliente(id_cliente),
    CONSTRAINT FK_pedido_estado FOREIGN KEY (codigo_estado_pedido) REFERENCES estado(id_estado)
)ENGINE = InnoDB;

CREATE TABLE producto(
    id_producto INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(70) NOT NULL,
    cantidad_stock TINYINT NOT NULL,
    precio_venta DOUBLE NOT NULL,
    precio_proveedor DOUBLE NOT NULL,
    descripcion_producto TEXT NULL,
    codigo_gama INT(10) NOT NULL,
    codigo_dimension INT(10) NULL,
    CONSTRAINT PK_producto PRIMARY KEY (id_producto),
    CONSTRAINT FK_producto_gama FOREIGN KEY (codigo_gama) REFERENCES gama_producto(id_gama),
    CONSTRAINT FK_producto_dimension FOREIGN KEY (codigo_dimension) REFERENCES dimension(id_dimension)
)ENGINE = InnoDB;

CREATE TABLE detalle_pedido(
    id_producto_pedido INT NOT NULL,
    id_pedido_producto INT NOT NULL,
    cantidad SMALLINT NOT NULL,
    precio_unidad DOUBLE NULL,
    numero_linea SMALLINT NULL,
    PRIMARY KEY (id_producto_pedido, id_pedido_producto),
    CONSTRAINT FK_producto_pedido FOREIGN KEY (id_producto_pedido) REFERENCES producto(id_producto),
    CONSTRAINT FK_pedido_producto FOREIGN KEY (id_pedido_producto) REFERENCES pedido(id_pedido)
)ENGINE = InnoDB;

CREATE TABLE proveedor_producto(
    id_proveedor_producto INT NOT NULL,
    id_producto_proveedor INT NOT NULL,
    PRIMARY KEY (id_proveedor_producto, id_producto_proveedor),
    CONSTRAINT FK_proveedor_producto FOREIGN KEY (id_proveedor_producto) REFERENCES proveedor(id_proveedor),
    CONSTRAINT FK_producto_proveedor FOREIGN KEY (id_producto_proveedor) REFERENCES producto(id_producto)
)ENGINE = InnoDB;

