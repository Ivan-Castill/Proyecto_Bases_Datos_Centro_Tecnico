-- Proyecto de Bases de Datos
-- Ivan Andres Castillo Caiza
use centro_tecnico_db;
-- Consultas
-- 1. Obtener todos los clientes registrados con su aparato o electrodomestico.
select
	c.nombres as NombreCliente,
    c.apellidos as ApellidoCliente,
    c.cedula as Cedula,
    c.correo as Correo,
    c.direccion as Direccion,
    a.nombre_a as Electrodomestico,
    a.marca as Marca,
    a.modelo as Modelo,
    a.color as Color
from clientes c
join aparatos a on c.cliente_id = a.cliente_id;

-- 2. Ver todas las reparaciónes con nombre del cliente, aparato y repuestos usados

select
	c.nombres as NombreCliente,
    c.apellidos as ApellidoCliente,
    c.telefono as TelfonoCliente,
    a.nombre_a as Electrodomestico,
    a.marca as Marca,
    r.nombre  as Repuesto
from reparaciones rep
join clientes c on rep.cliente_id = c.cliente_id
join aparatos a on rep.aparato_id = a.aparato_id
join repuestos_usados ru on rep.reparacion_id = ru.reparacion_id
join repuestos r on ru.repuesto_id = r.repuesto_id;

--  3. Consultar total de pagos recibidos

select
	sum(pagos_i) as IngresoTotal
from pagos_ingresados;

-- 3.2. Consulta total de pagos recibidos por forma de pago.

select
	forma_pago as FormaPago,
    sum(pagos_i) as IngresoTotal
from pagos_ingresados
group by forma_pago;


-- 4. Listar herramientas con estado "Malo, Bueno y Medio"

select 
	nombre as Herramienta,
    estado as Estado
from herramientas
where estado = 'Malo';

select 
	nombre as Herramienta,
    estado as Estado
from herramientas
where estado = 'Medio';

select 
	nombre as Herramienta,
    estado as Estado
from herramientas
where estado = 'Bueno';

-- 5. Ver historial de diagnósticos técnicos por cliente , aparato y tecnico

select 
	c.apellidos as Cliente,
    a.nombre_a as Electrodomestico,
    dt.diagnostico_t as Diagnostico,
    p.apellidos as Tecnico
from diagnostico_tecnico dt
join clientes c on dt.cliente_id = c.cliente_id
join aparatos a on dt.aparato_id = a.aparato_id
join ordenes_tecnicos ot on dt.ordenes_t_id = ot.ordenes_t_id
join personal p on ot.personal_id = p.personal_id;



-- 6. Ver todas las peticiones a domicilio con cliente y aparato involucrado

select 
	cd.nombre as NombreCliente,
    cd.apellido as ApellidoCliente,
    cd.telefono as Telefono,
    cd.direccion as Direccion,
    ad.nombre_aparato as Electrodomestico,
    ad.marca as Marca,
    ad.modelo as Modelo,
    ad.observación as Observacion
from peticion_a_domicilio pd
join aparatos_domicilio ad on pd.aparato_domi_id = ad.aparato_domi_id
join clientes_domicilio cd on pd.cliente_domi_id = cd.cliente_domi_id;


-- 7. Aparatos en reparación pendientes de entrega

select 
	c.apellidos as Cliente,
	c.telefono as Telefono,
    a.nombre_a as Electrodomestico,
    a.marca as Marca,
    a.modelo as Modelo,
    a.estado as Estado
from aparatos a
join clientes c on c.cliente_id = a.cliente_id
where a.estado != 'Entregado';


