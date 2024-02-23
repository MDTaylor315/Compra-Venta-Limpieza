use LimpiezaVenta
go

select * from Empleado
select * from Producto

-- Desactivar la generación automática de valores para la columna IdTabla
SET IDENTITY_INSERT Compra ON;
-- Insertar el valor 0 manualmente
INSERT INTO Compra (IdCompra) VALUES (0);
-- Activar la generación automática de valores para la columna IdTabla
SET IDENTITY_INSERT Compra OFF;
-- Reiniciar la propiedad IDENTITY para la columna IdTabla con el valor siguiente al máximo existente
DBCC CHECKIDENT ('Compra', RESEED, 1);

-- Desactivar la generación automática de valores para la columna IdTabla
SET IDENTITY_INSERT Cliente ON;
-- Insertar el valor 0 manualmente
INSERT INTO Cliente (IdCliente) VALUES (0);
-- Activar la generación automática de valores para la columna IdTabla
SET IDENTITY_INSERT Cliente OFF;
-- Reiniciar la propiedad IDENTITY para la columna IdTabla con el valor siguiente al máximo existente
DBCC CHECKIDENT ('Cliente', RESEED, 1);
go

-- Desactivar la generación automática de valores para la columna IdTabla
SET IDENTITY_INSERT Venta ON;
-- Insertar el valor 0 manualmente
INSERT INTO Venta (IdVenta,IdCliente) VALUES (0,0);
-- Activar la generación automática de valores para la columna IdTabla
SET IDENTITY_INSERT Venta OFF;
-- Reiniciar la propiedad IDENTITY para la columna IdTabla con el valor siguiente al máximo existente
DBCC CHECKIDENT ('Venta', RESEED, 1);
go


CREATE PROCEDURE agregarEmpleado
	@Nombre varchar(50),
	@Dni	varchar(8),
	@FechaNac date,
	@Telefono varchar(18),
	@Correo varchar(30)
AS
BEGIN
	insert into Empleado(NombreEmp,DniEmp,FechaNacEmp,TelefonoEmp,CorreoEmp) values 
	(@Nombre,@Dni,@FechaNac,@Telefono,@Correo)
END
GO


CREATE TRIGGER agregarResp on Empleado after insert
as
begin
	
		declare @IdEmpleado INT,
				@Dni varchar(8),
				@FechaNac date,
				@IdResp varchar(10),
				@Veces int,
				@aux int

		select	@IdEmpleado=IdEmpleado,
				@Dni=DniEmp,
				@FechaNac=FechaNacEmp
		from inserted
		CREATE TABLE #Repite(
			Digito char(1),
			Cantidad int
		)
		insert into #Repite(Digito, Cantidad) values ('0',0),('1',0),('2',0),('3',0),('4',0),('5',0),('6',0),('7',0),('8',0),('9',0)
		UPDATE #Repite
		set Cantidad =  LEN(@Dni) - LEN(REPLACE(@Dni,Digito,''));
		select @Veces=COUNT(*) from #Repite where Cantidad>1
		DROP TABLE #Repite
		set @IdResp = CONCAT(@Veces,RIGHT(Year(@FechaNac),2))
		select @Aux=COUNT(*) from ResponsableEmpresa where LEFT(Idresp,3)=@IdResp
		SET @IdResp  = CONCAT( @IdResp,(@Aux+1))
		insert into ResponsableEmpresa (IdResp,IdEmpleado) values (@IdResp,@IdEmpleado)
	
end
go















select RE.IdResp, e.IdEmpleado, e.NombreEmp from ResponsableEmpresa RE
inner join Empleado E ON RE.IdEmpleado=E.IdEmpleado
order by re.IdResp












select * from Empleado
go

EXEC agregarEmpleado 'María García', '87654321', '1985-07-22', '987123456', 'maria.garcia@example.com';
EXEC agregarEmpleado 'Carlos López', '11223344', '1992-04-10', '995887766', 'carlos.lopez@example.com';
EXEC agregarEmpleado 'Ana Rodríguez', '55443322', '1988-11-30', '996112233', 'ana.rodriguez@example.com';
EXEC agregarEmpleado 'Pedro Martínez', '78901234', '1995-02-15', '994556677', 'pedro.martinez@example.com';
EXEC agregarEmpleado 'Laura Torres', '98765432', '1980-09-08', '998889900', 'laura.torres@example.com';
EXEC agregarEmpleado 'Juan Ramírez', '44556677', '1998-12-03', '997776655', 'juan.ramirez@example.com';
EXEC agregarEmpleado 'Sofía Sánchez', '33221100', '1987-06-25', '993344556', 'sofia.sanchez@example.com';
EXEC agregarEmpleado 'Miguel Gómez', '11229988', '1993-10-18', '999000111', 'miguel.gomez@example.com';
EXEC agregarEmpleado 'Luisa Herrera', '66778899', '1982-03-12', '994433322', 'luisa.herrera@example.com';
EXEC agregarEmpleado 'Javier Medina', '55667788', '1990-05-20', '996655443', 'javier.medina@example.com';
EXEC agregarEmpleado 'Gabriela Jiménez', '33445566', '1989-08-17', '991122334', 'gabriela.jimenez@example.com';
EXEC agregarEmpleado 'Andrés Castro', '99001122', '1997-01-07', '997788899', 'andres.castro@example.com';
EXEC agregarEmpleado 'Paola Nuñez', '11223366', '1984-04-05', '994466887', 'paola.nunez@example.com';
EXEC agregarEmpleado 'Ricardo Vargas', '88776655', '1991-09-29', '996633221', 'ricardo.vargas@example.com';
EXEC agregarEmpleado 'Valeria López', '11223377', '1986-12-11', '999111222', 'valeria.lopez@example.com';
EXEC agregarEmpleado 'Héctor Díaz', '99887766', '1994-02-14', '995544433', 'hector.diaz@example.com';
EXEC agregarEmpleado 'Cecilia Ríos', '33446688', '1983-07-08', '997711122', 'cecilia.rios@example.com';
EXEC agregarEmpleado 'Martín Ortega', '55668899', '1996-11-23', '994422211', 'martin.ortega@example.com';
EXEC agregarEmpleado 'Ximena Paredes', '11223344', '1981-01-28', '996688899', 'ximena.paredes@example.com';
EXEC agregarEmpleado 'Diego Silva', '77889900', '1999-06-14', '995522233', 'diego.silva@example.com';

select * from ResponsableEmpresa



INSERT INTO Categoria (DescripcionCategoria) VALUES 
('Limpieza del hogar'),
('Cuidado personal'),
('Productos de lavandería'),
('Suministros industriales'),
('Desinfectantes'),
('Utensilios de limpieza'),
('Productos ecológicos'),
('Aromatizantes'),
('Papel y servilletas'),
('Accesorios organización');
go


CREATE PROCEDURE agregarProducto
	@Descripcion	varchar(50),
	@StockMin		int,
	@FechaApertura	DATE,
	@UnidadMedida	varchar(15),
	@CantReposicion	int,
	@IdCategoria	int
AS
BEGIN

	declare @IdProducto int 

	insert into Producto(DescripciónProducto,PrecioBase,StockMin,UnidadMedida,CantidadReposicion,StockActual,IdCategoria)
	VALUES (@Descripcion,0,@StockMin,@UnidadMedida,@CantReposicion,0,@IdCategoria)

	set @IdProducto = SCOPE_IDENTITY()

	insert into Kardex(FechaApertura,IdProducto) values (@FechaApertura,@IdProducto)
END
GO


EXEC AgregarProducto 'Limpiador Multiusos 10L', 62, '2020-01-15', 'Litros', 120, 1;
EXEC AgregarProducto 'Limpiavidrios 400ml', 36, '2020-09-23', 'Mililitros', 52, 1;
EXEC AgregarProducto 'Limpiador de hornos 500ml', 40, '2020-04-05', 'Mililitros', 75, 1;
EXEC AgregarProducto 'Limpiador de baño 350ml', 72, '2019-08-26', 'Mililitros', 145, 1;
EXEC AgregarProducto 'Limpiador de acero inoxidable 500ml', 40, '2019-12-03', 'Mililitros', 83, 1;
EXEC AgregarProducto 'Limpiador de alfombras 18L', 61, '2019-07-09', 'Litros', 100, 1;
EXEC AgregarProducto 'Limpiador de cristales 450ml', 52, '2020-01-17', 'Mililitros', 152, 1;

EXEC AgregarProducto 'Jabón de manos 400ml', 65, '2020-02-10', 'Mililitros', 123, 2;
EXEC AgregarProducto 'Higienizador de cepillos de dientes 600ml', 37, '2019-09-17', 'Mililitros', 65, 2;

EXEC AgregarProducto 'Detergente para ropa 15L', 43, '2020-03-05', 'Litros', 152, 3;
EXEC AgregarProducto 'Removedor de manchas 300ml', 34, '2020-01-20', 'Mililitros', 63, 3;
EXEC AgregarProducto 'Detergente para platos 350ml', 42, '2019-11-09', 'Mililitros', 123, 3;

EXEC AgregarProducto 'Filtros para aspiradora 56 unidades', 43, '2019-08-23', 'Unidades', 85, 4;
EXEC AgregarProducto 'Bolsas de basura resistentes 30 unidades', 64, '2020-02-14', 'Unidades', 123, 4;
EXEC AgregarProducto 'Cera para pisos 5L', 42, '2020-02-12', 'Litros', 64, 4;
EXEC AgregarProducto 'Baldes de limpieza 2 unidades', 40, '2020-01-18', 'Unidades', 83, 4;
EXEC AgregarProducto 'Herramientas de limpieza para jardín', 45, '2020-03-07', 'Unidades', 91, 4;
EXEC AgregarProducto 'Pegamento para reparaciones 600ml', 50, '2020-04-02', 'Mililitros', 100, 4;
EXEC AgregarProducto 'Fibras de limpieza 10 unidades', 72, '2019-05-18', 'Unidades', 140, 4;
EXEC AgregarProducto 'Pulidor de muebles 300ml', 68, '2019-09-18', 'Mililitros', 103,4;
EXEC AgregarProducto 'Limpiador de madera 400ml', 34, '2019-10-14', 'Mililitros', 67, 4;

EXEC AgregarProducto 'Desinfectante de superficies 350ml', 51, '2020-04-20', 'Mililitros', 105, 5;
EXEC AgregarProducto 'Toallitas desinfectantes 100 unidades', 72, '2019-05-19', 'Unidades', 137, 5;

EXEC AgregarProducto 'Esponjas para cocina 5 unidades', 36, '2019-05-12', 'Unidades', 84, 6;
EXEC AgregarProducto 'Cepillos para escoba 45 unidades', 43, '2019-08-18', 'Unidades', 64, 6;
EXEC AgregarProducto 'Esponjas abrasivas 20 unidades', 32, '2019-05-22', 'Unidades', 39, 6;
EXEC AgregarProducto 'Paños de microfibra 10 unidades', 42, '2019-09-20', 'Unidades', 84, 6;
EXEC AgregarProducto 'Piedras desodorizantes 6 unidades', 50, '2019-11-09', 'Unidades', 95, 6;
EXEC AgregarProducto 'Cubetas de almacenamiento', 42, '2019-06-14', 'Unidades', 94, 6;
EXEC AgregarProducto 'Toalleros de cocina 3 unidades', 38, '2019-10-12', 'Unidades', 51, 6;
EXEC AgregarProducto 'Guantes de limpieza 5 pares', 32, '2019-12-04', 'Pares', 54, 6;
EXEC AgregarProducto 'Escobillones para baño', 50, '2020-03-10', 'Unidades', 100, 6;
EXEC AgregarProducto 'Fregonas absorbentes', 49, '2019-12-01', 'Unidades', 76, 6;
EXEC AgregarProducto 'Cepillos para zapatos 3 unidades', 45, '2019-08-24', 'Unidades', 72, 6;
EXEC AgregarProducto 'Estropajos para platos 5 unidades', 54, '2019-10-12', 'Unidades', 86, 6;

