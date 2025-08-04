-- Proyecto bases de datos
-- Ivan Andres Castillo Caiza
-- Registros de datos a la base de datos
-- clientes
use centro_tecnico_db;
INSERT INTO clientes (nombres, apellidos, cedula, correo, telefono, direccion)
VALUES 
('Ivan Andres', 'Castillo Caiza', '1718298156', 'ivan.castillo@gmail.com', '0982158101', 'Av. Central 101'),
('Daniel Jefferson', 'Guano Quilumba', '7121546598', null, '0987273196', 'Av.Isidro Ayora'),
('Edwin Alexander', 'Sarango Canar', '1798546268', 'edwin.sarango@gmail.com', '0968911731', 'Av. Central 102'),
('Francesco', 'Chalaco Sarango', '7148956230', null, '0963673666', 'Av. Central 106'),
('Lucía Rocio', 'Vera Perez', '1728956482', 'lucia.vera@hotmail.com','0901122334','Calle Falsa 123');


-- Personal
INSERT INTO personal (nombres, apellidos, telefono, correo, rol)
VALUES 
('Ivan Andres', 'Castillo Caiza', '09982158101', 'ivan.castillo@centrotecnico.com', 'Tecnico'),
('Rocio Elizabeth', 'Caiza Perez', '0988123456', 'rocio.caiza@centrotecnico.com', 'Secretario'),
('Kerly Daniela', 'Catillo Caiza', '0975178956', 'kerly.castillo@centrotecnico.com', 'Secretario'),
('Ismael Francisco', 'Castillo Caiza', '0993728381', 'ismael.castillo@centrotecnico.com', 'Tecnico'),
('Norge Ivan', 'Castillo Nunez', '0993728712', 'norge.castillo@centrotecnico.com', 'Tecnico');


-- Especialidades
INSERT INTO especialidades (especialidad)
VALUES 
('Electrodomésticos'), 
('Celulares'),
('Televisiones'),
('Laptop'),
('Linea Blanca'),
('Software'),
('PC');

-- especialidad al tecnico
INSERT INTO personal_especialidades (personal_id, especialidad_id)
VALUES 
(1, 1),
(4, 2),
(4,6),
(5,3),
(5,1),
(5,5),
(1,3),
(1,4),
(1,5),
(1,6),
(1,7);  -- Ana Torres tiene ambas

-- aparatos ingresados
INSERT INTO aparatos (cliente_id, nombre_a, marca, modelo, color)
VALUES
(1, 'Licuadora', 'Oster', 'O123', 'Rojo'),
(2, 'Celular', 'Samsung', 'Galaxy A21s', 'Negro'),
(3, 'Impresora', 'Epson', 'XP 340', 'Negro'),
(4, 'Laptop', 'HP', 'GalaxyAsus 56', 'Naranja'),
(5, 'Lavadora', 'Samsung', 'lut5 68', 'Blanco');

-- Diagnostico
INSERT INTO diagnosticos (cliente_id, aparato_id, diagnostico)
VALUES
(1, 1, 'El motor no gira correctamente.'),
(2, 2, 'Pantalla rota, no enciende.'),
(3, 3, 'Mantenimiento, rellenar la tinta'),
(4, 4, 'Formateo , esta muy lenta'),
(5, 5, 'No sale agua, No arranca el motor');

-- Orden de trabajo 
INSERT INTO ordenes_trabajo (cliente_id, aparato_id, personal_id, diagnostico_id)
VALUES
(1, 1, 2, 1), 
(2, 2, 3, 2),
(3, 3, 2, 3),
(4, 4, 3, 4),
(5, 5, 3, 5);  

-- Asignar Tecnico a la orde de trabajo
INSERT INTO ordenes_tecnicos (orden_id, personal_id)
VALUES 
(1, 5),
(2, 4),
(3, 1),
(4, 1),
(5, 5); 

-- Diagnostico tecnico
INSERT INTO diagnostico_tecnico (cliente_id, aparato_id, ordenes_t_id, diagnostico_t)
VALUES
(1, 1, 1, 'Se quemó el motor. Requiere cambio.'),
(2, 2, 2, 'Pantalla quebrada, batería inflada.'),
(3, 3, 3, 'Mantenimiento, recarga de tinta.'),
(4, 4, 4, 'Cambio de disco duro a una SSD, instalacion de sistema operativo.'),
(5, 5, 5, 'Cambio de bambas de agua, cambio de capacitor.');

