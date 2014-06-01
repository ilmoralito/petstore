<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Editar detalle de presentacion</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<g:link event="goBackToAdminPresentationDetail" class="pull-right">Regresar</g:link>
	<br><br>
	<g:form>
		<g:render template="/presentation/presentations/form"/>
		<g:submitButton name="confirm" value="Confirmar" class="btn btn-primary"/>
	</g:form>
</body>
</html>