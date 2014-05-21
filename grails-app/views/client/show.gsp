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
			<h4>Email</h4>
			<form action="addEmail" method="post" class="form-inline" role="form">
				<g:hiddenField name="id" value="${client.id}"/>
				<div class="form-group">
					<g:textField name="email" class="form-control" placeholder="Email"/>
				</div>
				<g:submitButton name="send" value="Agregar" class="btn btn-primary"/>
			</form>
			<br>
			<table class="table table-striped">
				<tbody>
					<g:each in="${client.emails}" var="email">
						<tr>
							<td>${email}</td>
							<td width="1">
								<g:link action="deleteEmail" params="[id:client.id, email:email]">
									<span class="glyphicon glyphicon-trash"></span>
								</g:link>
							</td>
						</tr>
					</g:each>
				</tbody>
			</table>

			<h4>Telefonos</h4>
			<g:form action="addTelephone">
				<g:hiddenField name="id" value="${client.id}"/>
				<div class="form-group">
					<g:select name="type" from="${['Movistar', 'Claro', 'Convencional']}" class="form-control"/>
				</div>
				<div class="form-group">
					<g:textField name="number" class="form-control" placeholder="Telefono"/>
				</div>
				<g:submitButton name="send" value="Agregar" class="btn btn-primary"/>
			</g:form>
			<br>
			<table class="table table-striped">
				<tbody>
					<g:each in="${client.telephones}" var="telephone">
						<tr>
							<td width="1">${telephone.number}</td>
							<td>${telephone.type}</td>
							<td width="5">
								<g:link action="deleteTelephone" params="[id:client.id, telephoneId:telephone.id]">
									<span class="glyphicon glyphicon-trash"></span>
								</g:link>
							</td>
						</tr>
					</g:each>
				</tbody>
			</table>
		</div>
	</div>
</body>
</html>