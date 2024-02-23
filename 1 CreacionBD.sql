

use master
go

DROP DATABASE IF EXISTS LimpiezaVenta
GO

create database LimpiezaVenta
go

use LimpiezaVenta
go



CREATE TABLE Categoria
( 
	IdCategoria          int IDENTITY ( 1,1 ) ,
	DescripcionCategoria varchar(30)  NULL 
)
go



ALTER TABLE Categoria
	ADD CONSTRAINT XPKCategoria PRIMARY KEY  CLUSTERED (IdCategoria ASC)
go



CREATE TABLE Cliente
( 
	IdCliente            int IDENTITY ( 1,1 ) ,
	NombreCliente        varchar(50)  NULL ,
	TelefonoCliente      varchar(20)  NULL ,
	CorreoCliente        varchar(50)  NULL ,
	TipoCliente			 varchar(8)	  NULL,
	CiudadCliente		 varchar(20)  NULL,
	GeneroCliente		 varchar(10)  NULL
)
go



ALTER TABLE Cliente
	ADD CONSTRAINT XPKCliente PRIMARY KEY  CLUSTERED (IdCliente ASC)
go



CREATE TABLE Compra
( 
	IdCompra             int IDENTITY ( 1,1 ) ,
	NumeroDocumento      int  NULL ,
	MontoCompra          money  NULL ,
	Fecha                datetime NULL ,
	IdProveedor			 int NULL
)
go

ALTER TABLE Compra
	ADD CONSTRAINT XPKCompra PRIMARY KEY  CLUSTERED (IdCompra ASC)
go

CREATE TABLE CompraDeleted
( 
	IdCompra             int NOT NULL,
	NumeroDocumento      int  NULL ,
	MontoCompra          money  NULL ,
	Fecha                datetime NULL ,
	IdProveedor			 int NULL
)
go

ALTER TABLE CompraDeleted
	ADD CONSTRAINT XPKCompraDeleted PRIMARY KEY  CLUSTERED (IdCompra ASC)
go


CREATE TABLE DetalleCompra
( 
	CantidadComprada     int  NULL ,
	PrecioUnitario       money  NULL ,
	IdProducto           int  NOT NULL ,
	IdCompra             int  NOT NULL ,
	IdDetalleCompra      int IDENTITY ( 1,1 ) 
)
go



ALTER TABLE DetalleCompra
	ADD CONSTRAINT XPKDetalleCompra PRIMARY KEY  CLUSTERED (IdDetalleCompra ASC,IdCompra ASC)
go

CREATE TABLE dCompraDeleted
( 
	CantidadComprada     int  NULL ,
	PrecioUnitario       money  NULL ,
	IdProducto           int  NOT NULL ,
	IdCompra             int  NOT NULL ,
	IdDetalleCompra      int NOT NULL
)
go



ALTER TABLE dCompraDeleted
	ADD CONSTRAINT XPKdCompraDeleted PRIMARY KEY  CLUSTERED (IdDetalleCompra ASC,IdCompra ASC)
go



CREATE TABLE DetalleVenta
( 
	IdProducto           int  NULL ,
	CantidadVendida      int  NULL ,
	PrecioUnitario       money  NULL ,
	IdDetalleVenta       int IDENTITY ( 1,1 ) ,
	IdVenta              int  NOT NULL 
)
go



ALTER TABLE DetalleVenta
	ADD CONSTRAINT XPKDetalleVenta PRIMARY KEY  CLUSTERED (IdDetalleVenta ASC,IdVenta ASC)
go

CREATE TABLE dVentaDeleted
(
	IdProducto           int  NULL ,
	CantidadVendida      int  NULL ,
	PrecioUnitario       money  NULL ,
	IdDetalleVenta       int NOT NULL,
	IdVenta              int  NOT NULL 
)
go

ALTER TABLE dVentaDeleted
	ADD CONSTRAINT XPKdVentaDeleted PRIMARY KEY  CLUSTERED (IdDetalleVenta ASC,IdVenta ASC)
go


CREATE TABLE Documento
( 
	NumeroDocumento      int IDENTITY ( 1,1 ) ,
	FechaDocumento       datetime  NULL ,
	PrecioDocumento      money  NULL ,
	TipoDoc              varchar(4)  NULL ,
	IdResp               varchar(10)  NULL ,
	Estado				 varchar(20) NULL DEFAULT 'Sin modificaciones' CHECK (Estado IN('Sin modificaciones','Anulado','Modificado'))
)
go



