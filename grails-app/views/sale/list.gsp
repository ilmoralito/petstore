<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Ventas</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<div class="row">
		<div class="col-md-9">
			<g:if test="${sales}">
				<div class="table">
					<thead>
						<th>Cliente</th>
					</thead>
					<tbody>
						<g:each in="${sales}" var="sale">
							<tr>
								<td>${sale.client}</td>
							</tr>
						</g:each>
					</tbody>
				</div>
			</g:if>
		</div>
		<div class="col-md-3">
			<ul class="nav nav-tabs">
			  <li class="active"><g:link action="list">Cliente</g:link></li>
			  <li><g:link action="#">Fecha</g:link></li>
			</ul>
			<p>
				<g:form action="list">
					<div class="form-group">
						<label for="client">Cliente</label>
						<g:select name="client" from="${clients}" optionKey="id" value="${params?.client}" class="form-control"/>
					</div>
					<div class="form-group">
						<label for="status">Estado</label>
						<g:select name="status" from="[true, false]" value="${params.boolean('status')}" class="form-control"/>
					</div>
					<g:submitButton name="send" value="Listar" class="btn btn-primary"/>
				</g:form>
			</p>
		</div>
	</div>
</body>
</html>