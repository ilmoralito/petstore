<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Clave de paso</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<g:render template="navbar"/>

	<g:hasErrors bean="${cmd}">
		<g:renderErrors bean="${cmd}"/>
	</g:hasErrors>

	<div class="row">
		<div class="col-md-4">
			<g:form action="password">
				<div class="form-group">
					<label for="currentPassword">Clave actual</label>
					<g:passwordField name="currentPassword" class="form-control" autofocus="true"/>
				</div>
				<div class="form-group">
					<label for="newPassword">Nueva clave</label>
					<g:passwordField name="newPassword" class="form-control"/>
				</div>
				<div class="form-group">
					<label for="repeatNewPassword">Repetir nueva clave</label>
					<g:passwordField name="repeatNewPassword" class="form-control"/>
				</div>

				<g:submitButton name="send" value="Confirmar" class="btn btn-default"/>
			</g:form>
		</div>
	</div>
</body>
</html>