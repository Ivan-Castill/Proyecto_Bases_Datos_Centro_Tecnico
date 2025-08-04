-- Proyecto Base de Datos
-- SISTEMA DE BASES DE DATOS PARA EL ESTABLECIMIENTO DE REPARACIONES DE APARATOS ELECTRÓNICOS Y ELÉCTRICOS. 
-- Ivan Andres Castillo Caiza

create database centro_tecnico_db;
use centro_tecnico_db;

-- Tablas para la base de datos

-- 1. Tabla clientes☑️
create table clientes(
	cliente_id int auto_increment primary key,
    nombres varchar(100) not null,
    apellidos varchar(100) not null,
    cedula varchar(20) not null,
    correo varchar(100) default null,
    telefono varchar(20) not null,
    direccion text not null,
    fecha_registro datetime default current_timestamp,
    estado enum('Activo','Inactivo') default 'Activo'
);


-- 3. Tabla personal del establecimiento☑️
create table personal(
	personal_id int auto_increment primary key,
    nombres varchar(100) not null,
    apellidos varchar(100) not null,
    telefono varchar(20) not null,
    correo varchar(100) not null,
    rol enum('Secretario','Tecnico') not null,
    estado enum('Activo','Inactivo') default 'Activo'
);

-- 4. Tabla especialidades☑️
create table especialidades(
	especialidad_id int auto_increment primary key,
	especialidad varchar(100)
);
-- 5. Tabla pesonal x especialidades☑️
create table personal_especialidades(
	personal_id int,
    especialidad_id int,
    primary key(personal_id,especialidad_id),
    foreign key(personal_id) references personal(personal_id),
    foreign key(especialidad_id) references especialidades(especialidad_id)
);

-- 6. Tabla aparatos☑️
create table aparatos(
	aparato_id int auto_increment primary key,
    fecha_registro datetime default current_timestamp,
    cliente_id int not null,
    nombre_a varchar(100) not null,
    marca varchar(100) not null,
    modelo varchar(100) not null,
    color varchar(100) not null,
    estado enum('Recibido','Reparado','Entregado') default 'Recibido',
    foreign key (cliente_id) references clientes(cliente_id)
		on delete cascade on update cascade
);
-- 7. Tabla diagnosticos ☑️
create table diagnosticos(
	diagnostico_id int auto_increment primary key,
    fecha_registro datetime default current_timestamp,
    cliente_id int not null,
    aparato_id int not null,
    diagnostico text not null,
    foreign key(cliente_id) references clientes(cliente_id)
		on delete cascade on update cascade,
    foreign key(aparato_id) references aparatos(aparato_id)
		on delete cascade on update cascade
);

-- 8. Tabla ordenes de ingreso del aparato☑️
create table ordenes_trabajo(
	orden_id int auto_increment primary key,
    fecha_orden datetime default current_timestamp,
    cliente_id int not null,
    aparato_id int not null,
    personal_id int ,
    diagnostico_id int,
    foreign key (cliente_id) references clientes(cliente_id) 
		on delete cascade on update cascade,
    foreign key (aparato_id) references aparatos(aparato_id)
		on delete cascade on update cascade,
    foreign key (personal_id) references personal(personal_id)
		on delete set null on update cascade,
    foreign key (diagnostico_id) references diagnosticos(diagnostico_id)
		on delete set null on update cascade
);

-- 9. Tabla ordenes x tecnico(personal)
create table ordenes_tecnicos(
	ordenes_t_id int auto_increment primary key,
    orden_id int,
    personal_id int,
    foreign key (orden_id) references ordenes_trabajo(orden_id)
		on delete cascade on update cascade,
	foreign key (personal_id) references personal(personal_id)
		on delete cascade on update cascade
);

-- 10. Tabla diagnostico tecnico.☑️
create table diagnostico_tecnico(
	diagnostico_t_id int auto_increment primary key,
    fecha_registro datetime default current_timestamp,
    cliente_id int not null,
    aparato_id int not null,
    ordenes_t_id int,
    diagnostico_t text,
    foreign key (ordenes_t_id) references ordenes_tecnicos(ordenes_t_id)
		on delete cascade on update cascade,
    foreign key (aparato_id) references aparatos(aparato_id)
		on delete cascade on update cascade,
    foreign key (cliente_id) references clientes(cliente_id)
		on delete cascade on update cascade
);

-- 11. Tabla repuestos ☑️
create table repuestos(
	repuesto_id int auto_increment primary key,
    fecha_ingreso_repuesto datetime default current_timestamp,
    nombre varchar(100) not null,
    descripcion text,
    precio decimal(10,2) check(precio >= 0),
    stock int check(stock >= 0)
);

