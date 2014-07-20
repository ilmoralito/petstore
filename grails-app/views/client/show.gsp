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
		<div class="col-md-7">
			<h4>Cliente</h4>
			<p>
				<div class="row">
					<div class="col-md-2">Propietario</div>
					<div class="col-md-10">${client.fullName}</div>
				</div>
			</p>
			<p>
				<div class="row">
					<div class="col-md-2">Agroservicio</div>
					<div class="col-md-10">${client.storeName}</div>
				</div>
			</p>
			<p>
				<div class="row">
					<div class="col-md-2">Direccion</div>
					<div class="col-md-10">${client.town}, ${client.city}, ${client.address}</div>
				</div>
			</p>
			<g:link action="edit" id="${client.id}" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-pencil"></span></g:link>
		</div>
		<div class="col-md-5">
			<g:render template="contact"/>
		</div>
	</div>
</body>
</html>