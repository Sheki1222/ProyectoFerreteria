
-- Crear base de datos
CREATE DATABASE IF NOT EXISTS ferreteria;
USE ferreteria;

-- Tabla de roles
CREATE TABLE roles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Tabla de usuarios (para login)
CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50) UNIQUE,
    contrasena VARCHAR(255),
    rol_id INT,
    FOREIGN KEY (rol_id) REFERENCES roles(id)
);

-- Tabla de cajeros (datos personales)
CREATE TABLE cajeros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT UNIQUE,
    nombre VARCHAR(100),
    correo VARCHAR(100),
    contrasena VARCHAR(255),
    cedula VARCHAR(20),
    direccion VARCHAR(255),
    telefono VARCHAR(20),
    foto_perfil VARCHAR(255),
    fecha_ingreso DATE,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);

-- Tabla de clientes
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    cedula VARCHAR(20) UNIQUE,
    correo VARCHAR(100),
    telefono VARCHAR(20),
    direccion VARCHAR(255)
);

-- Tabla de proveedores
CREATE TABLE proveedores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_empresa VARCHAR(100),
    categoria VARCHAR(100),
    persona_contacto VARCHAR(100),
    telefono VARCHAR(20),
    direccion VARCHAR(255),
    correo VARCHAR(100)
);

-- Tabla de categorías
CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT
);

-- Tabla de productos
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT,
    precio DECIMAL(10,2),
    stock INT,
    stock_minimo INT,
    ubicacion_almacen VARCHAR(100),
    imagen VARCHAR(255),
    categoria_id INT,
    proveedor_id INT,
    FOREIGN KEY (categoria_id) REFERENCES categorias(id),
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(id)
);

-- Tabla de inventario (registro por producto)
CREATE TABLE inventario (
    id INT AUTO_INCREMENT PRIMARY KEY,
    producto_id INT,
    tipo_movimiento ENUM('entrada', 'salida'),
    cantidad INT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    proveedor_id INT,
    categoria_id INT,
    stock_actual INT,
    stock_maximo INT,
    stock_minimo INT,
    ubicacion VARCHAR(100),
    FOREIGN KEY (producto_id) REFERENCES productos(id),
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(id),
    FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

-- Tabla de facturas
CREATE TABLE facturas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    cajero_id INT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    subtotal DECIMAL(10,2),
    iva DECIMAL(10,2),
    total DECIMAL(10,2),
    forma_pago VARCHAR(50),
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (cajero_id) REFERENCES cajeros(id)
);

-- Detalle de factura
CREATE TABLE detalle_factura (
    id INT AUTO_INCREMENT PRIMARY KEY,
    factura_id INT,
    producto_id INT,
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    subtotal DECIMAL(10,2),
    iva DECIMAL(10,2),
    total DECIMAL(10,2),
    FOREIGN KEY (factura_id) REFERENCES facturas(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Tabla de devoluciones
CREATE TABLE devoluciones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    factura_id INT,
    producto_id INT,
    cantidad INT,
    motivo TEXT,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (factura_id) REFERENCES facturas(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);
