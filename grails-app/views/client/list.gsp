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
				<th>Clientes</th>
				<th width="1"></th>
			</thead>
			<tbody>
				<g:each in="${clients}" var="client">
					<tr>
						<td><g:link action="show" params="[id:client.id]">${client.fullName}, ${client.storeName}</g:link></td>
						<td>
							<g:link controller="message" params="[id:client.id, ctrl:controllerName, act:actionName]">
								<span class="glyphicon glyphicon-trash"></span>
							</g:link>
						</td>
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