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
				<th width="160"></th>
				<th width="1"></th>
			</thead>
			<tbody>
				<g:each in="${providers}" var="provider">
					<tr>
						<td><g:link action="edit" id="${provider.id}">${provider}</g:link></td>
						<td><g:link controller="product" params="[providerId:provider.id]">Administrar productos</g:link></td>
						<td><g:link action="delete" id="${provider.id}"><span class="glyphicon glyphicon-trash"></span></g:link></td>
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