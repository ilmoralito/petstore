<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Editar</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<div class="row">
		<div class="col-md-6">
			<h4>Actualizar datos de ${provider}</h4>
			<g:form action="update">
				<g:hiddenField name="id" value="${params?.id}"/>
				<g:render template="form"/>
				<g:submitButton name="send" value="Actualizar" class="btn btn-primary"/>
				<g:link action="list" class="btn btn-default">Cancelar</g:link>
			</g:form>
			<p>
				<g:hasErrors bean="${provider}"><g:renderErrors bean="${provider}"></g:renderErrors></g:hasErrors>
			</p>
		</div>
		<div class="col-md-6">
			<g:form action="addTelephone" autocomplete="off">
				<g:hiddenField name="id" value="${provider?.id}"/>
				<g:render template="/layouts/contactForm"/>
				<g:submitButton name="addTelephone" value="Agregar telefono" class="btn btn-primary"/>
			</g:form>
			<br>
			<g:render template="/layouts/telephones"/>
		</div>
	</div>
</body>
</html>