EXEC AgregarProducto 'Esponjas mágicas 5 unidades', 53, '2020-03-08', 'Unidades', 84, 7;
EXEC AgregarProducto 'Desatascador de cañerías 70ml', 95, '2019-04-02', 'Mililitros', 48, 7;
EXEC AgregarProducto 'Aceite esencial de limón 500ml', 80, '2019-06-13', 'Mililitros', 40, 7;

EXEC AgregarProducto 'Aromatizante en spray 36ml', 50, '2019-06-08', 'Mililitros', 100, 8;
EXEC AgregarProducto 'Ambientador en gel 28g', 72, '2019-06-17', 'Gramos', 134, 8;
EXEC AgregarProducto 'Difusores de aroma 22ml', 38, '2019-11-07', 'Mililitros', 78, 8;
EXEC AgregarProducto 'Candelas aromáticas 10 unidades', 42, '2019-07-08', 'Unidades', 64, 8;

EXEC AgregarProducto 'Papel higiénico suave 24 rollos', 54, '2019-07-01', 'Rollos', 124, 9;
EXEC AgregarProducto 'Toallas de papel absorbentes', 57, '2019-10-15', 'Unidades', 97, 9;

EXEC AgregarProducto 'Cajas organizadoras', 34, '2020-02-11', 'Unidades', 68, 10;
EXEC AgregarProducto 'Bandejas para cubiertos', 41, '2019-12-02', 'Unidades', 67, 10;

/*
EXEC AgregarProducto 'Limpiador Multiusos 10L', 62, '15-01-2020', 'Litros', 120, 1;
EXEC AgregarProducto 'Limpiavidrios 400ml', 36, '23-09-2020', 'Mililitros', 52, 1;
EXEC AgregarProducto 'Limpiador de hornos 500ml', 40, '05-04-2020', 'Mililitros', 75, 1;
EXEC AgregarProducto 'Limpiador de baño 350ml', 72, '26-08-2019', 'Mililitros', 145, 1;
EXEC AgregarProducto 'Limpiador de acero inoxidable 500ml', 40, '03-12-2019', 'Mililitros', 83, 1;
EXEC AgregarProducto 'Limpiador de alfombras 18L', 61, '09-07-2019', 'Litros', 100, 1;
EXEC AgregarProducto 'Limpiador de cristales 450ml', 52, '17-01-2020', 'Mililitros', 152, 1;

EXEC AgregarProducto 'Jabón de manos 400ml', 65, '10-02-2020', 'Mililitros', 123, 2;
EXEC AgregarProducto 'Higienizador de cepillos de dientes 600ml', 37, '17-09-2019', 'Mililitros', 65, 2;

EXEC AgregarProducto 'Detergente para ropa 15L', 43, '05-03-2020', 'Litros', 152, 3;
EXEC AgregarProducto 'Removedor de manchas 300ml', 34, '20-01-2020', 'Mililitros', 63, 3;
EXEC AgregarProducto 'Detergente para platos 350ml', 42, '09-11-2019', 'Mililitros', 123, 3;

EXEC AgregarProducto 'Filtros para aspiradora 56 unidades', 43, '23-08-2019', 'Unidades', 85, 4;
EXEC AgregarProducto 'Bolsas de basura resistentes 30 unidades', 64, '14-02-2020', 'Unidades', 123, 4;
EXEC AgregarProducto 'Cera para pisos 5L', 42, '12-02-2020', 'Litros', 64, 4;
EXEC AgregarProducto 'Baldes de limpieza 2 unidades', 40, '18-01-2020', 'Unidades', 83, 4;
EXEC AgregarProducto 'Herramientas de limpieza para jardín', 45, '07-03-2020', 'Unidades', 91, 4;
EXEC AgregarProducto 'Pegamento para reparaciones 600ml', 50, '02-04-2020', 'Mililitros', 100, 4;
EXEC AgregarProducto 'Fibras de limpieza 10 unidades', 72, '18-05-2019', 'Unidades', 140, 4;
EXEC AgregarProducto 'Pulidor de muebles 300ml', 68, '18-09-2019', 'Mililitros', 103, 4;
EXEC AgregarProducto 'Limpiador de madera 400ml', 34, '14-10-2019', 'Mililitros', 67, 4;

EXEC AgregarProducto 'Desinfectante de superficies 350ml', 51, '20-04-2020', 'Mililitros', 105, 5;
EXEC AgregarProducto 'Toallitas desinfectantes 100 unidades', 72, '19-05-2019', 'Unidades', 137, 5;

EXEC AgregarProducto 'Esponjas para cocina 5 unidades', 36, '12-05-2019', 'Unidades', 84, 6;
EXEC AgregarProducto 'Cepillos para escoba 45 unidades', 43, '18-08-2019', 'Unidades', 64, 6;
EXEC AgregarProducto 'Esponjas abrasivas 20 unidades', 32, '22-05-2019', 'Unidades', 39, 6;
EXEC AgregarProducto 'Paños de microfibra 10 unidades', 42, '20-09-2019', 'Unidades', 84, 6;
EXEC AgregarProducto 'Piedras desodorizantes 6 unidades', 50, '09-11-2019', 'Unidades', 95, 6;
EXEC AgregarProducto 'Cubetas de almacenamiento', 42, '14-06-2019', 'Unidades', 94, 6;
EXEC AgregarProducto 'Toalleros de cocina 3 unidades', 38, '12-10-2019', 'Unidades', 51, 6;
EXEC AgregarProducto 'Guantes de limpieza 5 pares', 32, '04-12-2019', 'Pares', 54, 6;
EXEC AgregarProducto 'Escobillones para baño', 50, '10-03-2020', 'Unidades', 100, 6;
EXEC AgregarProducto 'Fregonas absorbentes', 49, '01-12-2019', 'Unidades', 76, 6;
EXEC AgregarProducto 'Cepillos para zapatos 3 unidades', 45, '24-08-2019', 'Unidades', 72, 6;
EXEC AgregarProducto 'Estropajos para platos 5 unidades', 54, '12-10-2019', 'Unidades', 86, 6;

EXEC AgregarProducto 'Esponjas mágicas 5 unidades', 53, '08-03-2020', 'Unidades', 84, 7;
EXEC AgregarProducto 'Desatascador de cañerías 70ml', 95, '02-04-2019', 'Mililitros', 48, 7;
EXEC AgregarProducto 'Aceite esencial de limón 500ml', 80, '13-06-2019', 'Mililitros', 40, 7;

EXEC AgregarProducto 'Aromatizante en spray 36ml', 50, '08-06-2019', 'Mililitros', 100, 8;
EXEC AgregarProducto 'Ambientador en gel 28g', 72, '17-06-2019', 'Gramos', 134, 8;
EXEC AgregarProducto 'Difusores de aroma 22ml', 38, '07-11-2019', 'Mililitros', 78, 8;
EXEC AgregarProducto 'Candelas aromáticas 10 unidades', 42, '08-07-2019', 'Unidades', 64, 8;

EXEC AgregarProducto 'Papel higiénico suave 24 rollos', 54, '01-07-2019', 'Rollos', 124, 9;
EXEC AgregarProducto 'Toallas de papel absorbentes', 57, '15-10-2019', 'Unidades', 97, 9;

EXEC AgregarProducto 'Cajas organizadoras', 34, '11-02-2020', 'Unidades', 68, 10;
EXEC AgregarProducto 'Bandejas para cubiertos', 41, '02-12-2019', 'Unidades', 67, 10;
go
*/
go

ALTER PROCEDURE agregarProducto
	@Descripcion	varchar(50),
	@StockMin		int,
	@UnidadMedida	varchar(15),
	@CantReposicion	int,
	@IdCategoria	int
AS
BEGIN

	insert into Producto(DescripciónProducto,PrecioBase,StockMin,UnidadMedida,CantidadReposicion,StockActual,IdCategoria)
	VALUES (@Descripcion,0,@StockMin,@UnidadMedida,@CantReposicion,0,@IdCategoria)


END
GO

CREATE TRIGGER productoKardex on Producto after insert
as
BEGIN
	declare @IdProducto int

	select @IdProducto=IdProducto from inserted

	insert into Kardex(IdProducto,FechaApertura) values (@IdProducto,GETDATE())
END
GO

CREATE PROCEDURE agregarCliente
	@Nombre varchar(50),
	@Telefono varchar(20),
	@Correo varchar(50),
	@TipoCliente varchar(8),
	@CiudadCliente varchar(20),
	@GeneroCliente varchar(10)
AS
BEGIN
	insert into Cliente(NombreCliente,TelefonoCliente,CorreoCliente,TipoCliente,CiudadCliente,GeneroCliente) values (@Nombre,@Telefono,@Correo,@TipoCliente,@CiudadCliente,@GeneroCliente)
END
GO


EXEC agregarCliente 'Elena Gómez', '987654321', 'elena.gomez@example.com', 'Natural', 'Trujillo', 'Femenino';
EXEC agregarCliente 'Alejandro Ramírez', '9955667788', 'alejandro.ramirez@example.com', 'Jurídico', 'Lima', 'Masculino';
EXEC agregarCliente 'Mónica Soto', '9966332211', 'monica.soto@example.com', 'Natural', 'Arequipa', 'Femenino';
EXEC agregarCliente 'Ricardo Flores', '9988776655', 'ricardo.flores@example.com', 'Jurídico', 'Cusco', 'Masculino';
EXEC agregarCliente 'Lorena Martínez', '9944221100', 'lorena.martinez@example.com', 'Natural', 'Lima', 'Femenino';
EXEC agregarCliente 'Fernando Mendoza', '9999888777', 'fernando.mendoza@example.com', 'Jurídico', 'Piura', 'Masculino';
EXEC agregarCliente 'Carmen Vargas', '9977554433', 'carmen.vargas@example.com', 'Natural', 'Trujillo', 'Femenino';
EXEC agregarCliente 'Hugo Torres', '9933445566', 'hugo.torres@example.com', 'Jurídico', 'Lima', 'Masculino';
EXEC agregarCliente 'Patricia Herrera', '9990001111', 'patricia.herrera@example.com', 'Natural', 'Arequipa', 'Femenino';
EXEC agregarCliente 'Raúl González', '9944333222', 'raul.gonzalez@example.com', 'Jurídico', 'Cusco', 'Masculino';
EXEC agregarCliente 'Laura Pérez', '9911223344', 'laura.perez@example.com', 'Natural', 'Lima', 'Femenino';
EXEC agregarCliente 'José García', '9977888999', 'jose.garcia@example.com', 'Jurídico', 'Piura', 'Masculino';
EXEC agregarCliente 'Susana López', '9944668877', 'susana.lopez@example.com', 'Natural', 'Trujillo', 'Femenino';
EXEC agregarCliente 'Martín Ramírez', '9966332211', 'martin.ramirez@example.com', 'Jurídico', 'Lima', 'Masculino';
EXEC agregarCliente 'Diana Martínez', '9991112222', 'diana.martinez@example.com', 'Natural', 'Arequipa', 'Femenino';
EXEC agregarCliente 'Roberto Díaz', '9955444333', 'roberto.diaz@example.com', 'Jurídico', 'Cusco', 'Masculino';
EXEC agregarCliente 'Carolina Ríos', '9977111222', 'carolina.rios@example.com', 'Natural', 'Lima', 'Femenino';
EXEC agregarCliente 'Santiago Ortega', '9944222111', 'santiago.ortega@example.com', 'Jurídico', 'Piura', 'Masculino';
EXEC agregarCliente 'Natalia Paredes', '9966888999', 'natalia.paredes@example.com', 'Natural', 'Trujillo', 'Femenino';
EXEC agregarCliente 'Alberto Silva', '9955222333', 'alberto.silva@example.com', 'Jurídico', 'Lima', 'Masculino';
go

