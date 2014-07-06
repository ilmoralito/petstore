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
	<div class="row">
		<div class="col-md-8">
			<p>
				<div class="row">
					<div class="col-md-2">Nombre</div>
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
		</div>
		<div class="col-md-4">
			<g:render template="contact"/>
		</div>
	</div>
</body>
</html>