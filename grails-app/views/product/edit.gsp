<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Editar</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<h4>Actualizar datos de ${product.name.toUpperCase()}</h4>
	<g:hasErrors bean="${product}"><g:renderErrors bean="${product}"></g:renderErrors></g:hasErrors>
	<g:form action="update">
		<g:hiddenField name="id" value="${params?.id}"/>
		<g:hiddenField name="providerId" value="${params?.providerId}"/>
		<g:render template="form"/>
		<g:submitButton name="send" value="Actualizar" class="btn btn-primary"/>
		<g:link action="list" params="[providerId:params?.providerId]" class="btn btn-default">Ir a lista de productos</g:link>
	</g:form>
</body>
</html>