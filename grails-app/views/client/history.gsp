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
		<g:if test="${!params?.dateCreated}">
			<table class="table table-hover">
				<thead>
					<th>Ventas</th>
				</thead>
				<tbody>
					<g:each in="${sales}" var="sale">
						<g:set var="dateCreated" value="${sale.dateCreated.format("yyyy-MM-dd")}"/>
						<tr>
							<td><g:link action="history" params="[id:params?.id, dateCreated:dateCreated]">${dateCreated}</g:link></td>
						</tr>
					</g:each>
				</tbody>
			</table>
		</g:if>
		<g:else>
			<!--Datos agrupados por producto-->
			<h4>Compras de ${client} el ${params?.dateCreated}</h4>
			<g:each in="${sales.keySet()}" var="item">
				<div class="row">
					<div class="col-md-12">
						<b>${item.name.toUpperCase()}</b>
					</div>
				</div>
				<div class="row">
					<div class="col-md-12">
						<table class="table table-hover">
							<thead>
								<th width="1"></th>
								<th width="5">Presentacion</th>
								<th>Total</th>
							</thead>
							<tbody>
								<g:each in="${sales[item]}" var="presentation">
									<tr>
										<td>${presentation.quantity}</td>
										<td>${presentation.presentation}</td>
										<td>${presentation.total}</td>
									</tr>
								</g:each>
								<tr>
									<td><b><ps:itemsQuantity items="${sales[item]}"/><b></td>
									<td></td>
									<td><b><ps:itemsTotal items="${sales[item]}"/></b></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</g:each>
		</g:else>
	</g:if>
	<g:else>
		<h4>Nada que mostrar...</h4>
	</g:else>
</body>
</html>