CREATE PROCEDURE agregarProveedor
	@Nombre varchar(40),
	@Telefono varchar(20),
	@Correo varchar(50),
	@Direccion varchar(50),
	@Ciudad varchar(20),
	@Pais varchar(20)
AS
BEGIN
	insert into Proveedor(NombreProveedor,TelefonoProveedor,CorreoProveedor,DireccionProveedor,CiudadProveedor,PaisProveedor) 
	values (@Nombre,@Telefono,@Correo,@Direccion,@Ciudad,@Pais)
END
GO

-- Categoría 1: Limpieza del hogar
EXEC agregarProveedor 'ProveedorLimpieza', '123456789', 'proveedorlimpieza@example.com', 'Calle Principal 123', 'Lima', 'Perú';
-- Categoría 2: Cuidado personal
EXEC agregarProveedor 'ProveedorCuidado', '987654321', 'proveedorcuidado@example.com', 'Avenida Secundaria 456', 'Madrid', 'España';
-- Categoría 3: Productos de lavandería
EXEC agregarProveedor 'ProveedorLavanderia', '1111222233', 'proveedorlavanderia@example.com', 'Av. Lavado 789', 'Nueva York', 'Estados Unidos';
-- Categoría 4: Suministros de limpieza industrial
EXEC agregarProveedor 'ProveedorIndustrial', '5555666677', 'proveedorindustrial@example.com', 'Industrial Street 456', 'Shanghái', 'China';
-- Categoría 5: Desinfectantes
EXEC agregarProveedor 'ProveedorDesinfectantes', '8888999900', 'proveedordesinfectantes@example.com', 'Av. Desinfección 123', 'Moscú', 'Rusia';
-- Categoría 6: Utensilios de limpieza
EXEC agregarProveedor 'ProveedorUtensilios', '4444555566', 'proveedorutensilios@example.com', 'Utensilios Blvd. 789', 'Sídney', 'Australia';
-- Categoría 7: Productos ecológicos
EXEC agregarProveedor 'ProveedorEcológicos', '1212121212', 'proveedorecologicos@example.com', 'Eco Street 456', 'París', 'Francia';
-- Categoría 8: Aromatizantes
EXEC agregarProveedor 'ProveedorAromatizantes', '3434343434', 'proveedoraromatizantes@example.com', 'Aroma Avenue 789', 'Roma', 'Italia';
-- Categoría 9: Papel higiénico y servilletas
EXEC agregarProveedor 'ProveedorPapel', '6767676767', 'proveedorpapel@example.com', 'Papel Street 123', 'Ciudad de México', 'México';
-- Categoría 10: Accesorios de organización
EXEC agregarProveedor 'ProveedorOrganización', '9898989898', 'proveedororganizacion@example.com', 'Organización Blvd. 456', 'Tokio', 'Japón';
go



CREATE PROCEDURE agregarServicio
	@DescripcionServicio varchar(50)
AS
BEGIN
	insert into Servicio(DescripcionServicio) values (@DescripcionServicio)
END
GO

EXEC agregarServicio 'Asesoramiento Personalizado'
EXEC agregarServicio 'Entrega Programada'
EXEC agregarServicio 'Programa de Reciclaje'
EXEC agregarServicio 'Etiquetado Personalizado'
EXEC agregarServicio 'Servicio de Reposición Automática'
EXEC agregarServicio 'Pruebas y Certificaciones'
EXEC agregarServicio 'Servicio de Entrega Rápida'
EXEC agregarServicio 'Marketing Conjunto'
EXEC agregarServicio 'Programa de Lealtad'
EXEC agregarServicio 'Análisis de Costos'
go


CREATE PROCEDURE proveedorServicio
	@IdProveedor int,
	@IdServicio int,
	@FechaInicio date,
	@PrecioServicio money
AS
BEGIN
	insert into Servicio_Proveedor(IdProveedor,IdServicio,FechaInicio,PrecioServicio) values (@IdProveedor,@IdServicio,@FechaInicio,@PrecioServicio)
END
GO


EXEC proveedorServicio 1, 1, '2020-01-15', 50.00
EXEC proveedorServicio 1, 2, '2020-02-10', 80.00
EXEC proveedorServicio 1, 3, '2020-03-05', 60.00
EXEC proveedorServicio 2, 4, '2020-04-20', 75.00
EXEC proveedorServicio 2, 5, '2019-05-15', 55.00
EXEC proveedorServicio 3, 6, '2019-06-10', 70.00
EXEC proveedorServicio 3, 7, '2019-07-05', 90.00
EXEC proveedorServicio 4, 8, '2019-08-20', 85.00
EXEC proveedorServicio 4, 9, '2019-09-15', 65.00
EXEC proveedorServicio 5, 10, '2019-10-01', 75.00
EXEC proveedorServicio 5, 1, '2019-11-15', 60.00
EXEC proveedorServicio 6, 2, '2019-12-05', 70.00
EXEC proveedorServicio 6, 3, '2020-01-20', 85.00
EXEC proveedorServicio 7, 4, '2020-02-10', 55.00
EXEC proveedorServicio 7, 5, '2020-03-25', 90.00
EXEC proveedorServicio 8, 6, '2020-04-15', 80.00
EXEC proveedorServicio 8, 7, '2019-05-30', 65.00
EXEC proveedorServicio 9, 8, '2019-06-20', 75.00
EXEC proveedorServicio 9, 9, '2019-07-05', 50.00
EXEC proveedorServicio 10, 10, '2019-08-01', 60.00
EXEC proveedorServicio 10, 1, '2019-09-15', 85.00

/*
EXEC proveedorServicio 1, 1, '15-01-2020', 50.00
EXEC proveedorServicio 1, 2, '10-02-2020', 80.00
EXEC proveedorServicio 1, 3, '05-03-2020', 60.00
EXEC proveedorServicio 2, 4, '20-04-2020', 75.00
EXEC proveedorServicio 2, 5, '15-05-2019', 55.00
EXEC proveedorServicio 3, 6, '10-06-2019', 70.00
EXEC proveedorServicio 3, 7, '05-07-2019', 90.00
EXEC proveedorServicio 4, 8, '20-08-2019', 85.00
EXEC proveedorServicio 4, 9, '15-09-2019', 65.00
EXEC proveedorServicio 5, 10, '01-10-2019', 75.00
EXEC proveedorServicio 5, 1, '15-11-2019', 60.00
EXEC proveedorServicio 6, 2, '05-12-2019', 70.00
EXEC proveedorServicio 6, 3, '20-01-2020', 85.00
EXEC proveedorServicio 7, 4, '10-02-2020', 55.00
EXEC proveedorServicio 7, 5, '25-03-2020', 90.00
EXEC proveedorServicio 8, 6, '15-04-2020', 80.00
EXEC proveedorServicio 8, 7, '30-05-2019', 65.00
EXEC proveedorServicio 9, 8, '20-06-2019', 75.00
EXEC proveedorServicio 9, 9, '05-07-2019', 50.00
EXEC proveedorServicio 10, 10, '01-08-2019', 60.00
EXEC proveedorServicio 10, 1, '15-09-2019', 85.00
go
*/
go

CREATE PROCEDURE proveedorProducto
	@IdProveedor int,
	@IdProducto int,
	@Costo money
AS
BEGIN
	insert into Producto_Proveedor(IdProveedor,IdProducto,PrecioCompra) values(@IdProveedor,@IdProducto,@Costo)
END
GO

EXEC proveedorProducto 1, 1, 12.50
EXEC proveedorProducto 1, 2, 18.75
EXEC proveedorProducto 1, 3, 25.00
EXEC proveedorProducto 1, 4, 15.50
EXEC proveedorProducto 1, 5, 22.90
EXEC proveedorProducto 1, 6, 30.25
EXEC proveedorProducto 1, 7, 17.8
EXEC proveedorProducto 2, 8, 8.50
EXEC proveedorProducto 2, 9, 12.75
EXEC proveedorProducto 3, 10, 15.25
EXEC proveedorProducto 3, 11, 10.50
EXEC proveedorProducto 3, 12, 7.90
EXEC proveedorProducto 4, 13, 9.95
EXEC proveedorProducto 4, 14, 14.30
EXEC proveedorProducto 4, 15, 18.75
EXEC proveedorProducto 4, 16, 12.50
EXEC proveedorProducto 4, 17, 22.90
EXEC proveedorProducto 4, 18, 5.80
EXEC proveedorProducto 4, 19, 8.20
EXEC proveedorProducto 4, 20, 11.40
EXEC proveedorProducto 4, 21, 14.75
EXEC proveedorProducto 5, 22, 13.90
EXEC proveedorProducto 5, 23, 8.50
EXEC proveedorProducto 6, 24, 6.90
EXEC proveedorProducto 6, 25, 9.75
EXEC proveedorProducto 6, 26, 4.50
EXEC proveedorProducto 6, 27, 12.25
EXEC proveedorProducto 6, 28, 5.80
EXEC proveedorProducto 6, 29, 17.40
EXEC proveedorProducto 6, 30, 8.90
EXEC proveedorProducto 6, 31, 6.20
EXEC proveedorProducto 6, 32, 10.75
EXEC proveedorProducto 6, 33, 14.30
EXEC proveedorProducto 6, 34, 7.60
EXEC proveedorProducto 6, 35, 5.95
EXEC proveedorProducto 7, 36, 9.20
EXEC proveedorProducto 7, 37, 14.90
EXEC proveedorProducto 7, 38, 20.50
EXEC proveedorProducto 8, 39, 11.75
EXEC proveedorProducto 8, 40, 8.90
EXEC proveedorProducto 8, 41, 15.50
EXEC proveedorProducto 8, 42, 7.20
EXEC proveedorProducto 9, 43, 13.50
EXEC proveedorProducto 9, 44, 16.75
EXEC proveedorProducto 10, 45, 9.90
EXEC proveedorProducto 10, 46, 12.25
go



--------------------------------------------------------------------------------------------------------------------------
CREATE PROCEDURE agregarDetalleV
	@IdProducto int,
	@Cantidad	int
AS
BEGIN
	declare @PrecioU money

	select @PrecioU =PrecioBase from Producto where @IdProducto=IdProducto

	--Porcentaje de ganancia
	set @PrecioU+=@PrecioU*(0.2+0.18)
	INSERT INTO DetalleVenta(CantidadVendida,PrecioUnitario,IdVenta,IdProducto) values (@Cantidad,@PrecioU,0,@IdProducto)


END
GO

CREATE PROCEDURE agregarVenta
	@IdCliente	int
AS
BEGIN
	declare @Monto money
	select @Monto = SUM(CantidadVendida*PrecioUnitario) from DetalleVenta where IdVenta =0
	insert into Venta(IdCliente,NumeroDocumento,MontoVenta) values (@IdCliente,null,@Monto)
END
GO

