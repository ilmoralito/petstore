<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Datos de ${client}</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<g:render template="navbar"/>
	<table class="table">
		<tbody>
			<tr>
				<td width="160"><b>Nombre completo</b></td>
				<td>${client}</td>
			</tr>
			<tr>
				<td><b>Nombre de la tienda</b></td>
				<td>${client.storeName}</td>
			</tr>
			<tr>
				<td><b>Direccion</b></td>
				<td>${client.city}, ${client.address}</td>
			</tr>
			<tr>
				<td><b>Telefono</b></td>
				<td>${client.telephone}</td>
			</tr>
			<tr>
				<td><b>Correo electronico</b></td>
				<td>${client.email}</td>
			</tr>
		</tbody>
	</table>
</body>
</html>