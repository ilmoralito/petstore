<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Datos de ${provider}</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<table class="table">
		<tbody>
			<tr>
				<td width="180"><b>Nombre</b></td>
				<td>${provider}</td>
			</tr>
			<tr>
				<td><b>Nombre de contacto</b></td>
				<td>${provider.contactName}</td>
			</tr>
			<tr>
				<td><b>Telefono de contacto</b></td>
				<td>${provider.contactTelephoneNumber}</td>
			</tr>
		</tbody>
	</table>
</body>
</html>