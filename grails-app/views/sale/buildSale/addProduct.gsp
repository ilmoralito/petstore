<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Seleccionar producto</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<div class="row">
		<div class="col-md-9">
			<g:render template="buildSale/itemsCollection"/>
		</div>
		<div class="col-md-3">
			<g:render template="toolbar"/>
			<g:form>
				<g:if test="${products}">
					<div class="form-group">
						<label for="productId">Nombre del producto</label>
						<g:select name="productId" from="${products}" optionKey="id" class="form-control"/>
					</div>
					<g:submitButton name="confirm" value="Confirmar" class="btn btn-default"/>
					</g:if>
					<g:else>
						<p><b>SIN EXISTENCIAS</b></p>
					</g:else>
					<g:submitButton name="cancel" value="Cancelar" class="btn btn-primary"/>
			</g:form>
		</div>
	</div>
</body>
</html>