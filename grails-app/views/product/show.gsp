<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Producto ${product}</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<div class="row">
		<div class="col-md-6">
			<h4>${product.name.toUpperCase()}</h4>
		</div>
		<div class="col-md-6">
			<g:link action="list" params="[providerId:params?.providerId]" class="btn btn-default pull-right">Regresar a lista de productos</g:link>
		</div>
	</div>
	<div class="row">
		<g:each in="${['Inyeccion', 'Pildora', 'Jarabe']}" var="presentation">
			<div class="col-md-2">
				<g:form controller="presentation" action="update">
					<h4>${presentation}</h4>
					<g:hiddenField name="presentation" value="${presentation}"/>
					<g:hiddenField name="id" value="${params?.id}"/>
					<g:hiddenField name="providerId" value="${params?.providerId}"/>
					<div class="form-group">
						<g:textField name="quantity" value="${ps.showPrice(product:product, presentation:presentation)}" class="form-control input-block"/>
					</div>
					<g:submitButton name="send" value="Confirmar" class="btn btn-default btn-block"/>
				</g:form>
			</div>
		</g:each>
	</div>
</body>
</html>