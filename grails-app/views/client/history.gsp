<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Historial</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<g:render template="navbar"/>
	<g:if test="${sales}">
		<table class="table table-hover">
			<thead>
				<th>Ventas</th>
			</thead>
			<tbody>
				<g:each in="${sales}" var="sale">
					<g:set var="dateCreated" value="${sale.dateCreated.format('yyyy-MM-dd')}"/>
					<tr>
						<td><g:link action="history" params="[dateCreated:dateCreated, id:params?.id]">${dateCreated}</g:link></td>
					</tr>
					<g:if test="${dateCreated == params?.dateCreated}">
						<tr>
							<td>
								
							</td>
						</tr>
					</g:if>
				</g:each>
			</tbody>
		</table>
	</g:if>
</body>
</html>