ALTER TABLE Documento
	ADD CONSTRAINT XPKDocumento PRIMARY KEY  CLUSTERED (NumeroDocumento ASC)
go



CREATE TABLE Empleado
( 
	IdEmpleado           int IDENTITY ( 1,1 ) ,
	NombreEmp            varchar(50)  NULL ,
	DniEmp               varchar(8)  NULL ,
	FechaNacEmp          datetime NULL ,
	TelefonoEmp          varchar(18)  NULL ,
	CorreoEmp            varchar(30)  NULL
)
go



ALTER TABLE Empleado
	ADD CONSTRAINT XPKEmpleado PRIMARY KEY  CLUSTERED (IdEmpleado ASC)
go



CREATE TABLE Kardex
( 
	IdKardex             int IDENTITY ( 1,1 ) ,
	FechaApertura        datetime  NULL ,
	IdProducto           int  NULL 
)
go



ALTER TABLE Kardex
	ADD CONSTRAINT XPKKardex PRIMARY KEY  CLUSTERED (IdKardex ASC)
go



CREATE TABLE MovimientoKardex
( 
	IdKardex             int  NOT NULL ,
	IdProveedor          int  NULL ,
	NumeroDocumento      int  NULL ,
	StockAnterior        int  NULL ,
	TipoMovimiento       varchar(8)  NULL ,
	Cantidad             int  NULL ,
	IdMovimiento         varchar(30)  NOT NULL ,
	StockActual          int  NULL ,
	Monto                money  NULL ,
	IdKMov               int IDENTITY ( 1,1 ) 
)
go



ALTER TABLE MovimientoKardex
	ADD CONSTRAINT XPKKardexMovimiento PRIMARY KEY  CLUSTERED (IdKardex ASC,IdMovimiento ASC,IdKMov ASC)
go



CREATE TABLE Producto
( 
	IdProducto           int IDENTITY ( 1,1 ) ,
	DescripciónProducto  varchar(50)  NULL ,
	PrecioBase           money  NULL ,
	StockMin             int  NULL ,
	UnidadMedida         varchar(18)  NULL ,
	CantidadReposicion   int  NULL ,
	StockActual          int  NULL ,
	IdCategoria          int  NULL 
)
go



ALTER TABLE Producto
	ADD CONSTRAINT XPKProducto PRIMARY KEY  CLUSTERED (IdProducto ASC)
go



CREATE TABLE Producto_Proveedor
( 
	IdProveedor          int  NOT NULL ,
	IdProducto           int  NOT NULL ,
	PrecioCompra         money  NULL 
)
go



ALTER TABLE Producto_Proveedor
	ADD CONSTRAINT XPKProducto_Proveedor PRIMARY KEY  CLUSTERED (IdProveedor ASC,IdProducto ASC)
go



CREATE TABLE Proveedor
( 
	IdProveedor          int IDENTITY ( 1,1 ) ,
	NombreProveedor      varchar(40)  NULL ,
	TelefonoProveedor    varchar(20)  NULL ,
	CorreoProveedor      varchar(50)  NULL ,
	DireccionProveedor   varchar(50)  NULL ,
	CiudadProveedor		 varchar(20)  NULL ,
	PaisProveedor		 varchar(20) NULL
)
go



ALTER TABLE Proveedor
	ADD CONSTRAINT XPKProveedor PRIMARY KEY  CLUSTERED (IdProveedor ASC)
go



CREATE TABLE ResponsableEmpresa
( 
	IdResp               varchar(10)  NOT NULL ,
	IdEmpleado           int  NULL 
)
go



ALTER TABLE ResponsableEmpresa
	ADD CONSTRAINT XPKResponsableEmpresa PRIMARY KEY  CLUSTERED (IdResp ASC)
go



CREATE TABLE Servicio
( 
	IdServicio           int IDENTITY ( 1,1 ) ,
	DescripcionServicio  varchar(50)  NULL 
)
go



ALTER TABLE Servicio
	ADD CONSTRAINT XPKServicio PRIMARY KEY  CLUSTERED (IdServicio ASC)
