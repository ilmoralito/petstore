<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Seleccionar presentacion</title>
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
					<label for="presentation">Presentaciones</label>
					<g:select name="presentation" from="${presentations}" optionKey="id" class="form-control"/>
				</div>
				<g:submitButton name="confirm" value="Confirmar" class="btn btn-primary"/>
				<g:link event="cancel" class="btn btn-warning">Cancelar</g:link>
			</g:form>
		</div>
	</div>
</body>
</html>