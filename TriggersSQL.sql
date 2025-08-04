-- Proyecto de Bases de Datos
-- Ivan Andres Castillo Caiza
use centro_tecnico_db;

-- Triggers SQL

-- Registrar creación, actualización y eliminación de usuarios.

create table auditoria_usuarios (
    id int auto_increment primary key,
    tipo_accion enum('INSERT','UPDATE','DELETE'),
    usuario_afectado varchar(100),
    rol varchar(50),
    fecha timestamp default current_timestamp,
    usuario_bd varchar(100),
    descripcion text
);

delimiter $$

create trigger auditoria_insert_usuario
after insert on usuarios
for each row
begin
    insert into auditoria_usuarios(tipo_accion, usuario_afectado, rol, usuario_bd, descripcion)
    values ('INSERT', new.usuario, new.rol, current_user(), concat('Nuevo usuario agregado: ', new.usuario));
end$$

create trigger auditoria_update_usuario
after update on usuarios
for each row
begin
    insert into auditoria_usuarios(tipo_accion, usuario_afectado, rol, usuario_bd, descripcion)
    values ('UPDATE', new.usuario, new.rol, current_user(), concat('Usuario actualizado: ', new.usuario));
end$$

create trigger auditoria_delete_usuario
after delete on usuarios
for each row
begin
    insert into auditoria_usuarios(tipo_accion, usuario_afectado, rol, usuario_bd, descripcion)
    values ('DELETE', old.usuario, old.rol, current_user(), concat('Usuario eliminado: ', old.usuario));
end$$

delimiter ;

-- Registro histórico de cambios en ordenes_trabajo, cambios en técnico asignado o diagnóstico
create table historial_ordenes_trabajo (
    historial_id int auto_increment primary key,
    orden_id int,
    personal_anterior int,
    personal_nuevo int,
    diagnostico_anterior int,
    diagnostico_nuevo int,
    fecha_cambio timestamp default current_timestamp,
    usuario_bd varchar(100)
);

delimiter $$

create trigger historial_update_orden_trabajo
before update on ordenes_trabajo
for each row
begin
    if old.personal_id <> new.personal_id or old.diagnostico_id <> new.diagnostico_id then
        insert into historial_ordenes_trabajo(
            orden_id,
            personal_anterior, personal_nuevo,
            diagnostico_anterior, diagnostico_nuevo,
            usuario_bd
        )
        values (
            old.orden_id,
            old.personal_id, new.personal_id,
            old.diagnostico_id, new.diagnostico_id,
            current_user()
        );
    end if;
end$$

delimiter ;

-- Registrar en una tabla de auditoría el evento de una nueva reparación.

create table auditoria_reparaciones (
    id int auto_increment primary key,
    reparacion_id int,
    cliente_id int,
    aparato_id int,
    tecnico_id int,
    fecha_registro timestamp default current_timestamp,
    usuario_bd varchar(100),
    descripcion text
);

delimiter $$

create trigger auditoria_insert_reparacion
after insert on reparaciones
for each row
begin
    insert into auditoria_reparaciones(
        reparacion_id, cliente_id, aparato_id, tecnico_id, usuario_bd, descripcion
    )
    values (
        new.reparacion_id, new.cliente_id, new.aparato_id, new.ordenes_t_id,
        current_user(),
        concat('Se registró una nueva reparación con ID ', new.reparacion_id)
    );
end$$

delimiter ;

-- Validación y control automático: baja de stock de repuestos usados

delimiter $$

create trigger controlar_stock_repuestos
before insert on repuestos_usados
for each row
begin
    declare stock_actual int;

    select stock into stock_actual from repuestos where repuesto_id = new.repuesto_id;

    if stock_actual < new.cantidad then
        signal sqlstate '45000' set message_text = 'Stock insuficiente para este repuesto.';
    else
        update repuestos set stock = stock - new.cantidad where repuesto_id = new.repuesto_id;
    end if;
end$$

delimiter ;

-- Simulación de envío de notificaciones (registro de acciones sensibles)

create table notificaciones_simuladas (
    notificacion_id int auto_increment primary key,
    fecha timestamp default current_timestamp,
    accion text,
    usuario varchar(100)
);

delimiter $$

create trigger notificar_orden_pago
after insert on ordenes_reparacion
for each row
begin
    insert into notificaciones_simuladas(accion, usuario)
    values (concat('Se generó una orden de reparación para el cliente en orden ID: ', new.orden_r_id), current_user());
end$$

delimiter ;

-- Registro histórico de cambios relevantes en precio

create table historial_precios (
    historial_id int auto_increment primary key,
    precio_id int,
    aparato_id int,
    cliente_id int,
    precio_anterior decimal(10,2),
    nuevo_precio decimal(10,2),
    fecha_cambio timestamp default current_timestamp,
    usuario varchar(100)
);

delimiter $$

create trigger historial_cambios_precio
before update on precio
for each row
begin
    if old.precio <> new.precio then
        insert into historial_precios(precio_id, aparato_id, cliente_id, precio_anterior, nuevo_precio, usuario)
        values (old.precio_id, old.aparato_id, old.cliente_id, old.precio, new.precio, current_user());
    end if;
end$$

delimiter ;
