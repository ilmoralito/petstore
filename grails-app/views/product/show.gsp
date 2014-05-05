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
		<div class="col-md-8">
			<h4>${product.name.toUpperCase()}</h4>
			<g:if test="${product?.presentations}">
				<table class="table table-hover">
					<thead>
						<th width="1">Presentacion</th>
						<th>Existencias</th>
						<th width="1"></th>
					</thead>
					<tbody>
						<g:each in="${product.presentations}" var="presentation">
							<tr>
								<td>${presentation.presentation}</td>
								<td>${presentation.quantity}</td>
								<td><g:link action="delete" params="[id:presentation.id, providerId:params?.providerId]"><span class="glyphicon glyphicon-remove"></span></g:link></td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</g:if>
			<g:else>
				<p>Nada que mostrar</p>
			</g:else>
		</div>
		<div class="col-md-4">
			<h4>Agregar presentacion</h4>
			<g:form action="create">
				<div class="form-group">
					<label for="presentation">Presentacion</label>
					<g:select name="presentation" from="${["Inyeccion", "Pildora", "Jarabe"]}" class="form-control"/>
				</div>
				<div class="form-group">
					<label for="quantity">Cantidad</label>
					<g:textField name="quantity" class="form-control"/>
				</div>
				<g:submitButton name="send" value="Agregar" class="btn btn-default"/>
			</g:form>
		</div>
	</div>
</body>
</html>