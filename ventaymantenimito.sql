/*==============================================================*/
/* DBMS name:      PostgreSQL 8                                 */
/* Created on:     16/11/2021 4:00:04                           */
/*==============================================================*/


drop table CLIENTE;

drop table EMPLEADO;

drop table MANTENIMIENTO;

drop table MODELO;

drop table PRODUCTO;

drop table PRODUCTO_MANTENIMIENTO;

drop table PROVEEDOR;

drop table TECNICOS;

drop table VENTA;

drop table VENTA_PRODUCTO;

/*==============================================================*/
/* Table: CLIENTE                                               */
/*==============================================================*/
create table CLIENTE (
   CEDULA_C             VARCHAR(9)           not null,
   NOMBRE_C             CHAR(50)             not null,
   APELLIDO_C           CHAR(50)             not null,
   TELEFONO_C           VARCHAR(10)          not null,
   DIRECCION_C          CHAR(25)             not null,
   CORREO_C             CHAR(25)             not null,
   constraint PK_CLIENTE primary key (CEDULA_C)
);

/*==============================================================*/
/* Table: EMPLEADO                                              */
/*==============================================================*/
create table EMPLEADO (
   CEDULA_E             VARCHAR(10)          not null,
   NOMBRE_E             CHAR(50)             not null,
   APELLIDO_E           CHAR(50)             not null,
   TELEFONO_E           VARCHAR(10)          not null,
   CORREO_E             CHAR(25)             not null,
   ID_P                 VARCHAR(10)          null,
   constraint PK_EMPLEADO primary key (CEDULA_E)
);

/*==============================================================*/
/* Table: MANTENIMIENTO                                         */
/*==============================================================*/
create table MANTENIMIENTO (
   ID_M                 VARCHAR(10)          not null,
   ID_T                 VARCHAR(10)          null,
   DANO_M               CHAR(50)             not null,
   FECHA_EN_M           DATE                 not null,
   GARANTIA_M           DATE                 not null,
   ADQUISICION_M        MONEY                not null,
   constraint PK_MANTENIMIENTO primary key (ID_M)
);

/*==============================================================*/
/* Table: MODELO                                                */
/*==============================================================*/
create table MODELO (
   ID_MO                VARCHAR(10)          not null,
   NOMBRE_MO            CHAR(50)             not null,
   constraint PK_MODELO primary key (ID_MO)
);

/*==============================================================*/
/* Table: PRODUCTO                                              */
/*==============================================================*/
create table PRODUCTO (
   ID_P                 VARCHAR(10)          not null,
   NOMBRE_PR            CHAR(50)             not null,
   CEDULA_C             VARCHAR(9)           not null,
   MOD_ID_MO            VARCHAR(10)          null,
   ESTADO_P             CHAR(25)             not null,
   FECHA_INGRESO_P      DATE                 not null,
   USO_P                CHAR(50)             not null,
   PRECIO_P             MONEY                not null,
   constraint PK_PRODUCTO primary key (ID_P)
);

/*==============================================================*/
/* Table: PRODUCTO_MANTENIMIENTO                                */
/*==============================================================*/
create table PRODUCTO_MANTENIMIENTO (
   ID_M                 VARCHAR(10)          not null,
   ID_P                 VARCHAR(10)          not null,
   constraint PK_PRODUCTO_MANTENIMIENTO primary key (ID_M, ID_P)
);

/*==============================================================*/
/* Table: PROVEEDOR                                             */
/*==============================================================*/
create table PROVEEDOR (
   NOMBRE_PR            CHAR(50)             not null,
   CEDULA_E             VARCHAR(10)          null,
   COMPONENTE_PR        CHAR(50)             not null,
   ADQUISICION_PR       MONEY                not null,
   ANO_PR               DATE                 not null,
   constraint PK_PROVEEDOR primary key (NOMBRE_PR)
);

/*==============================================================*/
/* Table: TECNICOS                                              */
/*==============================================================*/
create table TECNICOS (
   ID_T                 VARCHAR(10)          not null,
   NOMBRE_T             CHAR(50)             not null,
   constraint PK_TECNICOS primary key (ID_T)
);

/*==============================================================*/
/* Table: VENTA                                                 */
/*==============================================================*/
create table VENTA (
   ID_V                 VARCHAR(10)          not null,
   CEDULA_C             VARCHAR(9)           not null,
   FECHA_V              DATE                 not null,
   constraint PK_VENTA primary key (ID_V)
);

/*==============================================================*/
/* Table: VENTA_PRODUCTO                                        */
/*==============================================================*/
create table VENTA_PRODUCTO (
   ID_P                 VARCHAR(10)          not null,
   ID_V                 VARCHAR(10)          not null,
   CANTIDAD_P           NUMERIC              not null,
   constraint PK_VENTA_PRODUCTO primary key (ID_V, ID_P)
);

alter table EMPLEADO
   add constraint FK_EMPLEADO_PRODUCTO__PRODUCTO foreign key (ID_P)
      references PRODUCTO (ID_P)
      on delete restrict on update restrict;

alter table MANTENIMIENTO
   add constraint FK_MANTENIM_TECNICO_M_TECNICOS foreign key (ID_T)
      references TECNICOS (ID_T)
      on delete restrict on update restrict;

alter table PRODUCTO
   add constraint FK_PRODUCTO_CLIENTE_P_CLIENTE foreign key (CEDULA_C)
      references CLIENTE (CEDULA_C)
      on delete restrict on update restrict;

alter table PRODUCTO
   add constraint FK_PRODUCTO_MODELO_PR_MODELO foreign key (MOD_ID_MO)
      references MODELO (ID_MO)
      on delete restrict on update restrict;

alter table PRODUCTO
   add constraint FK_PRODUCTO_PRODUCTO__PROVEEDO foreign key (NOMBRE_PR)
      references PROVEEDOR (NOMBRE_PR)
      on delete restrict on update restrict;

alter table PRODUCTO_MANTENIMIENTO
   add constraint FK_PRODUCTO_PRODUCTO__MANTENIM foreign key (ID_M)
      references MANTENIMIENTO (ID_M)
      on delete restrict on update restrict;

alter table PRODUCTO_MANTENIMIENTO
   add constraint FK_PRODUCTO_PRODUCTO__PRODUCTO foreign key (ID_P)
      references PRODUCTO (ID_P)
      on delete restrict on update restrict;

alter table PROVEEDOR
   add constraint FK_PROVEEDO_PROVEEDOR_EMPLEADO foreign key (CEDULA_E)
      references EMPLEADO (CEDULA_E)
      on delete restrict on update restrict;

alter table VENTA
   add constraint FK_VENTA_CLIENTE_V_CLIENTE foreign key (CEDULA_C)
      references CLIENTE (CEDULA_C)
      on delete restrict on update restrict;

alter table VENTA_PRODUCTO
   add constraint FK_VENTA_PR_VENTA_PRO_VENTA foreign key (ID_V)
      references VENTA (ID_V)
      on delete restrict on update restrict;

alter table VENTA_PRODUCTO
   add constraint FK_VENTA_PR_VENTA_PRO_PRODUCTO foreign key (ID_P)
      references PRODUCTO (ID_P)
      on delete restrict on update restrict;