CREATE TRIGGER T_Ventas on Venta for insert
as
begin
	declare @IdVenta int,
			@Cantidad int,
			@IdProducto int

	select @IdVenta= IdVenta from inserted
	update DetalleVenta set IdVenta=@IdVenta where IdVenta =0 
end
go


create TRIGGER stockVenta on Venta AFTER INSERT
AS
BEGIN
    UPDATE Producto
	set StockActual = StockActual - D.CantidadVendida
	from Producto P

	INNER JOIN DetalleVenta D ON P.IdProducto = D.IdProducto
	INNER JOIN inserted I ON I.IdVenta= D.IdVenta
END
GO


CREATE TRIGGER T_DetalleVentas on DetalleVenta for insert
as
begin
	begin transaction
	declare @IdProducto int,
			@CantidadVendida int,
			@StockActual int,
			@StockMinimo int
	
	select @IdProducto=IdProducto,@CantidadVendida=CantidadVendida from inserted
	select @StockActual=StockActual,@StockMinimo=StockMin from Producto where @IdProducto=IdProducto
	
	if @CantidadVendida>@StockActual
		begin
			rollback transaction
			raiserror('No se tiene suficiente Stock',16,2)
		end
	else
		begin
			if @StockMinimo>=@StockActual
				begin
					PRINT('El stock está por debajo del mínimo')
				end


			commit transaction
		end
end
GO



create PROCEDURE agregarDetalleC
	@IdProducto int
AS
BEGIN
	declare @PrecioU money,
			@Cantidad int

	select @Cantidad=CantidadReposicion from Producto where @IdProducto=IdProducto
	select @PrecioU=PrecioCompra from Producto_Proveedor where IdProducto=@IdProducto

	INSERT INTO DetalleCompra(CantidadComprada,PrecioUnitario,IdCompra,IdProducto) values (@Cantidad,@PrecioU,0,@IdProducto)

END
GO



CREATE PROCEDURE agregarCompra
AS
BEGIN
	declare @Monto money,
			@IdProveedor int
	select top 1 @IdProveedor = PP.IdProveedor
	from DetalleCompra DC
	inner join Producto_Proveedor PP on DC.IdProducto = PP.IdProducto
	where DC.IdCompra=0

	select @Monto = SUM(CantidadComprada*PrecioUnitario) from DetalleCompra where IdCompra =0
	insert into Compra(IdProveedor,NumeroDocumento,MontoCompra) values (@IdProveedor,null,@Monto)
END
GO



CREATE TRIGGER T_Compras on Compra for insert
as
begin
	declare @IdCompra int
	select @IdCompra = IdCompra from inserted

	UPDATE DetalleCompra set IdCompra= @IdCompra where IdCompra =0
end
go

CREATE TRIGGER stockCompra on Compra after insert
as
begin
	UPDATE Producto
	set StockActual = StockActual + D.CantidadComprada
	from Producto P

	INNER JOIN DetalleCompra D ON P.IdProducto = D.IdProducto
	INNER JOIN inserted I ON I.IdCompra= D.IdCompra
end
go


/*
CREATE TRIGGER devolverCompra on detalleCompra for delete
as
begin
	declare @IdCompra int
	select @IdCompra = IdCompra from deleted
	if @IdCompra=0
	begin
		
	end
	else
	begin
		UPDATE Producto
		set StockActual = StockActual - D.CantidadComprada
		from Producto P

		INNER JOIN DetalleCompra D ON P.IdProducto = D.IdProducto
		INNER JOIN inserted I ON I.IdCompra= D.IdCompra
	end

	
end
go
*/

CREATE TRIGGER precioBase ON Compra AFTER INSERT
AS
BEGIN
    DECLARE @IdProveedor INT,
            @Vendidos INT,
            @IdCompra INT,
            @Servicios MONEY


    SELECT @IdProveedor = IdProveedor, @IdCompra = IdCompra FROM inserted

    SELECT @Vendidos = sum(CantidadComprada) FROM DetalleCompra WHERE IdCompra = @IdCompra

	SELECT @Servicios=sum(PrecioServicio) from Servicio_Proveedor where IdProveedor=@IdProveedor

    UPDATE P
    SET P.PrecioBase = PP.PrecioCompra + (@Servicios / @Vendidos)
    FROM Producto P
    INNER JOIN DetalleCompra D ON P.IdProducto = D.IdProducto
    INNER JOIN inserted I ON D.IdCompra = I.IdCompra
    INNER JOIN Proveedor Pv ON I.IdProveedor = Pv.IdProveedor
    INNER JOIN Producto_Proveedor PP ON P.IdProducto = PP.IdProducto AND Pv.IdProveedor = PP.IdProveedor
END
GO


CREATE TRIGGER T_DetalleCompras on DetalleCompra for insert
as
begin
	begin transaction
	declare @StockActual int,
			@StockMinimo int,
			@IdProducto int
	
	select @IdProducto=IdProducto from inserted
	select @StockActual=StockActual,@StockMinimo=StockMin from Producto where @IdProducto=IdProducto

	if @StockActual>@StockMinimo
		begin
			rollback transaction
			raiserror('Aún se cuenta con suficiente stock',16,2)
		end
	else
		begin
			commit transaction
		end
end
go


insert into TipoDocumento(TipoDoc,Descripcion) values ('F','Factura'),('B','Boleta'),('Guía','Guía de Remisión')
go
--------------------------------------------------------------------------------------------------------


create  PROCEDURE crearDocumento
	@IdResp		varchar(10),
	@FechaDoc		datetime
AS
BEGIN
	declare @IdPrincipal	int,
			@PrecioDoc		money
	
	IF exists(select 1 from Venta where NumeroDocumento is null and IdVenta!=0)
	begin
		select @PrecioDoc=MontoVenta from Venta where NumeroDocumento is null and IdVenta!=0
		insert into Documento(FechaDocumento,PrecioDocumento,TipoDoc,IdResp) values (@FechaDoc,@PrecioDoc,null,@IdResp)


	end
	ELSE IF exists(select 1 from Compra where NumeroDocumento is null and IdCompra!=0)
	begin
		select  @PrecioDoc=MontoCompra from Compra where NumeroDocumento is null and IdCompra!=0
		insert into Documento(FechaDocumento,PrecioDocumento,TipoDoc,IdResp) values (@FechaDoc,-@PrecioDoc,null,@IdResp)

	end

END
GO


create TRIGGER T_TipoDocumento on Documento for insert
AS
BEGIN
	declare @numDoc int,
			@Id		int,
			@tipoCliente varchar(8),
			@Doc	varchar(4)

	select @numDoc=NumeroDocumento from inserted

	IF exists(select 1 from Venta where NumeroDocumento is null and IdVenta!=0)
	begin
		
		SELECT @tipoCliente = C.TipoCliente
		FROM Venta V
		INNER JOIN Cliente C ON V.IdCliente = C.IdCliente
		WHERE V.NumeroDocumento is null


		if @tipoCliente='Natural'
		begin
			set @Doc = 'B'
		end
		else if @tipoCliente='Jurídico'
		begin
			set @Doc = 'F'
		end

		update Venta set NumeroDocumento = @numDoc where NumeroDocumento is null and IdVenta!=0
	end
	ELSE IF exists(select 1 from Compra where NumeroDocumento is null and IdCompra!=0)
	begin
		set @Doc = 'Guía'

		update Compra set NumeroDocumento = @numDoc where NumeroDocumento is null and IdCompra!=0
	end

	UPDATE Documento
		set TipoDoc = @Doc
	where NumeroDocumento=@numDoc

END
GO



CREATE FUNCTION generarMovimientoId(@IdKardex INT)
returns varchar(4)
as
begin
	declare @IdMov varchar(4)

	select @IdMoV = left(P.DescripciónProducto,4)
	from Kardex K
	INNER JOIN Producto P ON K.IdProducto=P.IdProducto
	where K.IdKardex=@IdKardex

	return @IdMov
end
go


create TRIGGER T_Documento on Documento after insert
as
begin
	declare @NumeroDoc int,
			@Id int,
			@Monto money,
			@Tipo varchar(4),
			@Fecha datetime,
			@IdProv int,
			@IdResponsable varchar(10),
			@IdProducto	int

	select @NumeroDoc=NumeroDocumento, @Monto = PrecioDocumento, @Tipo=TipoDoc from inserted
	select @Fecha=FechaDocumento from Documento where @NumeroDoc=NumeroDocumento
	
	if @Monto>0
	begin

		select @Id=IdVenta from Venta where NumeroDocumento=@NumeroDoc
		
		insert into MovimientoKardex(IdKardex,IdProveedor,NumeroDocumento,StockAnterior,TipoMovimiento, Cantidad, IdMovimiento, StockActual,Monto)
		select K.IdKardex,PV.IdProveedor,@NumeroDoc,P.StockActual+DV.CantidadVendida,'S',DV.CantidadVendida,dbo.generarMovimientoId(K.IdKardex),P.StockActual,DV.CantidadVendida*DV.PrecioUnitario
		from DetalleVenta DV 
		INNER JOIN Producto P ON DV.IdProducto=P.IdProducto
		INNER JOIN Producto_Proveedor PV ON P.IdProducto=PV.IdProducto
		INNER JOIN Kardex K ON P.IdProducto= K.IdProducto
		where DV.IdVenta= @Id
	end

	else
	begin
		
		select @Id=IdCompra from Compra where NumeroDocumento=@NumeroDoc

		insert into MovimientoKardex(IdKardex,IdProveedor,NumeroDocumento,StockAnterior,TipoMovimiento, Cantidad, IdMovimiento, StockActual,Monto)
		select k.IdKardex,PV.IdProveedor,@NumeroDoc,P.StockActual-DC.CantidadComprada,'I',DC.CantidadComprada,dbo.generarMovimientoId(K.IdKardex),P.StockActual,DC.CantidadComprada*DC.PrecioUnitario
		from DetalleCompra DC
		INNER JOIN Producto P ON DC.IdProducto=P.IdProducto
		INNER JOIN Producto_Proveedor PV ON P.IdProducto=PV.IdProducto
		INNER JOIN Kardex K ON P.IdProducto= K.IdProducto
		where @Id=DC.IdCompra
	end
end
go
--


