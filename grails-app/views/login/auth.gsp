<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Iniciar sesion</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<form action='${postUrl}' method='POST' id='loginForm' autocomplete='off'>
		<div class="form-group">
			<label for='username'><g:message code="springSecurity.login.username.label"/>:</label>
			<input type='text' class='form-control' name='j_username' id='username' autofocus="true"/>
		</div>

		<div class="form-group">
			<label for='password'><g:message code="springSecurity.login.password.label"/>:</label>
			<input type='password' class='form-control' name='j_password' id='password'/>
		</div>

		<div class="form-group">
			<input type='submit' id="submit" class="btn btn-primary" value='${message(code: "springSecurity.login.button")}'/>
		</div>
	</form>
</body>
</html>
