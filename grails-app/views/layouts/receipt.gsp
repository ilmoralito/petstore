<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title><g:layoutTitle default="Formulario de abono"/></title>
	<r:layoutResources/>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-8 col-md-offset-2">
				<g:layoutBody/>

				<br>
				<g:hasErrors bean="${errors}">
					<small><g:renderErrors bean="${errors}"/></small>
				</g:hasErrors>

				<g:if test="${message}">
					<small>${message}</small>
				</g:if>
			</div>
		</div>
	</div>
	<r:layoutResources/>
</body>
</html>