/*
EXEC agregarDetalleC 1
EXEC agregarDetalleC 2
EXEC agregarDetalleC 3
EXEC agregarDetalleC 4
EXEC agregarDetalleC 5
EXEC agregarDetalleC 6
EXEC agregarDetalleC 7
EXEC agregarCompra 
EXEC crearDocumento '0801', '2020-15-01 08:23:45';

EXEC agregarDetalleC 8
EXEC agregarDetalleC 9
EXEC agregarCompra 
EXEC crearDocumento '0851', '2020-01-02 14:37:21';

EXEC agregarDetalleC 10
EXEC agregarDetalleC 11
EXEC agregarDetalleC 12
EXEC agregarCompra 
EXEC crearDocumento '0951', '2020-10-01 09:45:32';

EXEC agregarDetalleC 13
EXEC agregarDetalleC 14
EXEC agregarDetalleC 15
EXEC agregarDetalleC 16
EXEC agregarDetalleC 17
EXEC agregarDetalleC 18
EXEC agregarDetalleC 19
EXEC agregarDetalleC 20
EXEC agregarDetalleC 21
EXEC agregarCompra 
EXEC crearDocumento '0951', '2020-07-03 12:18:56';

EXEC agregarDetalleC 22
EXEC agregarDetalleC 23
EXEC agregarCompra 
EXEC crearDocumento '0801', '2020-13-02 18:59:24';

select * from ResponsableEmpresa

EXEC agregarDetalleC 24
EXEC agregarDetalleC 25
EXEC agregarDetalleC 26
EXEC agregarDetalleC 27
EXEC agregarDetalleC 28
EXEC agregarDetalleC 29
EXEC agregarDetalleC 30
EXEC agregarDetalleC 31
EXEC agregarDetalleC 32
EXEC agregarDetalleC 33
EXEC agregarDetalleC 34
EXEC agregarDetalleC 35
EXEC agregarCompra 
EXEC crearDocumento '4811', '2020-11-02 03:42:17';

EXEC agregarDetalleC 36
EXEC agregarDetalleC 37
EXEC agregarDetalleC 38
EXEC agregarCompra 
EXEC crearDocumento '0801', '2019-05-12 21:30:09';


EXEC agregarDetalleC 39
EXEC agregarDetalleC 40
EXEC agregarDetalleC 41
EXEC agregarDetalleC 42
EXEC agregarCompra
EXEC crearDocumento '0851', '2020-08-03 10:15:38';

EXEC agregarDetalleC 43
EXEC agregarDetalleC 44
EXEC agregarCompra
EXEC crearDocumento '0851', '2020-20-01 16:27:53';

EXEC agregarDetalleC 45
EXEC agregarDetalleC 46
EXEC agregarCompra 
EXEC crearDocumento '0801', '2020-18-02 07:14:29';

EXEC agregarDetalleV 1, 5
EXEC agregarDetalleV 2, 8
EXEC agregarDetalleV 3, 3
EXEC agregarVenta 5
EXEC crearDocumento '4841', '2020-01-04 23:08:42'

EXEC agregarDetalleV 4, 7
EXEC agregarDetalleV 5, 1
EXEC agregarVenta 14
EXEC crearDocumento '4881', '2020-15-06 05:56:13'

EXEC agregarDetalleV 6, 10
EXEC agregarDetalleV 7, 4
EXEC agregarDetalleV 8, 9
EXEC agregarVenta 9
EXEC crearDocumento '4961', '2020-29-08 14:02:50'

EXEC agregarDetalleV 9, 2
EXEC agregarVenta 18
EXEC crearDocumento '4921', '2020-10-11 19:45:06'

EXEC agregarDetalleV 10, 6
EXEC agregarDetalleV 11, 3
EXEC agregarDetalleV 12, 7
EXEC agregarDetalleV 13, 1
EXEC agregarVenta 7
EXEC crearDocumento '4901', '2021-24-01 02:36:18'

EXEC agregarDetalleV 14, 8
EXEC agregarVenta 20
EXEC crearDocumento '4871', '2021-08-04 11:27:54'

EXEC agregarDetalleV 15, 5
EXEC agregarVenta 12
EXEC crearDocumento '4991', '2021-21-06 08:10:37'

EXEC agregarDetalleV 16, 9
EXEC agregarDetalleV 17, 2
EXEC agregarVenta 3
EXEC crearDocumento '4981', '2021-03-09 17:53:09'

EXEC agregarDetalleV 18, 6
EXEC agregarDetalleV 19, 4
EXEC agregarVenta 16
EXEC crearDocumento '4991', '2021-17-11 06:20:48'

EXEC agregarDetalleV 20, 10
EXEC agregarVenta 11
EXEC crearDocumento '4881', '2022-01-02 22:49:33'

EXEC agregarDetalleV 21, 8
EXEC agregarVenta 2
EXEC crearDocumento '4841', '2022-15-03 13:14:27'

EXEC agregarDetalleV 22, 1
EXEC agregarVenta 10
EXEC crearDocumento '4911', '2021-29-05 04:37:59'

EXEC agregarDetalleV 23, 5
EXEC agregarVenta 17
EXEC crearDocumento '4971', '2021-10-08 16:08:11'

EXEC agregarDetalleV 24, 3
EXEC agregarDetalleV 25, 7
EXEC agregarVenta 8
EXEC crearDocumento '4931', '2021-24-10 09:52:46'

EXEC agregarDetalleV 26, 2
EXEC agregarVenta 13
EXEC crearDocumento '4941', '2022-06-01 01:27:35'

EXEC agregarDetalleV 27, 6
EXEC agregarDetalleV 28, 4
EXEC agregarVenta 6
EXEC crearDocumento '4891', '2022-20-03 18:40:59'

EXEC agregarDetalleV 29, 9
EXEC agregarDetalleV 30, 1
EXEC agregarVenta 15
EXEC crearDocumento '4861', '2020-02-06 20:04:12'

EXEC agregarDetalleV 31, 10
EXEC agregarDetalleV 32, 5
EXEC agregarVenta 4
EXEC crearDocumento '4961', '2020-15-08 23:49:57'

EXEC agregarDetalleV 33, 7
EXEC agregarDetalleV 34, 3
EXEC agregarVenta 19
EXEC crearDocumento '4881', '2021-29-10 08:33:25'

EXEC agregarDetalleV 35, 6
EXEC agregarDetalleV 36, 9
EXEC agregarVenta 1
EXEC crearDocumento '4821', '2021-12-01 14:11:19'

EXEC agregarDetalleV 37, 2
EXEC agregarDetalleV 38, 8
EXEC agregarVenta 9
EXEC crearDocumento '4991', '2022-26-03 03:21:43'

EXEC agregarDetalleV 39, 4
EXEC agregarDetalleV 40, 10
EXEC agregarVenta 3
EXEC crearDocumento '4901', '2020-08-06 06:45:28'

EXEC agregarDetalleV 7, 6
EXEC agregarDetalleV 15, 3
EXEC agregarVenta 16
EXEC crearDocumento '4941', '2022-22-08 17:18:14'

EXEC agregarDetalleV 29, 8
EXEC agregarDetalleV 20, 4
EXEC agregarVenta 12
EXEC crearDocumento '0801', '2022-04-11 19:09:08'

EXEC agregarDetalleV 11, 1
EXEC agregarDetalleV 36, 10
EXEC agregarVenta 7
EXEC crearDocumento '4911', '2021-18-01 10:54:51'

EXEC agregarDetalleV 3, 2
EXEC agregarDetalleV 25, 7
EXEC agregarVenta 18
EXEC crearDocumento '4931', '2021-02-04 12:37:24'

EXEC agregarDetalleV 14, 5
EXEC agregarDetalleV 40, 9
EXEC agregarVenta 5
EXEC crearDocumento '4881', '2020-16-06 21:06:32'

EXEC agregarDetalleV 5, 1
EXEC agregarDetalleV 33, 6
EXEC agregarVenta 14
EXEC crearDocumento '4861', '2020-30-08 15:29:46'

EXEC agregarDetalleV 22, 4
EXEC agregarVenta 20
EXEC crearDocumento '0851', '2021-11-11 08:02:57'

EXEC agregarDetalleV 18, 10
EXEC agregarDetalleV 37, 3
EXEC agregarVenta 11
EXEC crearDocumento '4811', '2021-25-01 02:13:35'

EXEC agregarDetalleV 8, 9
EXEC agregarDetalleV 16, 2
EXEC agregarVenta 13
EXEC crearDocumento '4971', '2021-09-04 05:48:13'

EXEC agregarDetalleV 31, 7
EXEC agregarDetalleV 10, 8
EXEC agregarVenta 6
EXEC crearDocumento '4821', '2021-23-06 16:41:26'

EXEC agregarDetalleV 26, 5
EXEC agregarDetalleV 2, 1
EXEC agregarVenta 15
EXEC crearDocumento '4981', '2021-06-09 22:24:04'

EXEC agregarDetalleV 39, 10
EXEC agregarDetalleV 24, 3
EXEC agregarVenta 4
EXEC crearDocumento '4821', '2021-20-11 19:57:18'

EXEC agregarDetalleV 13, 7
EXEC agregarDetalleV 32, 6
EXEC agregarVenta 19
EXEC crearDocumento '4821', '2020-03-02 13:10:06'

EXEC agregarDetalleV 19, 9
EXEC agregarDetalleV 1, 4
EXEC agregarVenta 2
EXEC crearDocumento '4831', '2020-17-04 10:42:43'

EXEC agregarDetalleV 35, 2
EXEC agregarDetalleV 30, 1
EXEC agregarVenta 10
EXEC crearDocumento '4841', '2020-01-07 07:26:17'

EXEC agregarDetalleV 12, 10
EXEC agregarDetalleV 23, 5
EXEC agregarVenta 17
EXEC crearDocumento '4861', '2020-15-09 03:01:51'

EXEC agregarDetalleV 38, 8
EXEC agregarDetalleV 21, 9
EXEC agregarVenta 8
EXEC crearDocumento '4871', '2020-28-11 00:34:30'

EXEC agregarDetalleV 34, 2
EXEC agregarDetalleV 9, 7
EXEC agregarVenta 1
EXEC crearDocumento '4881', '2021-11-02 06:17:03'

EXEC agregarDetalleV 28, 4
EXEC agregarDetalleV 17, 10

EXEC agregarVenta 9
EXEC crearDocumento '4891', '2021-27-04 14:49:39'

EXEC agregarDetalleV 6, 3
EXEC agregarDetalleV 27, 1
EXEC agregarDetalleV 14, 8
EXEC agregarDetalleV 33, 3
EXEC agregarDetalleV 5, 10

EXEC agregarVenta 3
EXEC crearDocumento '4901', '2021-11-07 09:32:20'

EXEC agregarDetalleV 28, 6
EXEC agregarDetalleV 19, 1
EXEC agregarDetalleV 36, 4
EXEC agregarDetalleV 8, 9
EXEC agregarVenta 16
EXEC crearDocumento '4911', '2021-23-09 23:22:47'

EXEC agregarDetalleV 25, 2
EXEC agregarDetalleV 11, 5
EXEC agregarDetalleV 40, 7
EXEC agregarDetalleV 3, 1
EXEC agregarDetalleV 26, 6
EXEC agregarVenta 12
EXEC crearDocumento '4921', '2021-06-12 18:55:14'

EXEC agregarDetalleV 21, 4
EXEC agregarDetalleV 17, 10
EXEC agregarDetalleV 38, 3
EXEC agregarDetalleV 9, 9
EXEC agregarDetalleV 16, 2
EXEC agregarVenta 7
EXEC crearDocumento '4931', '2022-19-02 11:07:51'

EXEC agregarDetalleV 32, 7
EXEC agregarDetalleV 10, 8
EXEC agregarDetalleV 27, 5
EXEC agregarVenta 18
EXEC crearDocumento '4941', '2020-05-05 04:40:39'

EXEC agregarDetalleV 2, 1
EXEC agregarDetalleV 39, 10
EXEC agregarDetalleV 24, 3
EXEC agregarDetalleV 13, 7
EXEC agregarDetalleV 31, 6
EXEC agregarDetalleV 18, 9
EXEC agregarDetalleV 1, 4
EXEC agregarVenta 5
EXEC crearDocumento '4961', '2020-18-07 13:23:28'

EXEC agregarDetalleV 35, 2
EXEC agregarDetalleV 30, 1
EXEC agregarDetalleV 12, 10
EXEC agregarDetalleV 23, 5
EXEC agregarVenta 14
EXEC crearDocumento '4971', '2020-01-10 15:06:01'

EXEC agregarDetalleV 38, 9
EXEC agregarDetalleV 21, 2
EXEC agregarDetalleV 34, 8
EXEC agregarDetalleV 9, 7
EXEC agregarVenta 20
EXEC crearDocumento  '4981', '2021-15-12 14:34:07'



EXEC agregarDetalleV 28, 4
EXEC agregarDetalleV 15, 10
EXEC agregarDetalleV 6, 3
EXEC agregarDetalleV 27, 1
EXEC agregarVenta 11
EXEC crearDocumento '4991', '2021-01-03 11:02:42'
go
*/

