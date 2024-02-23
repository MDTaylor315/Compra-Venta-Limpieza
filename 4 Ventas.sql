use LimpiezaVenta
go

SELECT distinct R.IdResp FROM ResponsableEmpresa R 
                                INNER JOIN Documento D ON D.IdResp = R.IdResp
                                INNER JOIN Venta V ON V.NumeroDocumento = D.NumeroDocumento 
								go
create procedure buscarVenta
	@IdVenta	int
as
begin
	select IdVenta,MontoVenta,Fecha,IdCliente from Venta where IdVenta=@IdVenta
end
go


CREATE PROCEDURE consultarDetallesVenta
	@IdVenta int
as
begin
	select IdVenta,IdProducto,CantidadVendida,PrecioUnitario,IdDetalleVenta from DetalleVenta
	where IdVenta=@IdVenta
end
go

create procedure buscarCliente
	@IdVenta int	
as
begin
	select  c.NombreCliente,c.IdCliente
	from Venta V
	inner join Cliente C on v.IdCliente=c.IdCliente
	where V.IdVenta= @IdVenta
end
go

go


/*
CREATE procedure eliminarVenta
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

	delete from DetalleVenta where IdVenta=@IdVenta
	delete from Venta where IdVenta=@IdVenta 
end
go
*/


create procedure actualizarDetalleVenta
	@IdDetalleVenta int,	
	@IdVenta int,
	@CantidadVendida int
	as
	begin
		declare	@IdProducto int,
				@StockActual int,
				@CantidadAnterior int

			select @IdProducto =IdProducto,@CantidadAnterior = CantidadVendida from DetalleVenta where IdDetalleVenta = @IdDetalleVenta
			select @StockActual=StockActual from Producto where IdProducto = @IdProducto

			if @StockActual >= @CantidadVendida
			begin
				update DetalleVenta
					set CantidadVendida=@CantidadVendida
				where IdVenta=@IdVenta and IdDetalleVenta=@IdDetalleVenta
				
				 UPDATE Venta	 
					  SET MontoVenta= (SELECT SUM(CantidadVendida * PrecioUnitario) FROM DetalleVenta WHERE IdVenta = @IdVenta)
					  WHERE  IdVenta = @IdVenta

				UPDATE Documento
					SET PrecioDocumento = c.MontoVenta
					FROM Documento d
					INNER JOIN Venta c ON d.NumeroDocumento = c.NumeroDocumento
					WHERE c.IdVenta = @IdVenta

			
			
				if @CantidadVendida > @CantidadAnterior
				begin
					UPDATE Producto
						set StockActual = StockActual + @CantidadVendida - @CantidadAnterior
					from Producto where IdProducto=@IdProducto
				end
				else if @CantidadAnterior > @CantidadVendida
				begin
					UPDATE Producto
						set StockActual = StockActual - @CantidadVendida + @CantidadAnterior
					from Producto where IdProducto=@IdProducto
				end
			end
			
			
	end
go

select * from Documento where TipoDoc='Guía'

select * from Producto_Proveedor
go

CREATE PROCEDURE ClientesP
as
begin
	select * from Cliente
end
go

create view V_Productos as
	select	IdProducto as ID,
			DescripciónProducto as Producto,
			PrecioBase*1.38 as Monto,
			StockActual as [Stock Actual],
			c.DescripcionCategoria as Categoria
	from Producto P
	inner join Categoria C on P.IdCategoria = C.IdCategoria
	where CantidadReposicion>0 and StockActual >0
go

select * from Compra
select * from Venta

select * from Producto where IdProducto=4

select * from Documento D
inner join Venta V on D.NumeroDocumento = V.NumeroDocumento
where V.IdVenta = 1
