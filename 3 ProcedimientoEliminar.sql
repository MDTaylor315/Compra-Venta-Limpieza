use LimpiezaVenta
go

create procedure eliminarDetalleVenta
	@IdDetalleVenta int
AS
BEGIN
	declare @IdVenta int,
			@Cantidad int,
			@IdProducto int,
			@Precio money,
			@NumeroDocumento int
			
	select @IdVenta=IdVenta, @Cantidad=CantidadVendida, @IdProducto=IdProducto, @Precio=PrecioUnitario from DetalleVenta where IdDetalleVenta=@IdDetalleVenta

	select @NumeroDocumento=NumeroDocumento from Venta where IdVenta=@IdVenta

	if @IdVenta!=0
	begin
			UPDATE Producto
				set StockActual = StockActual + @Cantidad
			from Producto P where IdProducto=@IdProducto

			if (select COUNT(*) from DetalleVenta where IdVenta=@IdVenta)=1 
			begin
				declare @IdCliente int,
						@MontoVenta money,
						@Fecha datetime

				select @IdCliente=IdCliente, @MontoVenta=MontoVenta,@Fecha=Fecha from Venta where IdVenta=@IdVenta
				insert into VentaDeleted(IdVenta,IdCliente,NumeroDocumento,MontoVenta,Fecha) values (@IdVenta,@IdCliente,@NumeroDocumento,@MontoVenta,@Fecha)
			
				UPDATE Documento
					set Estado = 'Anulado'
				from Documento where NumeroDocumento = @NumeroDocumento

				delete from MovimientoKardex where NumeroDocumento=@NumeroDocumento
				
			end
			else
			begin
				UPDATE Venta
					set MontoVenta = MontoVenta - @Cantidad*@Precio
				from Venta where IdVenta = @IdVenta

				UPDATE Documento
					set Estado = 'Modificado'
				from Documento where NumeroDocumento = @NumeroDocumento
				UPDATE Documento
					set PrecioDocumento = @Precio
				from Documento where NumeroDocumento = @NumeroDocumento

				delete from MovimientoKardex where NumeroDocumento=@NumeroDocumento and IdKardex = @IdProducto
			end

			INSERT INTO dVentaDeleted(CantidadVendida,PrecioUnitario,IdVenta,IdProducto, IdDetalleVenta) values (@Cantidad,@Precio,@IdVenta,@IdProducto,@IdDetalleVenta)
	
	
			if (select COUNT(*) from DetalleVenta where IdVenta=@IdVenta)=1 
			begin
					delete from DetalleVenta where @IdDetalleVenta=IdDetalleVenta
					delete from Venta where IdVenta=@IdVenta
			end
			else
			begin
					delete from DetalleVenta where @IdDetalleVenta=IdDetalleVenta
			end
	end
END
GO


create procedure eliminarVenta
	@IdVenta int
as
begin
	declare @IdCliente int,
			@NumeroDocumento int,
			@MontoVenta money,
			@Fecha datetime
			
	select @IdCliente=IdCliente,@NumeroDocumento=NumeroDocumento,@MontoVenta=MontoVenta,@Fecha=Fecha from Venta where @IdVenta = IdVenta

	insert into dVentaDeleted (IdProducto,CantidadVendida,PrecioUnitario,IdDetalleVenta,IdVenta)
	select IdProducto,CantidadVendida,PrecioUnitario,IdDetalleVenta,IdVenta from DetalleVenta where IdVenta=@IdVenta

	insert into VentaDeleted (IdVenta,IdCliente,NumeroDocumento,MontoVenta,Fecha) values (@IdVenta,@IdCliente,@NumeroDocumento,@MontoVenta,@Fecha)


	UPDATE Producto
			set StockActual = StockActual + DV.CantidadVendida
		from Producto P
		inner join DetalleVenta DV on P.IdProducto = DV.IdProducto
		where DV.IdVenta = @IdVenta


	delete from DetalleVenta where IdVenta=@IdVenta
	delete from Venta where IdVenta=@IdVenta 

	

	UPDATE Documento
		set Estado = 'Anulado'
	from Documento where NumeroDocumento = @NumeroDocumento

	
	delete from MovimientoKardex where NumeroDocumento=@NumeroDocumento
end
go



create procedure eliminarDetalleCompra
	@IdDetalleCompra int
