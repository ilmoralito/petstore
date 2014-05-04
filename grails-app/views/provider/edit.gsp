<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Editar</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<h3>Actualizar datos de ${provider}</h3>
	<g:hasErrors bean="${provider}"><g:renderErrors bean="${provider}"></g:renderErrors></g:hasErrors>
	<g:form action="update">
		<g:hiddenField name="id" value="${params?.id}"/>
		<g:render template="form"/>
		<g:submitButton name="send" value="Actualizar" class="btn btn-primary"/>
		<g:link action="list" class="btn btn-default">Cancelar</g:link>
	</g:form>
</body>
</html>