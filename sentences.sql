
DROP TABLE IF EXISTS GESTIONES;
DROP TABLE IF EXISTS PAGOS;
DROP TABLE IF EXISTS ASESORES;
DROP TABLE IF EXISTS DEUDORES;
DROP TABLE IF EXISTS ASIGNACIONES;
DROP TABLE IF EXISTS OBLIGACIONES;
DROP TABLE IF EXISTS TIPOLOGIAS;
DROP TABLE IF EXISTS CLIENTES_UNIDADES;
DROP TABLE IF EXISTS CLIENTES;
DROP TABLE IF EXISTS UNIDADES;

CREATE TABLE CLIENTES(
	identificacion numeric(15),
	nombre varchar not null,
	fecha_registro date not null,
	estado varchar not null,
	 primary key (identificacion)
);


CREATE TABLE UNIDADES(
	id_unidad  serial primary key,
	nombre_unidad varchar not null,
	estado varchar not null
);


CREATE TABLE CLIENTES_UNIDADES(
	id_cliente  serial,
	id_unidad  serial,
	primary key(id_cliente,id_unidad),
	CONSTRAINT fk_clientes
      FOREIGN KEY(id_cliente) 
	  REFERENCES CLIENTES(identificacion),
	CONSTRAINT fk_unidad
      FOREIGN KEY(id_unidad) 
	  REFERENCES UNIDADES(id_unidad)
);

CREATE TABLE ASESORES(
	identificacion  numeric(15) primary key,
	nombre varchar not null,
	fecha_ingreso date not null,
	estado varchar not null,
	id_unidad  serial not null,
	CONSTRAINT fk_unidad
      FOREIGN KEY(id_unidad) 
	  REFERENCES UNIDADES(id_unidad)
);

CREATE TABLE DEUDORES(
	identificacion  numeric(15) primary key,
	nombre varchar not null,
	estado varchar not null
);

CREATE TABLE OBLIGACIONES(
	obligacion numeric(15) primary key not null,
	estado varchar not null
);

CREATE TABLE ASIGNACIONES(
	id_asignaciones serial,
	identificacion numeric(15),
	obligacion numeric(15),
	saldo_capital numeric(15) not null,
	saldo_actual numeric(15) not null,
	saldo_mora numeric(15) not null,
	dias_mora numeric(3) not null,
	agencia varchar not null,
	fecha_asignacion date,
	etapa varchar,
	tipo varchar,
	codigo varchar,
	primary key(id_asignaciones,identificacion),
	CONSTRAINT fk_obligacion_asig
      FOREIGN KEY(obligacion) 
	  REFERENCES OBLIGACIONES(obligacion),
	CONSTRAINT fk_identificacion
		foreign key(identificacion)
		REFERENCES CLIENTES(identificacion)
);

CREATE TABLE PAGOS(
	obligacion numeric(15) not null,
	valor numeric(15,2) not null,
	fecha date,
	primary key(obligacion,fecha),
	CONSTRAINT fk_obligacion_pagos
      FOREIGN KEY(obligacion) 
	  REFERENCES OBLIGACIONES(obligacion)
);

CREATE TABLE TIPOLOGIAS(
	cod_tipo numeric(2) primary key,
	tipologia varchar not null,
	contactibilidad varchar not null,
	efectividad varchar not null
);
CREATE TABLE GESTIONES(
	id_gestion serial primary key,
	identificacion_asesor  numeric(15),
	fecha_gestion timestamp,
	identificacion_deudor  numeric(15),
	tipo_gestion  numeric(2),
	CONSTRAINT fk_tp_gestion
      FOREIGN KEY(tipo_gestion) 
	  REFERENCES TIPOLOGIAS(cod_tipo),
	CONSTRAINT fk_asesor
      FOREIGN KEY(identificacion_asesor) 
	  REFERENCES ASESORES(identificacion),
	CONSTRAINT fk_deudor
      FOREIGN KEY(identificacion_deudor) 
	  REFERENCES DEUDORES(identificacion)
);