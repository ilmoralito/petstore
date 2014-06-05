<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Selecciona cliente</title>
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
					<label for="client">Cliente</label>
					<g:select name="client" from="${clients}" optionKey="id" class="form-control"/>
				</div>
				<g:submitButton name="confirm" value="Confirmar" class="btn btn-primary"/>
			</g:form>
		</div>
	</div>
</body>
</html>