-- Repuestos 
INSERT INTO repuestos (nombre, descripcion, precio, stock)
VALUES
('Motor Oster', 'Motor compatible con licuadora Oster', 25.50, 10),
('Pantalla Samsung A21s', 'Repuesto original', 35.00, 9),
('Bateria Samsung A21s', 'Repuesto original', 15.00, 12),
('Pack tintas de impresora', 'Repuesto original', 20.00, 8),
('Disco Duro SSD', 'Repuesto original', 45.00, 7),
('Bombas de Agua', 'Repuesto original', 35.00, 6),
('Capacitor lg', 'Repuesto original', 10.00, 5);

-- precio por reparacion
INSERT INTO precio (cliente_id, aparato_id, precio)
VALUES 
(1, 1, 40.00),
(2, 2, 75.00),
(3, 3, 55.00),
(4, 4, 70.00),
(5, 5, 75.00);

-- Reparacion
INSERT INTO reparaciones (cliente_id, aparato_id, ordenes_t_id, diagnostico_t_id)
VALUES 
(1, 1, 1, 1),
(2, 2, 2, 2),
(3, 3, 3, 3),
(4, 4, 4, 4),
(5, 5, 5, 5);

-- Repuestos Usados
INSERT INTO repuestos_usados (repuesto_id, reparacion_id, cantidad)
VALUES 
(1,1,1),
(2,2,1),
(3,2,1),
(4,3,1),
(5,4,1),
(6,5,1),
(7,5,1);


-- orden de reparacion
INSERT INTO ordenes_reparacion (reparacion_id, ordenes_t_id, precio_id, forma_pago, estado_pago)
VALUES 
(1, 1, 1, 'Efectivo', 'Pagado'),
(2, 2, 2, null, 'No Pagado'),
(3, 3, 3, 'Trasferencia', 'Pagado'),
(4, 4, 4, null, 'No Pagado'),
(5, 5, 5, 'Efectivo', 'Pagado');

-- pago ingresado
INSERT INTO pagos_ingresados (orden_r_id, pagos_i, forma_pago)
VALUES 
(1, 40.00, 'Efectivo'),
(3, 55.00, 'Trasferencia'),
(5, 75.00, 'Efectivo');

-- herramientas
INSERT INTO herramientas (nombre, estado)
VALUES
('Destornillador eléctrico', 'Bueno'),
('Destornillador','Malo'),
('Multímetro digital', 'Bueno'),
('Soldador', 'Medio'),
('Cable tipo mirco USB','Medio'),
('Pinza de precisión', 'Bueno');

-- Aparatos en Invetario
INSERT INTO aparatos_inventario (nombre_a, marca, modelo, color, observación, tipo)
VALUES
('Microondas', 'LG', 'MH604', 'Gris', 'Funciona correctamente, sin uso reciente.', 'Adquirido'),
('Licuadora', 'Oster', 'Classic 3V', 'Blanco', 'Presenta ralladuras leves.', 'Remate');

-- Insertar clientes a domicilio
INSERT INTO clientes_domicilio (nombre, apellido, telefono, direccion)
VALUES
('Pedro', 'Quintana', '0991234567', 'Av. 9 de Octubre y Rocafuerte'),
('María', 'López', '0987456123', 'Cdla. Las Orquídeas, Mz 24, Solar 5');

-- Insertar aparatos a domicilio
INSERT INTO aparatos_domicilio (nombre_aparato, marca, modelo, color, observación)
VALUES
('Refrigeradora', 'Samsung', 'CoolMax', 'Plateado', 'Hace ruido al encender'),
('Televisor', 'Sony', 'Bravia 32"', 'Negro', 'No da imagen');

-- Insertar peticiones a domicilio
INSERT INTO peticion_a_domicilio (cliente_domi_id, aparato_domi_id)
VALUES
(1, 1),
(2, 2);

-- Usuarios
INSERT INTO usuarios (usuario, contraseña, rol)
VALUES
('admin', 'admin123', 'Administrador'),
('ivan_tecnico', 'tecnicopass', 'Tecnico'),
('rocio_secret', 'secretario123', 'Secretario');


