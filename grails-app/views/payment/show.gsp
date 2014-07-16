<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Pago</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<div class="row">
		<div class="col-md-12">
			<a href="" class="btn btn-default btn-sm pull-right"><span class="glyphicon glyphicon-print"></span></a>
		</div>
	</div>
	<h4>Datos de abono</h4>
	<table class="table">
		<tbody>
			<tr>
				<td>Cliente</td>
				<td>${payment.sale.client}</td>
			</tr>
			<tr>
				<td>Fecha</td>
				<td>${payment.dateCreated}</td>
			</tr>
			<tr>
				<td>Razon</td>
				<td>Compra con factura: ${payment.sale.invoice}</td>
			</tr>
			<tr>
				<td>Abono</td>
				<td>${payment.payment}</td>
			</tr>
			<tr>
				<td>Saldo inicial</td>
				<td>${payment.sale.items.total.sum()}</td>
			</tr>
			<tr>
				<td>Saldo</td>
				<td>${payment.sale.items.total.sum() - payment.payment}</td>
			</tr>
		</tbody>
	</table>
</body>
</html>