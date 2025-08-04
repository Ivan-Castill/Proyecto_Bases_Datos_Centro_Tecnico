-- Proyecto de Bases de Datos
-- Ivan Andres Castillo Caiza
use centro_tecnico_db;

-- Procedimientos Almacenados

-- 1. Ingreso de un nuevo ordene de trabajo, aparato con diacnostico y registro de cliente
delimiter $$
create procedure ingreso_ordenTrabajo_aparato_cliente_diagnostico(
	in p_nombres varchar(100),
    in p_apellidos varchar(100),
    in p_cedula varchar(20),
	in p_correo varchar(100),
    in p_telefono varchar(20),
    in p_direccion text,
    in p_nombre_a varchar(100),
    in p_marca varchar(100),
    in p_modelo varchar(100),
    in p_color varchar(100),
    in p_diagnostico text,
    in p_nombre_personal varchar(100)
)
begin
	
    
	declare v_cliente_id int;
    declare v_aparato_id int; 
    declare v_diagnostico_id int;
    declare v_id_personal int;
    declare v_id_ordenes_trabajo int;
    declare exit handler for sqlexception
    begin
		rollback;
        signal sqlstate '45000'
        set message_text = 'Error: No se pudo ejecutar el registro.';
    end;
    
    start transaction;
    
    -- recgistro cliente
	insert into clientes(nombres,apellidos,cedula,correo,telefono,direccion)
    values (p_nombres,p_apellidos,p_cedula,p_correo,p_telefono,p_direccion);
    
    -- optener la id de cliente
    set v_cliente_id = last_insert_id();
    
    -- registro aparatos
    insert into aparatos(cliente_id,nombre_a,marca,modelo,color)
    values (v_cliente_id,p_nombre_a,p_marca,p_modelo,p_color);
    
    -- optener la id de aparatos
    set v_aparato_id = last_insert_id();
    
    -- registro diagnostico
    insert into diagnosticos(cliente_id,aparato_id,diagnostico)
    values (v_cliente_id,v_aparato_id,p_diagnostico);
    
    -- optiene la id de diagnostico
    set v_diagnostico_id = last_insert_id();
    
	-- consulta sobre personal asociado al registro del ingreso del aparatado.
	select personal_id into v_id_personal
    from personal
    where nombres = p_nombre_personal and rol = 'Secretario';
    
	if v_id_personal is null then
		signal sqlstate '45000'
        set message_text = 'Error: No se encontró un secretario con ese nombre.';
	end if;
    
    -- registro de orden de trabajo
    insert into ordenes_trabajo(cliente_id,aparato_id,personal_id,diagnostico_id)
    values (v_cliente_id,v_aparato_id,v_id_personal,v_diagnostico_id);
    
    set v_id_ordenes_trabajo = last_insert_id();
    -- registro de orden_id en la orde para el  tecnico. 
    insert into ordenes_tecnico(orden_id)
    values (v_id_ordenes_trabajo);
    
    commit;
    
end $$
delimiter ;

-- 2. dar una especialida a los tecnico de la tabla personal en la tabla personal_especialidas.

delimiter $$
	create procedure asignar_especialidad_personal(
		in p_nombres varchar(100),
        in p_especialidad varchar(100)
    )
    begin
		
    
		declare v_personal_id int;
        declare v_especialidad_id int;
        declare exit handler for sqlexception
		begin
			rollback;
			signal sqlstate '45000'
			set message_text = 'Error: No se pudo asignar especialidad. Se hizo rollback.';
		end;
        
        start transaction;
        
        select personal_id into v_personal_id
        from personal
        where p_nombres = nombres;
        
        if v_personal_id is null then
			signal sqlstate '45000'
            set message_text = 'Error: Ese nombre del personal no esta registrado.';
		end if;
        
        select especialidad_id into v_especialidad_id
        from especialidades
        where especialidad = p_especialidad;
        
        if v_especialidad_id is null then
			signal sqlstate '45000'
            set message_text = 'Error: Esa especialidad no esta registrado.';
		end if;
        
        insert into personal_especialidades(personal_id,especialidad_id)
        values (v_personal_id,v_especialidad_id);
        
        commit;
        
    end $$
delimiter ;

