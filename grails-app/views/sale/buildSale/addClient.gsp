<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Agregar cliente</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<g:render template="toolbar"/>
	<div class="row">
		<div class="col-md-9">
			<g:render template="buildSale/itemsCollection"/>
		</div>
		<div class="col-md-3">
			<g:form>
				<div class="form-group">
					<label for="clientId">Nombre del cliente</label>
					<g:select name="clientId" from="${clients}" optionKey="id" class="form-control"/>
				</div>
				<g:submitButton name="confirm" value="Confirmar" class="btn btn-primary btn-block"/>
			</g:form>
		</div>
	</div>
</body>
</html>