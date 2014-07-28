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

				<!--flash message-->
				<g:if test="${flash.message}">
					<br><div class="alert alert-info">${flash.message}</div>
				</g:if>
				<!--flash message-->
			</div>
		</div>
	</div>
	<r:layoutResources/>
</body>
</html>