-- 3. Asignar tecnico a la orde de trabajo.
delimiter $$
	create procedure asignar_tecnico_ordentrabajo(
		in p_orden_id int,
		in p_nombres_t varchar(100)
        
    )
    begin
		declare v_orden_id int;
		declare v_personal_id int;
        declare v_ordenes_t_id int;
        declare v_aparato_id int;
        declare v_cliente_id int;
        -- para el manejo de errores
        declare exit handler for sqlexception
        begin
			rollback;
            signal sqlstate '45000'
            set message_text = 'Error: Ocurrió un problema durante la asignación del técnico.';
        end;
        
        start transaction;
        
        -- verificacmos q exita la orden_id
        if not exists (select 1 from ordenes_trabajo where orden_id = p_orden_id) then
			rollback;
            signal sqlstate '45000'
            set message_text = 'Error: La orden de trabajo no existe.';
		end if;
        
        -- optener el id del tecnico
        select personal_id into v_personal_id
        from personal
        where nombres = p_nombres_t and rol = 'Tecnico';
        
        -- validacion
        if v_personal_id is null then
			rollback;
            signal sqlstate '45000'
            set message_text = 'Error: Técnico no encontrado.';
        end if;
        
        -- actualizar ordenes_tecnicos con el tecnico asignado.
        update ordenes_tecnicos
        set personal_id = v_personal_id
        where orden_id = p_orden_id;
        
        -- optener ids para el diagnostico tecnico
        select
			ot.aparato_id,
            ot.cliente_id,
            otx.ordenes_t_id
		into
			v_aparato_id,
            v_cliente_id,
            v_ordenes_t_id
		from ordenes_trabajo ot
        join ordenes_tecnicos otx on ot.orden_id = otx.orden_id
        where ot.orden_id = p_orden_id;
        
        insert into diagnostico_tecnico (cliente_id, aparato_id, ordenes_t_id)
        values (v_cliente_id, v_aparato_id, v_ordenes_t_id);
        -- ingreso de datos en la tabla precios
        insert into precio(cliente_id, aparato_id)
        values (v_cliente_id, v_aparato_id);
        -- ingreso de datos en la tabla reparaciones
        insert into reparaciones(cliente_id, aparato_id, ordenes_t_id)
        values (v_cliente_id, v_aparato_id, v_ordenes_t_id);
        commit;
        
    end $$
delimiter ;

-- 4. Registro de diagnostico tecnico

delimiter $$
	create procedure diagnostico_tecnico(
		in p_ordenes_t_id int,
		in p_diagnostico text
	)
	begin
		declare v_ordenes_t_id int;
        declare v_diagnostico_t_id int;
        
        start transaction;
        -- verificamos que exita la orden asignada para el diagnostico tecnico.
        if not exists (select 1 from diagnostico_tecnico where ordenes_t_id = p_ordenes_t_id) then
			rollback;
            signal sqlstate '45000'
            set message_text = 'Error: La orden al técnico no existe.';
		end if;
        
        update diagnostico_tecnico
        set diagnostico_t = p_diagnostico
        where ordenes_t_id = p_ordenes_t_id;
        
        -- optener al id para la tabla reparaciones. 
        select diagnostico_t_id into v_diagnostico_t_id
        from diagnostico_tecnico
        where ordenes_t_id = p_ordenes_t_id;
        
        update reparaciones
        set diagnostico_t_id = v_diagnostico_t_id
        where ordenes_t_id = p_ordenes_t_id;
        
	end $$
delimiter ;

-- 5. registro del precio 
 delimiter $$
 create procedure registro_precio (
	in p_cliente_id int,
	in p_aparato_id int,
    in p_precio decimal(10,2)
 )
 begin
    
    start transaction;
    
    if not exists (select 1 from precio where cliente_id = p_cliente_id and aparato_id = p_aparato_id) then
		rollback;
        signal sqlstate '45000'
        set message_text = 'Error: id de cliente o aparato incorrecto.';
	end if;
    
    update precio
    set precio = p_precio
    where cliente_id = p_cliente_id and aparato_id = p_aparato_id;
    
    commit;
    
 end $$
 delimiter ;
 
-- 6. registro de ordenes de reparacion

DELIMITER $$

create procedure registro_orden_reparacion(
	in p_reparacion_id int,
	in p_ordenes_t_id int,
	in p_precio_id int,
	in p_forma_pago enum('Efectivo','Trasferencia'),
	in p_estado_pago enum('Pagado','No Pagado')
)
begin
	-- Declaración de variables si las necesitas
	declare v_orden_r_id int;

-- iniciamos la transacción
start transaction;

-- validaciones básicas
if not exists (select 1 from reparaciones where reparacion_id = p_reparacion_id) then
    rollback;
    signal sqlstate '45000'
    set message_text = 'Error: Reparación no registrada.';
end if;

if not exists (select 1 from ordenes_tecnicos where ordenes_t_id = p_ordenes_t_id) then
    rollback;
    signal sqlstate '45000'
    set message_text = 'Error: Orden de técnico no registrada.';
end if;

if not exists (select 1 from precio where precio_id = p_precio_id) then
    rollback;
    signal sqlstate '45000'
    set message_text = 'Error: Precio no registrado.';
end if;

-- registro de la orden de reparación
insert into ordenes_reparacion (
    reparacion_id,
    ordenes_t_id,
    precio_id,
    forma_pago,
    estado_pago
) values (
    p_reparacion_id,
    p_ordenes_t_id,
    p_precio_id,
    p_forma_pago,
    p_estado_pago
);