--


EXEC agregarDetalleC 1
EXEC agregarDetalleC 2
EXEC agregarDetalleC 3
EXEC agregarDetalleC 4
EXEC agregarDetalleC 5
EXEC agregarDetalleC 6
EXEC agregarDetalleC 7
EXEC agregarCompra 
EXEC crearDocumento '0801', '2020-01-15 08:23:45';

EXEC agregarDetalleC 8
EXEC agregarDetalleC 9
EXEC agregarCompra 
EXEC crearDocumento '0851', '2020-02-01 14:37:21';

EXEC agregarDetalleC 10
EXEC agregarDetalleC 11
EXEC agregarDetalleC 12
EXEC agregarCompra 
EXEC crearDocumento '0951', '2020-01-10 09:45:32';

EXEC agregarDetalleC 13
EXEC agregarDetalleC 14
EXEC agregarDetalleC 15
EXEC agregarDetalleC 16
EXEC agregarDetalleC 17
EXEC agregarDetalleC 18
EXEC agregarDetalleC 19
EXEC agregarDetalleC 20
EXEC agregarDetalleC 21
EXEC agregarCompra 
EXEC crearDocumento '0951', '2020-03-7 12:18:56';

EXEC agregarDetalleC 22
EXEC agregarDetalleC 23
EXEC agregarCompra 
EXEC crearDocumento '0801', '2020-02-13 18:59:24';

select * from ResponsableEmpresa

EXEC agregarDetalleC 24
EXEC agregarDetalleC 25
EXEC agregarDetalleC 26
EXEC agregarDetalleC 27
EXEC agregarDetalleC 28
EXEC agregarDetalleC 29
EXEC agregarDetalleC 30
EXEC agregarDetalleC 31
EXEC agregarDetalleC 32
EXEC agregarDetalleC 33
EXEC agregarDetalleC 34
EXEC agregarDetalleC 35
EXEC agregarCompra 
EXEC crearDocumento '4811', '2020-02-11 03:42:17';

EXEC agregarDetalleC 36
EXEC agregarDetalleC 37
EXEC agregarDetalleC 38
EXEC agregarCompra 
EXEC crearDocumento '0801', '2019-12-05 21:30:09';


EXEC agregarDetalleC 39
EXEC agregarDetalleC 40
EXEC agregarDetalleC 41
EXEC agregarDetalleC 42
EXEC agregarCompra
EXEC crearDocumento '0851', '2020-03-08 10:15:38';

EXEC agregarDetalleC 43
EXEC agregarDetalleC 44
EXEC agregarCompra
EXEC crearDocumento '0851', '2020-01-20 16:27:53';

EXEC agregarDetalleC 45
EXEC agregarDetalleC 46
EXEC agregarCompra 
EXEC crearDocumento '0801', '2020-02-18 07:14:29';

EXEC agregarDetalleV 1, 5
EXEC agregarDetalleV 2, 8
EXEC agregarDetalleV 3, 3
EXEC agregarVenta 5
EXEC crearDocumento '4841', '2020-04-01 23:08:42'

EXEC agregarDetalleV 4, 7
EXEC agregarDetalleV 5, 1
EXEC agregarVenta 14
EXEC crearDocumento '4881', '2020-06-15 05:56:13'

EXEC agregarDetalleV 6, 10
EXEC agregarDetalleV 7, 4
EXEC agregarDetalleV 8, 9
EXEC agregarVenta 9
EXEC crearDocumento '4961', '2020-08-29 14:02:50'

EXEC agregarDetalleV 9, 2
EXEC agregarVenta 18
EXEC crearDocumento '4921', '2020-11-10 19:45:06'

EXEC agregarDetalleV 10, 6
EXEC agregarDetalleV 11, 3
EXEC agregarDetalleV 12, 7
EXEC agregarDetalleV 13, 1
EXEC agregarVenta 7
EXEC crearDocumento '4901', '2021-01-24 02:36:18'

EXEC agregarDetalleV 14, 8
EXEC agregarVenta 20
EXEC crearDocumento '4871', '2021-04-08 11:27:54'

EXEC agregarDetalleV 15, 5
EXEC agregarVenta 12
EXEC crearDocumento '4991', '2021-06-21 08:10:37'

EXEC agregarDetalleV 16, 9
EXEC agregarDetalleV 17, 2
EXEC agregarVenta 3
EXEC crearDocumento '4981', '2021-09-03 17:53:09'

EXEC agregarDetalleV 18, 6
EXEC agregarDetalleV 19, 4
EXEC agregarVenta 16
EXEC crearDocumento '4991', '2021-11-17 06:20:48'

EXEC agregarDetalleV 20, 10
EXEC agregarVenta 11
EXEC crearDocumento '4881', '2022-02-01 22:49:33'

EXEC agregarDetalleV 21, 8
EXEC agregarVenta 2
EXEC crearDocumento '4841', '2022-03-15 13:14:27'

EXEC agregarDetalleV 22, 1
EXEC agregarVenta 10
EXEC crearDocumento '4911', '2021-05-29 04:37:59'

EXEC agregarDetalleV 23, 5
EXEC agregarVenta 17
EXEC crearDocumento '4971', '2021-08-10 16:08:11'

EXEC agregarDetalleV 24, 3
EXEC agregarDetalleV 25, 7
EXEC agregarVenta 8
EXEC crearDocumento '4931', '2021-10-24 09:52:46'

EXEC agregarDetalleV 26, 2
EXEC agregarVenta 13
EXEC crearDocumento '4941', '2022-01-06 01:27:35'

EXEC agregarDetalleV 27, 6
EXEC agregarDetalleV 28, 4
EXEC agregarVenta 6
EXEC crearDocumento '4891', '2022-03-20 18:40:59'

EXEC agregarDetalleV 29, 9
EXEC agregarDetalleV 30, 1
EXEC agregarVenta 15
EXEC crearDocumento '4861', '2020-06-02 20:04:12'

EXEC agregarDetalleV 31, 10
EXEC agregarDetalleV 32, 5
EXEC agregarVenta 4
EXEC crearDocumento '4961', '2020-08-15 23:49:57'

EXEC agregarDetalleV 33, 7
EXEC agregarDetalleV 34, 3
EXEC agregarVenta 19
EXEC crearDocumento '4881', '2021-10-29 08:33:25'

EXEC agregarDetalleV 35, 6
EXEC agregarDetalleV 36, 9
EXEC agregarVenta 1
EXEC crearDocumento '4821', '2021-01-12 14:11:19'

EXEC agregarDetalleV 37, 2
EXEC agregarDetalleV 38, 8
EXEC agregarVenta 9
EXEC crearDocumento '4991', '2022-03-26 03:21:43'

EXEC agregarDetalleV 39, 4
EXEC agregarDetalleV 40, 10
EXEC agregarVenta 3
EXEC crearDocumento '4901', '2020-06-08 06:45:28'

EXEC agregarDetalleV 7, 6
EXEC agregarDetalleV 15, 3
EXEC agregarVenta 16
EXEC crearDocumento '4941', '2022-08-22 17:18:14'

EXEC agregarDetalleV 29, 8
EXEC agregarDetalleV 20, 4
EXEC agregarVenta 12
EXEC crearDocumento '0801', '2022-11-04 19:09:08'

EXEC agregarDetalleV 11, 1
EXEC agregarDetalleV 36, 10
EXEC agregarVenta 7
EXEC crearDocumento '4911', '2021-01-18 10:54:51'

EXEC agregarDetalleV 3, 2
EXEC agregarDetalleV 25, 7
EXEC agregarVenta 18
EXEC crearDocumento '4931', '2021-04-02 12:37:24'

EXEC agregarDetalleV 14, 5
EXEC agregarDetalleV 40, 9
EXEC agregarVenta 5
EXEC crearDocumento '4881', '2020-06-16 21:06:32'

EXEC agregarDetalleV 5, 1
EXEC agregarDetalleV 33, 6
EXEC agregarVenta 14
EXEC crearDocumento '4861', '2020-08-30 15:29:46'

EXEC agregarDetalleV 22, 4
EXEC agregarVenta 20
EXEC crearDocumento '0851', '2021-11-11 08:02:57'

EXEC agregarDetalleV 18, 10
EXEC agregarDetalleV 37, 3
EXEC agregarVenta 11
EXEC crearDocumento '4811', '2021-01-25 02:13:35'

EXEC agregarDetalleV 8, 9
EXEC agregarDetalleV 16, 2
EXEC agregarVenta 13
EXEC crearDocumento '4971', '2021-04-09 05:48:13'

EXEC agregarDetalleV 31, 7
EXEC agregarDetalleV 10, 8
EXEC agregarVenta 6
EXEC crearDocumento '4821', '2021-06-23 16:41:26'

EXEC agregarDetalleV 26, 5
EXEC agregarDetalleV 2, 1
EXEC agregarVenta 15
EXEC crearDocumento '4981', '2021-09-06 22:24:04'

EXEC agregarDetalleV 39, 10
EXEC agregarDetalleV 24, 3
EXEC agregarVenta 4
EXEC crearDocumento '4821', '2021-11-20 19:57:18'

EXEC agregarDetalleV 13, 7
EXEC agregarDetalleV 32, 6
EXEC agregarVenta 19
EXEC crearDocumento '4821', '2020-02-03 13:10:06'

EXEC agregarDetalleV 19, 9
EXEC agregarDetalleV 1, 4
EXEC agregarVenta 2
EXEC crearDocumento '4831', '2020-04-17 10:42:43'

EXEC agregarDetalleV 35, 2
EXEC agregarDetalleV 30, 1
EXEC agregarVenta 10
EXEC crearDocumento '4841', '2020-07-01 07:26:17'

EXEC agregarDetalleV 12, 10
EXEC agregarDetalleV 23, 5
EXEC agregarVenta 17
EXEC crearDocumento '4861', '2020-09-15 03:01:51'

EXEC agregarDetalleV 38, 8
EXEC agregarDetalleV 21, 9
EXEC agregarVenta 8
EXEC crearDocumento '4871', '2020-11-28 00:34:30'

EXEC agregarDetalleV 34, 2
EXEC agregarDetalleV 9, 7
EXEC agregarVenta 1
EXEC crearDocumento '4881', '2021-02-11 06:17:03'

EXEC agregarDetalleV 28, 4
EXEC agregarDetalleV 17, 10

EXEC agregarVenta 9
EXEC crearDocumento '4891', '2021-04-27 14:49:39'

EXEC agregarDetalleV 6, 3
EXEC agregarDetalleV 27, 1
EXEC agregarDetalleV 14, 8
EXEC agregarDetalleV 33, 3
EXEC agregarDetalleV 5, 10

EXEC agregarVenta 3
EXEC crearDocumento '4901', '2021-07-10 09:32:20'

EXEC agregarDetalleV 28, 6
EXEC agregarDetalleV 19, 1
EXEC agregarDetalleV 36, 4
EXEC agregarDetalleV 8, 9
EXEC agregarVenta 16
EXEC crearDocumento '4911', '2021-09-23 23:22:47'

EXEC agregarDetalleV 25, 2
EXEC agregarDetalleV 11, 5
EXEC agregarDetalleV 40, 7
EXEC agregarDetalleV 3, 1
EXEC agregarDetalleV 26, 6
EXEC agregarVenta 12
EXEC crearDocumento '4921', '2021-12-06 18:55:14'

