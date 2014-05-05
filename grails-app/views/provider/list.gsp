<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Proveedores</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<g:render template="/layouts/toolbar"/>
	<g:if test="${providers}">
		<table class="table table-hover">
			<thead>
				<th>Proveedores</th>
				<th width="150"></th>
				<th width="1"></th>
				<th width="1"></th>
			</thead>
			<tbody>
				<g:each in="${providers}" var="provider">
					<tr>
						<td>${provider}</td>
						<td><g:link controller="product" params="[providerId:provider.id]" class="btn btn-default btn-xs">Administrar productos</g:link></td>
						<td><g:link action="edit" id="${provider.id}" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
						<td><g:link action="delete" id="${provider.id}" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-remove"></span></g:link></td>
					</tr>
				</g:each>
			</tbody>
		</table>
	</g:if>
	<g:else>
		<div class="alert alert-info">Nada que mostrar, no hay proveedores registrados.</div>
	</g:else>
	</body>
</body>
</html>