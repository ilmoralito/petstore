<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Clientes</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<g:render template="/layouts/toolbar"/>
	<g:if test="${clients}">
		<table class="table table-hover">
			<thead>
				<th>Nombre</th>
				<th width="1"></th>
				<th width="1"></th>
			</thead>
			<tbody>
				<g:each in="${clients}" var="client">
					<tr>
						<td><g:link action="show" params="[id:client.id]">${client.fullName}</g:link></td>
						<td><g:link action="edit" params="[id:client.id]" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
						<td><g:link action="delete" params="[id:client.id]" class="btn btn-default btn-xs"><span class="glyphicon glyphicon-remove"></span></g:link></td>
					</tr>
				</g:each>
			</tbody>
		</table>
	</g:if>
	<g:else>
		<div class="alert alert-info">Nada que mostrar, no hay clientes registrados.</div>
	</g:else>
	</body>
</body>
</html>