EXEC agregarDetalleV 21, 4
EXEC agregarDetalleV 17, 10
EXEC agregarDetalleV 38, 3
EXEC agregarDetalleV 9, 9
EXEC agregarDetalleV 16, 2
EXEC agregarVenta 7
EXEC crearDocumento '4931', '2022-02-19 11:07:51'

EXEC agregarDetalleV 32, 7
EXEC agregarDetalleV 10, 8
EXEC agregarDetalleV 27, 5
EXEC agregarVenta 18
EXEC crearDocumento '4941', '2020-05-05 04:40:39'

EXEC agregarDetalleV 2, 1
EXEC agregarDetalleV 39, 10
EXEC agregarDetalleV 24, 3
EXEC agregarDetalleV 13, 7
EXEC agregarDetalleV 31, 6
EXEC agregarDetalleV 18, 9
EXEC agregarDetalleV 1, 4
EXEC agregarVenta 5
EXEC crearDocumento '4961', '2020-07-18 13:23:28'

EXEC agregarDetalleV 35, 2
EXEC agregarDetalleV 30, 1
EXEC agregarDetalleV 12, 10
EXEC agregarDetalleV 23, 5
EXEC agregarVenta 14
EXEC crearDocumento '4971', '2020-10-01 15:06:01'

EXEC agregarDetalleV 38, 9
EXEC agregarDetalleV 21, 2
EXEC agregarDetalleV 34, 8
EXEC agregarDetalleV 9, 7
EXEC agregarVenta 20
EXEC crearDocumento  '4981', '2021-12-15 14:34:07'



EXEC agregarDetalleV 28, 4
EXEC agregarDetalleV 15, 10
EXEC agregarDetalleV 6, 3
EXEC agregarDetalleV 27, 1
EXEC agregarVenta 11
EXEC crearDocumento '4991', '2021-03-01 11:02:42'
go

/*
EXEC agregarDetalleC 1
EXEC agregarDetalleC 2
EXEC agregarDetalleC 3
EXEC agregarDetalleC 4
EXEC agregarDetalleC 5
EXEC agregarDetalleC 6
EXEC agregarDetalleC 7
EXEC agregarCompra 
EXEC crearDocumento '0801', '15-01-2020 08:23:45';

EXEC agregarDetalleC 8
EXEC agregarDetalleC 9
EXEC agregarCompra 
EXEC crearDocumento '0851', '01-02-2020 14:37:21';

EXEC agregarDetalleC 10
EXEC agregarDetalleC 11
EXEC agregarDetalleC 12
EXEC agregarCompra 
EXEC crearDocumento '0951', '10-01-2020 09:45:32';

EXEC agregarDetalleC 13
EXEC agregarDetalleC 14
EXEC agregarDetalleC 15
EXEC agregarDetalleC 16
EXEC agregarDetalleC 17
EXEC agregarDetalleC 18
EXEC agregarDetalleC 19
EXEC agregarDetalleC 20
EXEC agregarDetalleC 21
EXEC agregarCompra 
EXEC crearDocumento '0951', '07-03-2020 12:18:56';

EXEC agregarDetalleC 22
EXEC agregarDetalleC 23
EXEC agregarCompra 
EXEC crearDocumento '0801', '13-02-2020 18:59:24';

select * from ResponsableEmpresa

EXEC agregarDetalleC 24
EXEC agregarDetalleC 25
EXEC agregarDetalleC 26
EXEC agregarDetalleC 27
EXEC agregarDetalleC 28
EXEC agregarDetalleC 29
EXEC agregarDetalleC 30
EXEC agregarDetalleC 31
EXEC agregarDetalleC 32
EXEC agregarDetalleC 33
EXEC agregarDetalleC 34
EXEC agregarDetalleC 35
EXEC agregarCompra 
EXEC crearDocumento '4811', '11-02-2020 03:42:17';

EXEC agregarDetalleC 36
EXEC agregarDetalleC 37
EXEC agregarDetalleC 38
EXEC agregarCompra 
EXEC crearDocumento '0801', '05-12-2019 21:30:09';


EXEC agregarDetalleC 39
EXEC agregarDetalleC 40
EXEC agregarDetalleC 41
EXEC agregarDetalleC 42
EXEC agregarCompra
EXEC crearDocumento '0851', '08-03-2020 10:15:38';

EXEC agregarDetalleC 43
EXEC agregarDetalleC 44
EXEC agregarCompra
EXEC crearDocumento '0851', '20-01-2020 16:27:53';

EXEC agregarDetalleC 45
EXEC agregarDetalleC 46
EXEC agregarCompra 
EXEC crearDocumento '0801', '18-02-2020 07:14:29';

EXEC agregarDetalleV 1, 5
EXEC agregarDetalleV 2, 8
EXEC agregarDetalleV 3, 3
EXEC agregarVenta 5
EXEC crearDocumento '4841', '01-04-2020 23:08:42'

EXEC agregarDetalleV 4, 7
EXEC agregarDetalleV 5, 1
EXEC agregarVenta 14
EXEC crearDocumento '4881', '15-06-2020 05:56:13'

EXEC agregarDetalleV 6, 10
EXEC agregarDetalleV 7, 4
EXEC agregarDetalleV 8, 9
EXEC agregarVenta 9
EXEC crearDocumento '4961', '29-08-2020 14:02:50'

EXEC agregarDetalleV 9, 2
EXEC agregarVenta 18
EXEC crearDocumento '4921', '10-11-2020 19:45:06'

EXEC agregarDetalleV 10, 6
EXEC agregarDetalleV 11, 3
EXEC agregarDetalleV 12, 7
EXEC agregarDetalleV 13, 1
EXEC agregarVenta 7
EXEC crearDocumento '4901', '24-01-2021 02:36:18'

EXEC agregarDetalleV 14, 8
EXEC agregarVenta 20
EXEC crearDocumento '4871', '08-04-2021 11:27:54'

EXEC agregarDetalleV 15, 5
EXEC agregarVenta 12
EXEC crearDocumento '4991', '21-06-2021 08:10:37'

EXEC agregarDetalleV 16, 9
EXEC agregarDetalleV 17, 2
EXEC agregarVenta 3
EXEC crearDocumento '4981', '03-09-2021 17:53:09'

EXEC agregarDetalleV 18, 6
EXEC agregarDetalleV 19, 4
EXEC agregarVenta 16
EXEC crearDocumento '4991', '17-11-2021 06:20:48'

EXEC agregarDetalleV 20, 10
EXEC agregarVenta 11
EXEC crearDocumento '4881', '01-02-2022 22:49:33'

EXEC agregarDetalleV 21, 8
EXEC agregarVenta 2
EXEC crearDocumento '4841', '15-03-2022 13:14:27'

EXEC agregarDetalleV 22, 1
EXEC agregarVenta 10
EXEC crearDocumento '4911', '29-05-2021 04:37:59'

EXEC agregarDetalleV 23, 5
EXEC agregarVenta 17
EXEC crearDocumento '4971', '10-08-2021 16:08:11'

EXEC agregarDetalleV 24, 3
EXEC agregarDetalleV 25, 7
EXEC agregarVenta 8
EXEC crearDocumento '4931', '24-10-2021 09:52:46'

EXEC agregarDetalleV 26, 2
EXEC agregarVenta 13
EXEC crearDocumento '4941', '06-01-2022 01:27:35'

EXEC agregarDetalleV 27, 6
EXEC agregarDetalleV 28, 4
EXEC agregarVenta 6
EXEC crearDocumento '4891', '20-03-2022 18:40:59'

EXEC agregarDetalleV 29, 9
EXEC agregarDetalleV 30, 1
EXEC agregarVenta 15
EXEC crearDocumento '4861', '02-06-2020 20:04:12'

EXEC agregarDetalleV 31, 10
EXEC agregarDetalleV 32, 5
EXEC agregarVenta 4
EXEC crearDocumento '4961', '15-08-2020 23:49:57'

EXEC agregarDetalleV 33, 7
EXEC agregarDetalleV 34, 3
EXEC agregarVenta 19
EXEC crearDocumento '4881', '29-10-2021 08:33:25'

EXEC agregarDetalleV 35, 6
EXEC agregarDetalleV 36, 9
EXEC agregarVenta 1
EXEC crearDocumento '4821', '12-01-2021 14:11:19'

EXEC agregarDetalleV 37, 2
EXEC agregarDetalleV 38, 8
EXEC agregarVenta 9
EXEC crearDocumento '4991', '26-03-2022 03:21:43'

EXEC agregarDetalleV 39, 4
EXEC agregarDetalleV 40, 10
EXEC agregarVenta 3
EXEC crearDocumento '4901', '08-06-2020 06:45:28'

EXEC agregarDetalleV 7, 6
EXEC agregarDetalleV 15, 3
EXEC agregarVenta 16
EXEC crearDocumento '4941', '22-08-2022 17:18:14'

EXEC agregarDetalleV 29, 8
EXEC agregarDetalleV 20, 4
EXEC agregarVenta 12
EXEC crearDocumento '0801', '04-11-2022 19:09:08'

EXEC agregarDetalleV 11, 1
EXEC agregarDetalleV 36, 10
EXEC agregarVenta 7
EXEC crearDocumento '4911', '18-01-2021 10:54:51'

EXEC agregarDetalleV 3, 2
EXEC agregarDetalleV 25, 7
EXEC agregarVenta 18
EXEC crearDocumento '4931', '02-04-2021 12:37:24'

EXEC agregarDetalleV 14, 5
EXEC agregarDetalleV 40, 9
EXEC agregarVenta 5
EXEC crearDocumento '4881', '16-06-2020 21:06:32'

EXEC agregarDetalleV 5, 1
EXEC agregarDetalleV 33, 6
EXEC agregarVenta 14
EXEC crearDocumento '4861', '30-08-2020 15:29:46'

EXEC agregarDetalleV 22, 4
EXEC agregarVenta 20
EXEC crearDocumento '0851', '11-11-2021 08:02:57'

EXEC agregarDetalleV 18, 10
EXEC agregarDetalleV 37, 3
EXEC agregarVenta 11
EXEC crearDocumento '4811', '25-01-2021 02:13:35'

EXEC agregarDetalleV 8, 9
EXEC agregarDetalleV 16, 2
EXEC agregarVenta 13
EXEC crearDocumento '4971', '09-04-2021 05:48:13'

EXEC agregarDetalleV 31, 7
EXEC agregarDetalleV 10, 8
EXEC agregarVenta 6
EXEC crearDocumento '4821', '23-06-2021 16:41:26'

EXEC agregarDetalleV 26, 5
EXEC agregarDetalleV 2, 1
EXEC agregarVenta 15
EXEC crearDocumento '4981', '06-09-2021 22:24:04'

EXEC agregarDetalleV 39, 10
EXEC agregarDetalleV 24, 3
EXEC agregarVenta 4
EXEC crearDocumento '4821', '20-11-2021 19:57:18'

EXEC agregarDetalleV 13, 7
EXEC agregarDetalleV 32, 6
EXEC agregarVenta 19
EXEC crearDocumento '4821', '03-02-2020 13:10:06'

EXEC agregarDetalleV 19, 9
EXEC agregarDetalleV 1, 4
EXEC agregarVenta 2
EXEC crearDocumento '4831', '17-04-2020 10:42:43'

EXEC agregarDetalleV 35, 2
EXEC agregarDetalleV 30, 1
EXEC agregarVenta 10
EXEC crearDocumento '4841', '01-07-2020 07:26:17'

EXEC agregarDetalleV 12, 10
EXEC agregarDetalleV 23, 5
EXEC agregarVenta 17
EXEC crearDocumento '4861', '15-09-2020 03:01:51'

EXEC agregarDetalleV 38, 8
EXEC agregarDetalleV 21, 9
EXEC agregarVenta 8
EXEC crearDocumento '4871', '28-11-2020 00:34:30'

EXEC agregarDetalleV 34, 2
EXEC agregarDetalleV 9, 7
EXEC agregarVenta 1
EXEC crearDocumento '4881', '11-02-2021 06:17:03'

EXEC agregarDetalleV 28, 4
EXEC agregarDetalleV 17, 10

EXEC agregarVenta 9
EXEC crearDocumento '4891', '27-04-2021 14:49:39'

EXEC agregarDetalleV 6, 3
EXEC agregarDetalleV 27, 1
EXEC agregarDetalleV 14, 8
EXEC agregarDetalleV 33, 3
EXEC agregarDetalleV 5, 10

EXEC agregarVenta 3
EXEC crearDocumento '4901', '10-07-2021 09:32:20'

EXEC agregarDetalleV 28, 6
EXEC agregarDetalleV 19, 1
EXEC agregarDetalleV 36, 4
EXEC agregarDetalleV 8, 9
EXEC agregarVenta 16
EXEC crearDocumento '4911', '23-09-2021 23:22:47'

EXEC agregarDetalleV 25, 2
EXEC agregarDetalleV 11, 5
EXEC agregarDetalleV 40, 7
EXEC agregarDetalleV 3, 1
EXEC agregarDetalleV 26, 6
EXEC agregarVenta 12
EXEC crearDocumento '4921', '06-12-2021 18:55:14'

EXEC agregarDetalleV 21, 4
EXEC agregarDetalleV 17, 10
EXEC agregarDetalleV 38, 3
EXEC agregarDetalleV 9, 9
EXEC agregarDetalleV 16, 2
EXEC agregarVenta 7
EXEC crearDocumento '4931', '19-02-2022 11:07:51'

EXEC agregarDetalleV 32, 7
EXEC agregarDetalleV 10, 8
EXEC agregarDetalleV 27, 5
EXEC agregarVenta 18
EXEC crearDocumento '4941', '05-05-2020 04:40:39'

EXEC agregarDetalleV 2, 1
EXEC agregarDetalleV 39, 10
EXEC agregarDetalleV 24, 3
EXEC agregarDetalleV 13, 7
EXEC agregarDetalleV 31, 6
EXEC agregarDetalleV 18, 9
EXEC agregarDetalleV 1, 4
EXEC agregarVenta 5
EXEC crearDocumento '4961', '18-07-2020 13:23:28'

EXEC agregarDetalleV 35, 2
EXEC agregarDetalleV 30, 1
EXEC agregarDetalleV 12, 10
EXEC agregarDetalleV 23, 5
EXEC agregarVenta 14
EXEC crearDocumento '4971', '01-10-2020 15:06:01'

EXEC agregarDetalleV 38, 9
EXEC agregarDetalleV 21, 2
EXEC agregarDetalleV 34, 8
EXEC agregarDetalleV 9, 7
EXEC agregarVenta 20
EXEC crearDocumento  '4981', '15-12-2021 14:34:07'



EXEC agregarDetalleV 28, 4
EXEC agregarDetalleV 15, 10
EXEC agregarDetalleV 6, 3
EXEC agregarDetalleV 27, 1
EXEC agregarVenta 11
EXEC crearDocumento '4991', '01-03-2021 11:02:42'
go
*/

