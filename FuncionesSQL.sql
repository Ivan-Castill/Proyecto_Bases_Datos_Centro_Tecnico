-- Proyecto de Bases de Datos
-- Ivan Andres Castillo Caiza
use centro_tecnico_db;

-- Funciones SQL

-- 1. Devuelve la edad de un cliente

delimiter $$
create function edad_cliente(fecha_nacimiento date) 
returns int
deterministic
begin
    return timestampdiff(year, fecha_nacimiento, curdate());
end$$
delimiter ;

-- 2. devuelve la duración en días entre el inicio y el fin de una reparación.
delimiter $$
create function duracion_reparacion(fecha_inicio datetime, fecha_fin datetime)
returns int
deterministic
begin
    return datediff(fecha_fin, fecha_inicio);
end$$
delimiter ;

-- 3. calcula el porcentaje de repuestos usados respecto al stock disponible total.
delimiter $$
create function porcentaje_repuestos_usados(id_reparacion int)
returns decimal(5,2)
deterministic
begin
    declare total_usado int;
    declare total_stock int;

    select sum(ru.cantidad) into total_usado
    from repuestos_usados ru
    where ru.reparacion_id = id_reparacion;

    select sum(r.stock) into total_stock
    from repuestos r;

    if total_stock = 0 then
        return 0;
    else
        return (total_usado / total_stock) * 100;
    end if;
end$$
delimiter ;

-- 4. suma total de pagos ingresados por un cliente específico.
delimiter $$
create function total_recaudado_cliente(p_cliente_id int)
returns decimal(10,2)
deterministic
begin
    declare total decimal(10,2);

    select sum(pi.pagos_i) into total
    from pagos_ingresados pi
    join ordenes_reparacion orr on pi.orden_r_id = orr.orden_r_id
    join reparaciones r on orr.reparacion_id = r.reparacion_id
    where r.cliente_id = p_cliente_id;

    return ifnull(total, 0);
end$$
delimiter ;

-- 5. cuenta cuántos aparatos ha reparado un técnico.
delimiter $$
create function cantidad_aparatos_reparados(p_tecnico_id int)
returns int
deterministic
begin
    declare cantidad int;

    select count(distinct r.aparato_id) into cantidad
    from reparaciones r
    join ordenes_tecnicos ot on r.ordenes_t_id = ot.ordenes_t_id
    where ot.personal_id = p_tecnico_id;

    return cantidad;
end$$
delimiter ;

-- 6. devuelve "Pagado", "Parcial", o "No Pagado" según el total ingresado y el precio asignado a la orden.
delimiter $$
create function estado_pago_orden(p_orden_r_id int)
returns varchar(20)
deterministic
begin
    declare total_pago decimal(10,2);
    declare total_precio decimal(10,2);

    select sum(pagos_i) into total_pago
    from pagos_ingresados
    where orden_r_id = p_orden_r_id;

    select p.precio into total_precio
    from ordenes_reparacion orr
    join precio p on orr.precio_id = p.precio_id
    where orr.orden_r_id = p_orden_r_id;

    if total_pago is null then
        return 'No Pagado';
    elseif total_pago < total_precio then
        return 'Parcial';
    else
        return 'Pagado';
    end if;
end$$
delimiter ;

-- 7. devuelve 'Activo' o 'Inactivo' según el campo estado del cliente.
delimiter $$
create function verifica_estado_cliente(p_cliente_id int)
returns varchar(10)
deterministic
begin
    declare est varchar(10);

    select estado into est
    from clientes
    where cliente_id = p_cliente_id;

    return est;
end$$
delimiter ;