-- confirmamos la transacción
commit;

end $$
delimiter ;

-- 7. Registro de Repuestos

delimiter $$

create procedure registrar_repuesto(
    in p_nombre varchar(100),
    in p_marca varchar(100),
    in p_stock int,
    in p_precio decimal(10,2)
)
begin
    declare exit handler for sqlexception
    begin
        rollback;
        signal sqlstate '45000' set message_text = 'Error: No se pudo registrar el repuesto.';
    end;

    start transaction;

    insert into repuestos (nombre, marca, stock, precio)
    values (p_nombre, p_marca, p_stock, p_precio);

    commit;
end$$
delimiter ;

-- 8. Registro de Repuestos Usados

delimiter $$
create procedure registrar_repuesto_usado(
    in p_reparacion_id int,
    in p_repuesto_id int,
    in p_cantidad int
)
begin
    declare exit handler for sqlexception
    begin
        rollback;
        signal sqlstate '45000' set message_text = 'Error: No se pudo registrar el repuesto usado.';
    end;

    start transaction;

    if not exists (select 1 from reparaciones where reparacion_id = p_reparacion_id) then
        signal sqlstate '45000' set message_text = 'Error: Reparación no existe.';
    end if;

    if not exists (select 1 from repuestos where repuesto_id = p_repuesto_id) then
        signal sqlstate '45000' set message_text = 'Error: Repuesto no existe.';
    end if;

    insert into repuestos_usados (reparacion_id, repuesto_id, cantidad)
    values (p_reparacion_id, p_repuesto_id, p_cantidad);

    update repuestos 
    set stock = stock - p_cantidad
    where repuesto_id = p_repuesto_id;

    commit;
end$$
delimiter ;

-- 9. Registro de Herramientas

delimiter $$
create procedure registrar_herramienta(
    in p_nombre varchar(100),
    in p_estado enum('Bueno','Medio','Malo')
)
begin
    declare exit handler for sqlexception
    begin
        rollback;
        signal sqlstate '45000' set message_text = 'Error: No se pudo registrar la herramienta.';
    end;

    start transaction;

    insert into herramientas (nombre, estado)
    values (p_nombre, p_estado);

    commit;
end$$
delimiter ;

-- 10. Registro de Aparatos en Inventario

delimiter $$
create procedure registrar_aparato_inventario(
    in p_nombre varchar(100),
    in p_marca varchar(100),
    in p_modelo varchar(100),
    in p_color varchar(100),
    in p_observacion text,
    in p_tipo enum('Adquirido','Remate')
)
begin
    declare exit handler for sqlexception
    begin
        rollback;
        signal sqlstate '45000' set message_text = 'Error: No se pudo registrar el aparato en inventario.';
    end;

    start transaction;

    insert into aparatos_inventario (nombre_a, marca, modelo, color, observación, tipo)
    values (p_nombre, p_marca, p_modelo, p_color, p_observacion, p_tipo);

    commit;
end$$
delimiter ;

-- 11. Registro de Petición a Domicilio

delimiter $$
create procedure registrar_pedido_domicilio(
    in p_nombre_cliente varchar(100),
    in p_apellido_cliente varchar(100),
    in p_telefono_cliente varchar(20),
    in p_direccion_cliente text,
    in p_nombre_aparato varchar(100),
    in p_marca_aparato varchar(100),
    in p_modelo_aparato varchar(100),
    in p_color_aparato varchar(100),
    in p_observacion_aparato text
)
begin
    declare v_cliente_domi_id int;
    declare v_aparato_domi_id int;

    declare exit handler for sqlexception
    begin
        rollback;
        signal sqlstate '45000' set message_text = 'Error: No se pudo registrar la petición a domicilio.';
    end;

    start transaction;

    insert into clientes_domicilio (nombre, apellido, telefono, direccion)
    values (p_nombre_cliente, p_apellido_cliente, p_telefono_cliente, p_direccion_cliente);

    set v_cliente_domi_id = last_insert_id();

    insert into aparatos_domicilio (nombre_aparato, marca, modelo, color, observación)
    values (p_nombre_aparato, p_marca_aparato, p_modelo_aparato, p_color_aparato, p_observacion_aparato);

    set v_aparato_domi_id = last_insert_id();

    insert into peticion_a_domicilio (cliente_domi_id, aparato_domi_id)
    values (v_cliente_domi_id, v_aparato_domi_id);

    commit;
end$$
delimiter ;

-- 12. Registro de Usuarios