UPDATE V
	SET Fecha = d.FechaDocumento
	from Venta V
	inner join Documento D on D.NumeroDocumento=V.NumeroDocumento
	where D.PrecioDocumento>0
GO	
UPDATE C
	SET Fecha = D.FechaDocumento
	from Compra C
	inner join Documento D on D.NumeroDocumento=C.NumeroDocumento
	where D.PrecioDocumento<0
GO	


alter PROCEDURE crearDocumento
	@IdResp		varchar(10)
AS
BEGIN
	declare @IdPrincipal	int,
			@PrecioDoc		money
	
	IF exists(select 1 from Venta where NumeroDocumento is null and IdVenta!=0)
	begin
		select @PrecioDoc=MontoVenta from Venta where NumeroDocumento is null and IdVenta!=0
		insert into Documento(FechaDocumento,PrecioDocumento,TipoDoc,IdResp) values (GETDATE(),@PrecioDoc,null,@IdResp)


	end
	ELSE IF exists(select 1 from Compra where NumeroDocumento is null AND IdCompra!=0)
	begin
		select  @PrecioDoc=MontoCompra from Compra where NumeroDocumento is null AND IdCompra!=0
		insert into Documento(FechaDocumento,PrecioDocumento,TipoDoc,IdResp) values (GETDATE(),-@PrecioDoc,null,@IdResp)

	end

	
END
GO


alter PROCEDURE agregarCompra
AS
BEGIN
	declare @Monto money,
			@IdProveedor int
	select top 1 @IdProveedor = PP.IdProveedor
	from DetalleCompra DC
	inner join Producto_Proveedor PP on DC.IdProducto = PP.IdProducto
	where DC.IdCompra=0

	select @Monto = SUM(CantidadComprada*PrecioUnitario) from DetalleCompra where IdCompra =0
	insert into Compra(IdProveedor,NumeroDocumento,MontoCompra,Fecha) values (@IdProveedor,null,@Monto,GETDATE())
END
GO

alter PROCEDURE agregarVenta
	@IdCliente	int
AS
BEGIN
	declare @Monto money
	select @Monto = SUM(CantidadVendida*PrecioUnitario) from DetalleVenta where IdVenta =0
	insert into Venta(IdCliente,NumeroDocumento,MontoVenta,Fecha) values (@IdCliente,null,@Monto,GETDATE())
END
GO

create procedure consultarKardex
	@IdProducto int
as
begin
	select	CONCAT(MK.IdKardex,MK.IdMovimiento,MK.IdKMov) as IdMovimiento,
			P.DescripciónProducto as Producto,
			D.NumeroDocumento as [N° Doc],
			D.FechaDocumento as Fecha,
			RE.IdResp AS [Responsable de la Empresa],
			MK.IdProveedor as Proveedor,
			d.PrecioDocumento as [Precio en Documento],
			mk.StockAnterior as [Stock Anterior],
			mk.TipoMovimiento as [Tipo Movimiento],
			MK.Cantidad as Cantidad,
			MK.StockActual as [Stock Actual]

	from Producto P
	INNER JOIN Kardex K ON P.IdProducto=K.IdProducto
	INNER JOIN MovimientoKardex MK ON K.IdKardex = MK.IdKardex
	inner join Documento D ON MK.NumeroDocumento = D.NumeroDocumento
	INNER JOIN ResponsableEmpresa RE ON D.IdResp=RE.IdResp
	where P.IdProducto = @IdProducto
end
go

create VIEW topVentas AS
select TOP 5
    RE.IdResp AS IdResponsable,
    E.NombreEmp AS Empleado,
    SUM(V.MontoVenta) AS MontoTotalVentas
FROM Empleado E
INNER JOIN ResponsableEmpresa RE ON E.IdEmpleado = RE.IdEmpleado
INNER JOIN Documento D ON RE.IdResp = D.IdResp
INNER JOIN Venta V ON D.NumeroDocumento = V.NumeroDocumento
where YEAR(D.FechaDocumento)=2022
GROUP BY RE.IdResp, E.NombreEmp
ORDER BY MontoTotalVentas DESC
go



create VIEW stockMinimo AS
select 
	P.IdProducto AS Id,
	P.DescripciónProducto AS Descripción,
	P.StockMin AS [Stock Mínimo],
	P.StockActual AS [Stock Actual],
	C.DescripcionCategoria AS Categoría,
	Pr.NombreProveedor AS Proveedor,
	Pr.TelefonoProveedor AS Teléfono,
	Pr.CorreoProveedor as Correo
from Producto P
INNER JOIN Categoria C ON P.IdCategoria = C.IdCategoria
INNER JOIN Producto_Proveedor PV ON PV.IdProducto = P.IdProducto
INNER JOIN Proveedor Pr ON PV.IdProveedor = pr.IdProveedor
where P.StockActual<=p.StockMin
go


CREATE VIEW masVendidos as
	SELECT TOP 10
	P.IdProducto AS Id,
	P.DescripciónProducto AS Descripción,
	SUM(DV.CantidadVendida) as [Cantidad Vendida],
	SUM(DV.PrecioUnitario) as [Precio de Venta]

	FROM Producto P
	INNER JOIN DetalleVenta DV ON P.IdProducto=DV.IdProducto
	INNER JOIN  Venta V ON V.IdVenta=DV.IdVenta
	INNER JOIN Documento D ON D.NumeroDocumento=V.NumeroDocumento
	where DV.IdVenta!=0 and YEAR(D.FechaDocumento)='2021'
	group by p.IdProducto,p.DescripciónProducto
	order by SUM(DV.CantidadVendida) DESC
		
go

create view verKardex as
	select	K.IdKardex AS [Kardex ID],
			P.DescripciónProducto as Producto,
			C.DescripcionCategoria as Categoría,
			P.PrecioBase as [Precio Base],
			P.StockMin as [Stock Mínimo],
			K.FechaApertura as [Fecha de Apertura],
			P.UnidadMedida as [Unidad de Medida],
			P.CantidadReposicion as [Cantidad de reposición]
	from Kardex K
	INNER JOIN Producto P ON K.IdProducto=P.IdProducto
	INNER JOIN Categoria C ON P.IdCategoria = C.IdCategoria
go 

select * from Documento
go

alter PROCEDURE agregarCompra
AS
BEGIN
	declare @Monto money,
			@IdProveedor int
	select top 1 @IdProveedor = PP.IdProveedor
	from DetalleCompra DC
	inner join Producto_Proveedor PP on DC.IdProducto = PP.IdProducto
	where DC.IdCompra=0

	select @Monto = SUM(CantidadComprada*PrecioUnitario) from DetalleCompra where IdCompra =0
	insert into Compra(IdProveedor,NumeroDocumento,MontoCompra,Fecha) values (@IdProveedor,null,@Monto,GETDATE())
END
GO

alter PROCEDURE agregarVenta
	@IdCliente	int
AS
BEGIN
	declare @Monto money
	select @Monto = SUM(CantidadVendida*PrecioUnitario) from DetalleVenta where IdVenta =0
	insert into Venta(IdCliente,NumeroDocumento,MontoVenta,Fecha) values (@IdCliente,null,@Monto,GETDATE())
END
GO
/*
select * from Empleado

select * from ResponsableEmpresa
exec agregarEmpleado 'Yang Serrano','18487171','2001-02-14','943871658','yang@yahoo.com' 
exec agregarEmpleado 'Franklin Aguilar','43300131','2001-01-22','91357625','viru123@hotmail.com'
select * from ResponsableEmpresa


select * from Producto
exec agregarProducto 'Lavavajillas Limón', 40,'Unidades',70,'1'
exec proveedorProducto 1,47,6.50
select * from Producto order by IdCategoria

select * from Producto_Proveedor

exec agregarDetalleC 47
select * from DetalleCompra
exec agregarCompra 1
select * from Compra
exec crearDocumento '3011'


exec agregarDetalleV 47,1
exec agregarDetalleV 2,3
select * from DetalleVenta
exec agregarVenta 19
select * from Venta
exec crearDocumento '3012'
*/

select * from DetalleVenta