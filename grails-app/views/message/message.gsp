<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Confirmar</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<g:form params="[id:params?.id, ctrl:params?.ctrl, act:params?.act]">
		<p>Si eliminas este registro no podras deshacer los cambios. Deseas continuar?</p>

		<g:actionSubmit value="Confirmar" action="confirm" class="btn btn-warning"/>
		<g:actionSubmit value="Cancelar" action="cancel" class="btn btn-default"/>
	</g:form>
</body>
</html>