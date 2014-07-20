<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Editar detalle</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<h4>${detail.presentation.product} / ${detail.presentation.presentation} / ${detail.measure}</h4>
	<g:form action="update" autocomplete="off">
		<g:hiddenField name="id" value="${params?.id}"/>
		<div class="form-group">
			<label for="quantity">Cantidad</label>
			<g:textField name="quantity" value="${detail?.quantity}" class="form-control" autofocus="true"/>
		</div>
		<div class="form-group">
			<label for="price">Precio</label>
			<g:textField name="price" value="${detail?.price}" class="form-control"/>
		</div>
		<g:submitButton name="send" value="Actualizar" class="btn btn-primary"/>
	</g:form>
</body>
</html>