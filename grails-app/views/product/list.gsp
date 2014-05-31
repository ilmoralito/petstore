<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Productos</title>
	<r:require modules="bootstrap-css, appJs"/>
</head>
<body>
	<g:set var="presentations" value="${grailsApplication.config.ni.org.petstore.presentations.keySet()}"/>

	<div class="row">
		<div class="col-md-6">
			<h4>${provider}</h4>
		</div>
		<div class="col-md-6">
			<g:form action="save" class="form-inline pull-right" role="form" autocomplete="off">
				<g:hiddenField name="providerId" value="${params?.providerId}"/>
				<div class="form-group">
					<g:textField name="name" class="form-control" placeholder="Nombre del producto"/>
				</div>
				<g:submitButton name="send" value="Agregar" class="btn btn-primary"/>
			</g:form>
		</div>
	</div>
	<g:if test="${products}">
		<table class="table table-hover">
			<thead>
				<td width="1"></td>
				<th>Productos</th>
				<th width="1"></th>
				<th width="1"></th>
			</thead>
			<tbody>
				<g:each in="${products}" var="product">
						<tr>
							<td><g:link action="edit" params="[id:product.id, providerId:params?.providerId]"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
							<td>${product}</td>
							<td><g:link controller="presentation" action="presentations" params="[id:product.id]"><span class="glyphicon glyphicon-align-justify"></span></g:link></td>
							<td><g:link action="delete" id="${product.id}"><span class="glyphicon glyphicon-trash"></span></g:link></td>
						</tr>
				</g:each>
			</tbody>
		</table>
	</g:if>
	<g:else>
		<div class="alert alert-info">Nada que mostrar</div>
	</g:else>
</body>
</html>