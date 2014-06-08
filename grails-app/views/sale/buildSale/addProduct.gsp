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
						<g:textField name="payment" class="form-control" placeholder="Pago"/>
					</div>
					<g:submitButton name="pay" value="Confirmar" class="btn btn-primary"/>
				</g:form>
			</g:if>
		</div>
	</div>
</body>
</html>