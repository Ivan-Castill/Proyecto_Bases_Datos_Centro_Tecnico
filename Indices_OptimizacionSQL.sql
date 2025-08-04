-- Proyecto de Bases de Datos
-- Ivan Andres Castillo Caiza
use centro_tecnico_db;

-- Indices y Optimizacion SQL

-- Índices simples
-- Estos índices aceleran búsquedas, filtros o joins por una sola columna frecuente.
create index idx_clientes_cedula on clientes(cedula);
create index idx_clientes_estado on clientes(estado);

create index idx_personal_rol on personal(rol);
create index idx_personal_estado on personal(estado);

create index idx_aparatos_estado on aparatos(estado);
create index idx_aparatos_cliente_id on aparatos(cliente_id);

create index idx_diagnosticos_aparato_id on diagnosticos(aparato_id);
create index idx_diagnosticos_cliente_id on diagnosticos(cliente_id);

create index idx_ordenes_trabajo_cliente_id on ordenes_trabajo(cliente_id);
create index idx_ordenes_trabajo_aparato_id on ordenes_trabajo(aparato_id);

create index idx_repuestos_nombre on repuestos(nombre);
create index idx_repuestos_stock on repuestos(stock);

create index idx_precio_aparato_id on precio(aparato_id);

create index idx_reparaciones_cliente_id on reparaciones(cliente_id);
create index idx_reparaciones_aparato_id on reparaciones(aparato_id);

create index idx_ordenes_reparacion_estado_pago on ordenes_reparacion(estado_pago);

create index idx_pagos_ingresados_orden_r_id on pagos_ingresados(orden_r_id);

create index idx_usuarios_usuario on usuarios(usuario);

create index idx_aparatos_inventario_nombre on aparatos_inventario(nombre_a);

-- Índices compuestos 
-- Usados cuando múltiples columnas se consultan juntas en condiciones where o join.
create index idx_ordenes_trabajo_cliente_aparato on ordenes_trabajo(cliente_id, aparato_id);

create index idx_diagnostico_cliente_aparato on diagnosticos(cliente_id, aparato_id);

create index idx_ordenes_tecnicos_orden_personal on ordenes_tecnicos(orden_id, personal_id);

create index idx_diagnostico_tecnico_cliente_aparato on diagnostico_tecnico(cliente_id, aparato_id);

create index idx_repuestos_usados_reparacion_repuesto on repuestos_usados(reparacion_id, repuesto_id);

create index idx_precio_cliente_aparato on precio(cliente_id, aparato_id);

create index idx_reparaciones_cliente_aparato on reparaciones(cliente_id, aparato_id);

create index idx_ordenes_reparacion_reparacion_precio on ordenes_reparacion(reparacion_id, precio_id);

create index idx_personal_nombre_apellido on personal(nombres, apellidos);

create index idx_usuarios_usuario_rol on usuarios(usuario, rol);

