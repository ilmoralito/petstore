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
					<label for="product">${provider} / Productos</label>
					<g:radioGroup name="product" labels="${products}" values="${products*.id}">
						<p>${it.radio} <g:message code="${it.label}"/></p>
					</g:radioGroup>
				</div>
				<g:submitButton name="confirm" value="Confirmar" class="btn btn-block btn-primary"/>
				<g:link event="cancel" class="btn btn-block btn-warning">Cancelar</g:link>
			</g:form>
			<g:if test="${sales}">
				<hr>
				<g:form autocomplete="off">
					<div class="form-group">
						<g:select name="status" from="['Contado', 'Credito']" keys="[true, false]" noSelection="[null:'Tipo de pago']" class="form-control"/>
					</div>
					<div class="form-group">
						<g:textField name="invoice" class="form-control" placeholder="Numero de factura" autofocus="true"/>
					</div>
					<g:submitButton name="pay" value="Confirmar venta" class="btn btn-primary btn-block"/>
				</g:form>
			</g:if>
		</div>
	</div>
</body>
</html>