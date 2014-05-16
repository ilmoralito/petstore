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
			<g:render template="buildSale/itemsCollection"/>
		</div>
		<div class="col-md-3">
			<g:render template="toolbar"/>
			<g:form>
				<div class="form-group">
					<label for="presentationId">Presentacion</label>
					<g:select name="presentationId" from="${presentations}" optionKey="id" class="form-control"/>
				</div>
				<g:submitButton name="confirm" value="Confirmar" class="btn btn-default"/>
				<g:submitButton name="cancel" value="Otro producto" class="btn btn-primary"/>
			</g:form>
		</div>
	</div>
</body>
</html>