go



CREATE TABLE Servicio_Proveedor
( 
	IdServicio           int  NOT NULL ,
	IdProveedor          int  NOT NULL ,
	FechaInicio          datetime  NULL ,
	PrecioServicio       money  NULL 
)
go



ALTER TABLE Servicio_Proveedor
	ADD CONSTRAINT XPKServicio_Proveedor PRIMARY KEY  CLUSTERED (IdServicio ASC,IdProveedor ASC)
go



CREATE TABLE TipoDocumento
( 
	TipoDoc              varchar(4)  NOT NULL ,
	Descripcion          varchar(20)  NULL 
)
go



ALTER TABLE TipoDocumento
	ADD CONSTRAINT XPKTipoDocumento PRIMARY KEY  CLUSTERED (TipoDoc ASC)
go



CREATE TABLE Venta
( 
	IdVenta              int IDENTITY ( 1,1 ) ,
	IdCliente            int  NOT NULL ,
	NumeroDocumento      int  NULL ,
	MontoVenta           money  NULL ,
	Fecha                datetime  NULL 
)
go



ALTER TABLE Venta
	ADD CONSTRAINT XPKVenta PRIMARY KEY  CLUSTERED (IdVenta ASC)
go

CREATE TABLE VentaDeleted
(
	IdVenta              int NOT NULL,
	IdCliente            int  NOT NULL ,
	NumeroDocumento      int  NULL ,
	MontoVenta           money  NULL ,
	Fecha                datetime  NULL 
)
go

ALTER TABLE VentaDeleted
	ADD CONSTRAINT XPKVentaDeleted PRIMARY KEY  CLUSTERED (IdVenta ASC)
go



ALTER TABLE Compra
	ADD CONSTRAINT R_11 FOREIGN KEY (NumeroDocumento) REFERENCES Documento(NumeroDocumento)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE Compra
	ADD CONSTRAINT R_12 FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go





ALTER TABLE DetalleCompra
	ADD CONSTRAINT R_14 FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE DetalleCompra
	ADD CONSTRAINT R_44 FOREIGN KEY (IdCompra) REFERENCES Compra(IdCompra)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE DetalleVenta
	ADD CONSTRAINT R_9 FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE DetalleVenta
	ADD CONSTRAINT R_45 FOREIGN KEY (IdVenta) REFERENCES Venta(IdVenta)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go






ALTER TABLE Documento
	ADD CONSTRAINT R_19 FOREIGN KEY (TipoDoc) REFERENCES TipoDocumento(TipoDoc)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Documento
	ADD CONSTRAINT R_38 FOREIGN KEY (IdResp) REFERENCES ResponsableEmpresa(IdResp)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Kardex
	ADD CONSTRAINT R_32 FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE MovimientoKardex
	ADD CONSTRAINT R_30 FOREIGN KEY (IdKardex) REFERENCES Kardex(IdKardex)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE MovimientoKardex
	ADD CONSTRAINT R_34 FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE MovimientoKardex
	ADD CONSTRAINT R_36 FOREIGN KEY (NumeroDocumento) REFERENCES Documento(NumeroDocumento)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Producto
	ADD CONSTRAINT R_23 FOREIGN KEY (IdCategoria) REFERENCES Categoria(IdCategoria)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Producto_Proveedor
	ADD CONSTRAINT R_26 FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Producto_Proveedor
	ADD CONSTRAINT R_41 FOREIGN KEY (IdProducto) REFERENCES Producto(IdProducto)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE ResponsableEmpresa
	ADD CONSTRAINT R_40 FOREIGN KEY (IdEmpleado) REFERENCES Empleado(IdEmpleado)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Servicio_Proveedor
	ADD CONSTRAINT R_24 FOREIGN KEY (IdServicio) REFERENCES Servicio(IdServicio)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Servicio_Proveedor
	ADD CONSTRAINT R_25 FOREIGN KEY (IdProveedor) REFERENCES Proveedor(IdProveedor)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Venta
	ADD CONSTRAINT R_6 FOREIGN KEY (IdCliente) REFERENCES Cliente(IdCliente)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE Venta
	ADD CONSTRAINT R_7 FOREIGN KEY (NumeroDocumento) REFERENCES Documento(NumeroDocumento)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


