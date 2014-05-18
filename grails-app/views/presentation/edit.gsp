<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Presentacion</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<h4>Editar presentacion</h4>
	<g:form action="update">
		<g:hiddenField name="id" value="${params?.id}"/>
		<g:hiddenField name="productId" value="${params?.productId}"/>
		<g:hiddenField name="providerId" value="${params?.providerId}"/>
		<g:form action="update">
			<div class="form-group">
				<label for="presentation">Presentacion</label>
				<span class="form-control">${presentation?.presentation}</span>
			</div>
			<div class="form-group">
				<label for="price">Precio</label>
				<g:textField name="price" value="${presentation?.price}" class="form-control" autofocus="true"/>
			</div>
			<div class="form-group">
				<label for="quantity">Cantidad</label>
				<g:textField name="quantity" value="${presentation?.quantity}" class="form-control"/>
			</div>
			<g:submitButton name="send" value="Actualizar" class="btn btn-default"/>
			<g:link controller="product" action="list" params="[id:params?.productId, providerId:params?.providerId]" class="btn btn-default">Ir a producto</g:link>
		</g:form>
	</g:form>
</body>
</html>