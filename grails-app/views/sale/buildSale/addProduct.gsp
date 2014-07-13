<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Agregar producto</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<div class="row">
		<div class="col-md-9">
			<g:render template="buildSale/sales"/>
		</div>
		<div class="col-md-3">
			<g:form>
				<div class="form-group">
					<label for="product">Producto</label>
					<g:select name="product" from="${products}" optionKey="id" class="form-control"/>
				</div>
				<g:submitButton name="confirm" value="Confirmar" class="btn btn-primary"/>
				<g:link event="cancel" class="btn btn-warning">Cancelar</g:link>
			</g:form>
			<g:if test="${sales}">
				<br>
				<g:form>
					<div class="form-group">
						<input type="number" name="payment" id="payment" min="0.0" step="0.5" max="${sales.total.sum()}" class="form-control" placeholder="Pago">
					</div>
					<div class="form-group">
						<g:textField name="invoice" class="form-control" placeholder="Numero de factura"/>
					</div>
					<g:submitButton name="pay" value="Confirmar" class="btn btn-primary"/>
				</g:form>
			</g:if>
		</div>
	</div>
</body>
</html>