-- 12. Tabla precio☑️
create table precio(
	precio_id int auto_increment primary key,
    fecha_registro datetime default current_timestamp,
    cliente_id int,
    aparato_id int,
    precio decimal(10,2) check(precio >= 0),
    foreign key (cliente_id) references clientes(cliente_id)
		on delete cascade on update cascade,
    foreign key (aparato_id) references aparatos(aparato_id)
		on delete cascade on update cascade
);

-- 13. Tabla reparaciones ☑️
create table reparaciones(
	reparacion_id int auto_increment primary key,
    cliente_id int not null,
    aparato_id int not null,
    ordenes_t_id int,
    diagnostico_t_id int,
    foreign key (ordenes_t_id) references ordenes_tecnicos(ordenes_t_id)
		on delete cascade on update cascade,
    foreign key (aparato_id) references aparatos(aparato_id)
		on delete cascade on update cascade,
    foreign key (cliente_id) references clientes(cliente_id)
		on delete cascade on update cascade,
    foreign key (diagnostico_t_id) references diagnostico_tecnico(diagnostico_t_id)
		on delete set null on update cascade
);

-- 14. tabla de repuesto usados
create table repuestos_usados(
	id_repuesto_u int auto_increment primary key,
    reparacion_id int,
    repuesto_id int,
    cantidad int default 1,
    foreign key (repuesto_id) references repuestos(repuesto_id)
		on delete cascade on update cascade,
	foreign key (reparacion_id) references reparaciones(reparacion_id)
		on delete cascade on update cascade
);

-- 14. Tabla ordenes de reparacion ☑️
create table ordenes_reparacion(
	orden_r_id int auto_increment primary key,
    fecha_registro datetime default current_timestamp,
    reparacion_id int,
    ordenes_t_id int,
    precio_id int,
    forma_pago enum('Efectivo','Trasferencia') default null,
    estado_pago enum('Pagado','No Pagado'),
    foreign key (ordenes_t_id) references ordenes_tecnicos(ordenes_t_id)
		on delete cascade on update cascade,
    foreign key (reparacion_id) references reparaciones(reparacion_id)
		 on delete cascade on update cascade,
    foreign key (precio_id) references precio(precio_id)
		on delete set null on update cascade
);

-- 15. tabla de pagos ingresados ☑️
create table pagos_ingresados(
	pagos_i_id int auto_increment primary key,
    fecha_registros datetime default current_timestamp,
    orden_r_id int,
    pagos_i decimal(10,2) check(pagos_i >= 0),
    forma_pago enum('Efectivo','Trasferencia'),
    foreign key (orden_r_id) references ordenes_reparacion(orden_r_id)
		on delete cascade on update cascade
);


-- 16. Tabla herramientas ☑️
create table herramientas(
	herramientas_id int auto_increment primary key,
    fecha_registros datetime default current_timestamp,
    nombre varchar(100) not null,
    estado enum('Bueno', 'Medio', 'Malo')
);

-- 17. Tabla aparatos inventario ☑️
create table aparatos_inventario(
	aparatos_ad_id int auto_increment primary key,
    nombre_a varchar(100) not null,
    marca varchar(100) not null,
    modelo varchar(100) not null,
    color varchar(100) not null,
    observación  text,
    tipo ENUM('Adquirido', 'Remate')
);

-- 18. tabla clientes a domicilio ☑️
create table clientes_domicilio(
	cliente_domi_id int auto_increment primary key,
    nombre varchar(100) not null,
    apellido varchar(100) not null,
    telefono varchar(20) not null,
    direccion text not null
);

-- 19. Tabla aparatos a domicilio ☑️
create table aparatos_domicilio(
	aparato_domi_id int auto_increment primary key,
    nombre_aparato varchar(100) not null,
    marca varchar(100) not null,
    modelo varchar(100) not null,
    color varchar(100) not null,
    observación  text not null
);

-- 20. Tabla apratos x clientes a domicilio ☑️
create table peticion_a_domicilio(
	peticion_id int auto_increment primary key,
    fecha_registro datetime default current_timestamp,
    cliente_domi_id int,
    aparato_domi_id int,
    foreign key (cliente_domi_id) references clientes_domicilio(cliente_domi_id)
		on delete cascade on update cascade,
	foreign key (aparato_domi_id) references aparatos_domicilio(aparato_domi_id)
		on delete cascade on update cascade
);

-- 21. Tabla usuarios ☑️
create table usuarios(
	usuario_id int auto_increment primary key,
    fecha_registro datetime default current_timestamp,
    usuario varchar(100) unique not null,
    contraseña varchar(100) not null,
    rol enum('Administrador','Tecnico','Secretario') not null,
    estado enum('Activo','Inactivo') default 'Activo'
);



