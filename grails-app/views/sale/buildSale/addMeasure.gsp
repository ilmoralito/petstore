<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Agregar unidad de medidad</title>
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
					<label for="measure">Medidas</label>
					<g:select name="measure" from="${measures}" class="form-control"/>
				</div>
				<g:submitButton name="confirm" value="Confirmar" class="btn btn-primary"/>
			</g:form>
		</div>
	</div>
</body>
</html>