<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Productos</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<div class="row">
		<div class="col-md-9">
			<g:if test="${products}">
				<h4>Productos de ${provider.name.toUpperCase()}</h4>
				<table class="table table-hover">
					<thead>
						<th width="1">Precio</th>
						<th>Producto</th>
						<th width="1"></th>
						<th width="1"></th>
					</thead>
					<tbody>
						<g:each in="${products}" var="product">
							<tr>
								<td>${product.price}</td>
								<td><g:link action="show" id="${product.id}">${product}</g:link></td>
								<td><g:link action="edit" params="[id:product.id, providerId:params?.providerId]"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
								<td><g:link action="delete" id="${product.id}"><span class="glyphicon glyphicon-remove"></span></g:link></td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</g:if>
			<g:else>
				<div class="alert alert-info">Nada que mostrar</div>
			</g:else>
		</div>
		<div class="col-md-3">
			<h4>Agregar producto</h4>
			<g:form action="save">
				<g:hiddenField name="providerId" value="${params?.providerId}"/>
				<div class="form-group">
					<g:textField name="name" class="form-control" placeholder="Nombre del producto" autofocus="true"/>
				</div>
				<div class="form-group">
					<g:textField name="price" class="form-control" placeholder="Precio del producto"/>
				</div>
				<g:submitButton name="send" value="Agregar" class="btn btn-default pull-right"/>
			</g:form>
		</div>
	</div>
</body>
</body>
</html>