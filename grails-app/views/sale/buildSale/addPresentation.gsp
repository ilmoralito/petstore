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
					<label for="presentation">${provider} / ${product} / Presentaciones</label>
					<g:radioGroup name="presentation" labels="${presentations}" values="${presentations*.id}">
						<p>${it.radio} <g:message code="${it.label}"/></p>
					</g:radioGroup>
				</div>
				<g:submitButton name="confirm" value="Confirmar" class="btn btn-block btn-primary"/>
				<g:link event="cancel" class="btn btn-block btn-warning">Cancelar</g:link>
			</g:form>
			<g:render template="buildSale/errors"/>
		</div>
	</div>
</body>
</html>