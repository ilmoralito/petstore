<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Perfil</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<g:render template="navbar"/>

	<g:hasErrors bean="${user}">
		<g:renderErrors bean="${user}"/>
	</g:hasErrors>

	<div class="row">
		<div class="col-md-4">
			<g:form action="profile">
				<div class="form-group">
					<label for="username">Nombre de usuario</label>
					<g:textField name="username" value="${user?.username}" class="form-control" autofocus="true"/>
				</div>
				<g:submitButton name="send" value="Confirmar" class="btn btn-default"/>
			</g:form>
		</div>
	</div>
</body>
</html>