<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Crear cliente</title>
	<r:require modules="bootstrap-css, appStorage"/>
</head>
<body>
	<div class="row">
		<div class="col-md-8">
			<h4>Datos de cliente</h4>
			<g:form name="addNewClientForm">
				<g:render template="form"/>
				<g:submitButton name="addClient" value="Guardar" class="btn btn-primary"/>
				<g:link controller="client" action="list" class="btn btn-default">Cancelar</g:link>
			</g:form>
			<p>
				<g:hasErrors bean="${client}"><g:renderErrors bean="${client}"></g:renderErrors></g:hasErrors>
			</p>
		</div>
		<div class="col-md-4">
			<h4>Emails</h4>
			<g:form autocomplete="off">
				<div class="form-group">
					<g:textField name="email" class="form-control"/>
				</div>
				<g:submitButton name="addEmail" value="Agregar" class="btn btn-primary"/>
			</g:form>
			<br>
			<g:if test="${emails}">
				<table class="table table-striped">
					<g:each in="${emails}" var="email" status="i">
						<tr>
							<td>${email}</td>
							<td width="1">
								<g:link event="deleteEmail" params="[id:i]">
									<span class="glyphicon glyphicon-trash btn-sm"></span>
								</g:link>
							</td>
						</tr>
					</g:each>
				</table>
			</g:if>

			<h4>Telefonos</h4>
			<g:form autocomplete="off">
				<div class="form-group">
					<div class="form-group">
						<g:select name="type" from="['Convencional', 'Claro', 'Movistar']" value="${type}" class="form-control"/>
					</div>
					<div class="form-group">
						<g:textField name="number" class="form-control"/>
					</div>
					<g:submitButton name="addTelephone" value="Agregar" class="btn btn-primary"/>
				</div>
			</g:form>
			<g:if test="${telephones}">
				<table class="table table-striped">
					<g:each in="${telephones}" var="telephone" status="index">
						<tr>
							<td>${telephone.type}</td>
							<td>${telephone.number}</td>
							<td width="1">
								<g:link event="deleteTelephone" params="[index:index]">
									<span class="glyphicon glyphicon-trash btn-sm"></span>
								</g:link>
							</td>
						</tr>
					</g:each>
				</table>
			</g:if>
		</div>
	</div>
</body>
</html>