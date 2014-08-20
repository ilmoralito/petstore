<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Agregar cantidad</title>
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
					<label for="quantity">${provider} / ${product} / ${presentation} / ${detail.measure} / Cantidad</label>
					<input type="number" name="quantity" id="quantity" min="1" max="${quantity}" autofocus="true" placeholder="${quantity}" class="form-control">
				</div>
				<g:submitButton name="confirm" value="Confirmar" class="btn btn-block btn-primary"/>
				<g:link event="cancel" class="btn btn-block btn-warning">Cancelar</g:link>
			</g:form>
			<g:render template="buildSale/errors"/>
		</div>
	</div>
</body>
</html>