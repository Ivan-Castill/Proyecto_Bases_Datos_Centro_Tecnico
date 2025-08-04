

-- -------------------------------------------------------------------------------------------------------
-- Creación de usuarios y roles en MySQL

-- Usuario Administrador
CREATE USER 'admin_ct'@'localhost' IDENTIFIED BY 'AdminPass123!';

-- Usuario Secretario
CREATE USER 'secretario_ct'@'localhost' IDENTIFIED BY 'SecretPass123!';

-- Usuario Técnico
CREATE USER 'tecnico_ct'@'localhost' IDENTIFIED BY 'TecnicPass123!';

-- -----------------------------------------------------------------------------------------------------------------------------
-- Privilegios con GRANT y REVOKE

-- Privilegios para Administrador (acceso total)
GRANT ALL PRIVILEGES ON centro_tecnico_db.* TO 'admin_ct'@'localhost';

-- Privilegios para Secretario (solo lectura y permisos para gestionar clientes, citas, etc.)
GRANT SELECT, INSERT, UPDATE ON centro_tecnico_db.clientes TO 'secretario_ct'@'localhost';
GRANT SELECT, INSERT, UPDATE ON centro_tecnico_db.ordenes_trabajo TO 'secretario_ct'@'localhost';
GRANT SELECT ON centro_tecnico_db.personal TO 'secretario_ct'@'localhost';

-- Privilegios para Técnico (solo acceso a diagnosticos y reparaciones)
GRANT SELECT, INSERT, UPDATE ON centro_tecnico_db.diagnostico_tecnico TO 'tecnico_ct'@'localhost';
GRANT SELECT, INSERT, UPDATE ON centro_tecnico_db.reparaciones TO 'tecnico_ct'@'localhost';

-- Aplicar cambios
FLUSH PRIVILEGES;

-- revocar un privilegio
REVOKE INSERT ON centro_tecnico_db.clientes FROM 'secretario_ct'@'localhost';
FLUSH PRIVILEGES;

-- -----------------------------------------------------------------------------------------------------------------
-- Cifrado con SHA2 y AES_ENCRYPT


INSERT INTO usuarios (usuario, contraseña, rol) VALUES
('admin', SHA2('AdminPass123!', 256), 'Administrador'),
('secretario', SHA2('SecretPass123!', 256), 'Secretario'),
('tecnico', SHA2('TecnicPass123!', 256), 'Tecnico');


-- Encriptar datos sensibles con AES_ENCRYPT

-- Actualizar tabla para almacenar datos cifrados (varbinary)
ALTER TABLE clientes MODIFY correo VARBINARY(256);
ALTER TABLE clientes MODIFY telefono VARBINARY(256);

-- Insertar datos cifrados
INSERT INTO clientes (nombres, apellidos, cedula, correo, telefono, direccion)
VALUES (
  'Juan',
  'Pérez',
  '1234567890',
  AES_ENCRYPT('juan.perez@example.com', 'clave_secreta'),
  AES_ENCRYPT('0991234567', 'clave_secreta'),
  'Calle Falsa 123'
);

-- Para leer los datos descifrados
SELECT
  nombres,
  apellidos,
  cedula,
  AES_DECRYPT(correo, 'clave_secreta') AS correo_descifrado,
  AES_DECRYPT(telefono, 'clave_secreta') AS telefono_descifrado,
  direccion
FROM clientes;

-- -----------------------------------------------------------------------------------------------------------------------------------
-- Simulación de inyección SQL y protección

SET @user_input = "'; DROP TABLE clientes; --";

SET @query = CONCAT('SELECT * FROM usuarios WHERE usuario = ''', @user_input, '''');

PREPARE stmt FROM @query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;


PREPARE stmt FROM 'SELECT * FROM usuarios WHERE usuario = ?';
SET @username = 'usuario_seguro';
EXECUTE stmt USING @username;
DEALLOCATE PREPARE stmt;