AS
BEGIN
	declare @IdCompra int,
			@Cantidad int,
			@IdProducto int,
			@Precio money,
			@NumeroDocumento int,
			@stockActual int
			
	select @IdCompra=IdCompra, @Cantidad=CantidadComprada, @IdProducto=IdProducto, @Precio=PrecioUnitario from DetalleCompra where IdDetalleCompra=@IdDetalleCompra
	select @stockActual=StockActual from Producto where IdProducto = @IdProducto

	if @IdCompra!=0
	begin

		if @stockActual>= @Cantidad
		begin
			select @NumeroDocumento=NumeroDocumento from Compra where IdCompra=@IdCompra

						UPDATE Producto
							set StockActual = StockActual - @Cantidad
						from Producto P where IdProducto=@IdProducto

						if (select COUNT(*) from DetalleCompra where IdCompra=@IdCompra)=1 
						begin
							declare @IdProveedor int,
									@MontoCompra money,
									@Fecha datetime

							select @IdProveedor=IdProveedor, @MontoCompra=MontoCompra,@Fecha=Fecha from Compra where IdCompra=@IdCompra
							insert into CompraDeleted(IdCompra,NumeroDocumento,MontoCompra,Fecha,IdProveedor) values (@IdCompra,@NumeroDocumento,@MontoCompra,@Fecha,@IdProducto)
							UPDATE Documento
								set Estado = 'Anulado'
							from Documento where NumeroDocumento = @NumeroDocumento
						end
						else
						begin
							UPDATE Compra
								set MontoCompra = MontoCompra - @Cantidad*@Precio
							from Compra where IdCompra = @IdCompra

							UPDATE Documento
								set Estado = 'Modificado'
							from Documento where NumeroDocumento = @NumeroDocumento
						end

						INSERT INTO dCompraDeleted(CantidadComprada,PrecioUnitario,IdCompra,IdProducto, IdDetalleCompra) values (@Cantidad,@Precio,@IdCompra,@IdProducto,@IdDetalleCompra)
			
						if (select COUNT(*) from DetalleCompra where IdCompra=@IdCompra)=1 
						begin
								delete from DetalleCompra where @IdDetalleCompra=IdDetalleCompra
								delete from Compra where IdCompra=@IdCompra
						end
						else
						begin
								delete from DetalleCompra where @IdDetalleCompra=IdDetalleCompra
						end
		end
			
	end
END
GO


create procedure eliminarCompra
	@IdCompra int
as
begin
	declare @IdProveedor int,
			@NumeroDocumento int,
			@MontoCompra money,
			@Fecha datetime
			
	select @IdProveedor=@IdProveedor,@NumeroDocumento=NumeroDocumento,@MontoCompra=MontoCompra,@Fecha=Fecha from Compra where @IdCompra = IdCompra

	insert into dCompraDeleted (IdProducto,CantidadComprada,PrecioUnitario,IdDetalleCompra,IdCompra)
	select IdProducto,CantidadComprada,PrecioUnitario,IdDetalleCompra,IdCompra from DetalleCompra where IdCompra=@IdCompra

	insert into CompraDeleted (IdCompra,IdProveedor,NumeroDocumento,MontoCompra,Fecha) values (@IdCompra,@IdProveedor,@NumeroDocumento,@MontoCompra,@Fecha)

		UPDATE Producto
			set StockActual = StockActual + DC.CantidadComprada
		from Producto P
		inner join DetalleCompra DC on P.IdProducto = DC.IdProducto
		where DC.IdCompra = @IdCompra

	delete from DetalleCompra where IdCompra=@IdCompra
	delete from Compra where IdCompra=@IdCompra

	UPDATE Documento
					set Estado = 'Anulado'
					
				from Documento where NumeroDocumento = @NumeroDocumento
end
go

-- los prodcutos que tienen inventario por debajo del stock minimo

create procedure  ProductosxProveedorTodos
		@IdProveedor int
as
begin
	select p.IdProducto,p.DescripciónProducto  ,pp.PrecioCompra ,p.UnidadMedida
		from Producto P
		inner join Producto_Proveedor PP on PP.IdProducto=P.IdProducto
	where   PP.IdProveedor=@IdProveedor
end
go


create procedure  ProductosxDebajoStockMinimo
		@IdProveedor int
as
begin
	select p.IdProducto,p.DescripciónProducto  ,pp.PrecioCompra,p.UnidadMedida
		from Producto P
		inner join Producto_Proveedor PP on PP.IdProducto=P.IdProducto
	where StockActual<=StockMin and PP.IdProveedor=@IdProveedor
end
go
create procedure ActualizarCompra
	@IdCompra  int,
	@IdProveedor int
	as
	begin
		UPDATE Compra 
			SET IdProveedor = @IdProveedor
			WHERE IdCompra = @IdCompra
	end
