<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Crear proveedor</title>
	<r:require modules="bootstrap-css, appProviderStorage"/>
</head>
<body>
	<div class="row">
		<div class="col-md-6">
			<h4>Datos de proveedor</h4>
			<g:form name="addProvider" autocomplete="off">
				<g:render template="form"/>
				<g:submitButton name="confirm" value="Guardar" class="btn btn-primary"/>
				<g:link action="list" class="btn btn-default">Cancelar</g:link>
			</g:form>
		</div>
		<div class="col-md-6">
			<g:form autocomplete="off">
				<g:render template="/layouts/contactForm"/>
				<g:submitButton name="addTelephone" value="Agregar telefono" class="btn btn-primary"/>
			</g:form>
			<br>
			<g:render template="/layouts/telephones"/>
		</div>
	</div>
	<p><g:hasErrors bean="${provider}"><g:renderErrors bean="${provider}"></g:renderErrors></g:hasErrors></p>
</body>
</html>