<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="message">
	<title>Confirmar</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<g:form params="${params}">
		<h4>Si eliminas este registro no podras deshacer los cambios. Deseas continuar?</h4>

		<g:actionSubmit value="Confirmar" action="confirm" class="btn btn-warning"/>
		<g:actionSubmit value="Cancelar" action="cancel" class="btn btn-default"/>
	</g:form>
</body>
</html>