go

create procedure actualizarDocumento
	 @idCompra int,
	 @idResp char(10)
	 as
	 begin
				
			update d set d.IdResp=@idResp
				FROM Documento d
				INNER JOIN Compra c ON d.NumeroDocumento = c.NumeroDocumento
				WHERE c.IdCompra = @idCompra
	 end
go



create procedure actualizarDetalleCompra
	@IdDetalleCompra int,	
	@IdCompra int,
	@CantidadComprada int,
	@IdProducto int,
	@PrecioUnitario money
	as
	begin
			update DetalleCompra 
				set CantidadComprada=@CantidadComprada,
					PrecioUnitario=@PrecioUnitario,
					IdProducto=@IdProducto
					where IdCompra=@IdCompra and IdDetalleCompra=@IdDetalleCompra
				
			 UPDATE Compra	 
				  SET MontoCompra = (SELECT SUM(CantidadComprada * PrecioUnitario) FROM DetalleCompra WHERE IdCompra = @IdCompra)
				  WHERE  IdCompra = @IdCompra

			UPDATE Documento
				SET PrecioDocumento = c.MontoCompra
				FROM Documento d
				INNER JOIN Compra c ON d.NumeroDocumento = c.NumeroDocumento
				WHERE c.IdCompra = @IdCompra

		

	end
go



create PROCEDURE agregarDetalleC2
	@IdProducto int,
	@CantidadComprada int
	as
BEGIN
	declare @PrecioU money
	select @PrecioU=PrecioCompra from Producto_Proveedor where IdProducto=@IdProducto

	INSERT INTO DetalleCompra(CantidadComprada,PrecioUnitario,IdCompra,IdProducto) values (@CantidadComprada,@PrecioU,0,@IdProducto)

END
go

create PROCEDURE agregarCompra2
		@IdProveedor int
AS
BEGIN
	declare @Monto money
	select @Monto = SUM(CantidadComprada*PrecioUnitario) from DetalleCompra where IdCompra =0
	insert into Compra(IdProveedor,NumeroDocumento,MontoCompra,Fecha) values (@IdProveedor,null,@Monto,GETDATE())
END
go

alter TRIGGER T_DetalleCompras on DetalleCompra for insert
as
begin
	begin transaction
	declare @StockActual int,
			@StockMinimo int,
			@IdProducto int
	
	select @IdProducto=IdProducto from inserted
	select @StockActual=StockActual,@StockMinimo=StockMin from Producto where @IdProducto=IdProducto

	/*if @StockActual>@StockMinimo
		'begin
		'	rollback transaction
			raiserror('Aún se cuenta con suficiente stock',16,2)
		end
	else	
		begin*/
			commit transaction
		--end
end
go

create procedure  ProveedorxProductoDebajoStockMinimo
as
begin
	select distinct PP.IdProveedor ,pv.NombreProveedor
		from Proveedor Pv
		inner join Producto_Proveedor PP on PP.IdProveedor=PV.IdProveedor
		inner join Producto p	on p.IdProducto=pp.IdProducto
	where StockActual<=StockMin 
end
go

 create procedure buscarcompra
	@IdCompra  int
	as
	begin
		select IdCompra,MontoCompra,Fecha,IdProveedor from Compra where IdCompra=@IdCompra
	end
go	

create procedure listarCompra
	@IdCompra  int
	as 
	begin
		select IdCompra,IdProducto,CantidadComprada,PrecioUnitario,IdDetalleCompra from DetalleCompra where IdCompra=@IdCompra
	end
go


create PROCEDURE proveedoresxProducto
    @IdCompra INT
	AS
	BEGIN
		SELECT DISTINCT pv.IdProveedor, pv.NombreProveedor
		FROM Producto p
		INNER JOIN Producto_Proveedor pp ON pp.IdProducto = p.IdProducto
		INNER JOIN Proveedor pv ON pv.IdProveedor = pp.IdProveedor
		INNER JOIN (
			SELECT dt.IdProducto 
			FROM Compra c 
			INNER JOIN DetalleCompra dt ON dt.IdCompra = c.IdCompra
			WHERE dt.IdCompra = @IdCompra
		) AS d ON d.IdProducto = p.IdProducto
	END
GO



create procedure ResponsableID
	as
	begin
		select  E.NombreEmp,R.IdResp from ResponsableEmpresa R
			inner join Empleado E on E.IdEmpleado=R.IdEmpleado
	end
go



select * from Producto
