<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Ventas</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<g:render template="toolbar"/>

	<g:if test="${items}">
		<h4>${client.fullName.toUpperCase()}</h4>
		<h5>${params.from} al ${params.to}</h5>
		<table class="table table-hover">
			<thead>
				<th>Producto</th>
			</thead>
			<tbody>
				<g:each in="${itemsByProduct.keySet()}" var="item">
					<tr class="info">
						<td>${item}</td>
					</tr>
					<tr>
						<td>
							<table class="table table-hover table-condensed" style="margin:0; padding:0;">
								<thead>
									<th width="1"></th>
									<th width="5">Presentacion</th>
									<th>Total</th>
								</thead>
								<tbody>
									<g:each in="${itemsByProduct[item]}" var="res">
										<tr>
											<td>${res.quantity}</td>
											<td>${res.presentation}</td>
											<td>${res.total}</td>
										</tr>
									</g:each>
									<tr>
										<td><ps:itemsQuantity items="${itemsByProduct[item]}"/></td>
										<td></td>
										<td><ps:itemsTotal items="${itemsByProduct[item]}"/></td>
									</tr>
								</tbody>
							</table>
						</td>
					</tr>
				</g:each>
			</tbody>
		</table>
	</g:if>
	<g:else>
		<h4>...Nada que mostrar en fechas entre el ${from} y el ${to} ...</h4>
	</g:else>
</body>
</html>