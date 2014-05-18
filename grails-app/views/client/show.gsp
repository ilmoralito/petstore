<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Datos</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<g:render template="navbar"/>
	<p>
		<div class="row">
			<div class="col-md-2">Nombre completo</div>
			<div class="col-md-10">${client.fullName}</div>
		</div>
	</p>
	<p>
		<div class="row">
			<div class="col-md-2">Tienda</div>
			<div class="col-md-10">${client.storeName}</div>
		</div>
	</p>
	<p>
		<div class="row">
			<div class="col-md-2">Direccion</div>
			<div class="col-md-10">${client.city}, ${client.address}</div>
		</div>
	</p>
	<p>
		<div class="row">
			<div class="col-md-2">Telefono</div>
			<div class="col-md-10">${client.telephone}</div>
		</div>
	</p>
	<p>
		<div class="row">
			<div class="col-md-2">Correo electronico</div>
			<div class="col-md-10">${client.email}</div>
		</div>
	</p>
</body>
</html>