delimiter $$
create procedure registrar_usuario(
    in p_usuario varchar(100),
    in p_contrasena varchar(100),
    in p_rol enum('Administrador','Tecnico','Secretario')
)
begin
    declare exit handler for sqlexception
    begin
        rollback;
        signal sqlstate '45000' set message_text = 'Error: No se pudo registrar el usuario.';
    end;

    start transaction;

    if exists (select 1 from usuarios where usuario = p_usuario) then
        signal sqlstate '45000' set message_text = 'Error: El usuario ya existe.';
    end if;

    insert into usuarios (usuario, contraseña, rol)
    values (p_usuario, p_contrasena, p_rol);

    commit;
end$$
delimiter ;

-- 13. Eliminar un cliente pero solo si no tiene órdenes de trabajo o aparatos asociados

delimiter $$

create procedure eliminar_cliente_seguro(
    in p_cliente_id int
)
begin
    declare v_count_ordenes int;
    declare v_count_aparatos int;
    declare exit handler for sqlexception
    begin
        rollback;
        signal sqlstate '45000' set message_text = 'Error: No se pudo eliminar el cliente.';
    end;

    start transaction;

    select count(*) into v_count_ordenes from ordenes_trabajo where cliente_id = p_cliente_id;
    select count(*) into v_count_aparatos from aparatos where cliente_id = p_cliente_id;

    if v_count_ordenes > 0 or v_count_aparatos > 0 then
        signal sqlstate '45000' set message_text = 'Error: No se puede eliminar cliente con órdenes o aparatos asociados.';
    else
        delete from clientes where cliente_id = p_cliente_id;
    end if;

    commit;
end$$
delimiter ;

-- 14. Actualizar el estado de varios aparatos que están "Recibidos" a "Reparado"

delimiter $$

create procedure actualizar_estado_aparatos(
    in p_cliente_id int,
    in p_estado_actual enum('Recibido','Reparado','Entregado'),
    in p_estado_nuevo enum('Recibido','Reparado','Entregado')
)
begin
    declare v_rows int;
    declare exit handler for sqlexception
    begin
        rollback;
        signal sqlstate '45000' set message_text = 'Error: No se pudo actualizar los aparatos.';
    end;

    start transaction;

    update aparatos
    set estado = p_estado_nuevo
    where cliente_id = p_cliente_id and estado = p_estado_actual;

    set v_rows = row_count();

    if v_rows = 0 then
        signal sqlstate '45000' set message_text = 'No se encontraron aparatos para actualizar con esas condiciones.';
    end if;

    commit;
end$$

delimiter ;

-- 15. Un reporte de órdenes de trabajo por período

delimiter $$

create procedure reporte_ordenes_por_periodo(
    in p_fecha_inicio date,
    in p_fecha_fin date
)
begin
    select 
        ot.orden_id,
        ot.fecha_orden,
        c.nombres,
        c.apellidos,
        a.nombre_a,
        p.nombres as tecnico_nombre,
        d.diagnostico
    from ordenes_trabajo ot
    join clientes c on ot.cliente_id = c.cliente_id
    join aparatos a on ot.aparato_id = a.aparato_id
    left join personal p on ot.personal_id = p.personal_id
    left join diagnosticos d on ot.diagnostico_id = d.diagnostico_id
    where ot.fecha_orden between p_fecha_inicio and p_fecha_fin
    order by ot.fecha_orden;
end$$

delimiter ;

-- 16. Crea una orden de reparación y registra un pago

delimiter $$

create procedure facturacion_automatica(
    in p_ordenes_t_id int,
    in p_forma_pago enum('Efectivo','Trasferencia'),
    in p_monto_pago decimal(10,2)
)
begin
    declare v_orden_r_id int;
    declare v_precio decimal(10,2);
    
    declare exit handler for sqlexception
    begin
        rollback;
        signal sqlstate '45000' set message_text = 'Error: Facturación fallida.';
    end;
    
    start transaction;
    
    select pr.precio into v_precio
    from precio pr
    join ordenes_trabajo ot on pr.cliente_id = ot.cliente_id and pr.aparato_id = ot.aparato_id
    where ot.orden_id = p_ordenes_t_id;
    
    if v_precio is null then
        rollback;
        signal sqlstate '45000' set message_text = 'Error: Precio no encontrado para la orden.';
    end if;
    
    insert into ordenes_reparacion (reparacion_id, ordenes_t_id, precio_id, forma_pago, estado_pago)
    values (null, p_ordenes_t_id, null, p_forma_pago, 'No Pagado');
    
    set v_orden_r_id = last_insert_id();
    
    insert into pagos_ingresados (orden_r_id, pagos_i, forma_pago)
    values (v_orden_r_id, p_monto_pago, p_forma_pago);
    
    if p_monto_pago >= v_precio then
        update ordenes_reparacion
        set estado_pago = 'Pagado'
        where orden_r_id = v_orden_r_id;
    end if;
    
    commit;
end$$

delimiter ;


