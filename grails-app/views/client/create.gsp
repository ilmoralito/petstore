<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Crear cliente</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<g:hasErrors bean="${client}"><g:renderErrors bean="${client}"></g:renderErrors></g:hasErrors>
	<g:form action="create">
		<g:render template="form"/>
		<g:submitButton name="send" value="Guardar" class="btn btn-primary"/>
		<g:link action="list" class="btn btn-default">Cancelar</g:link>
	</g:form>
</body>
</html>