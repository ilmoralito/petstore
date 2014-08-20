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
					<g:select name="client" from="${clients}" optionKey="id" noSelection="['':'Selecciona cliente']" class="form-control"/>
				</div>
				<div class="form-group">
					<g:select name="provider" from="${providers}" optionKey="id" noSelection="['':'Selecciona proveedor']" class="form-control"/>
				</div>
				<g:submitButton name="confirm" value="Confirmar" class="btn btn-block btn-primary"/>
			</g:form>
			<g:render template="buildSale/errors"/>
		</div>
	</div>
</body>
</html>