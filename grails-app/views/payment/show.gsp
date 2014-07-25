<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Pago</title>
	<r:require modules="bootstrap-css, app, printInvoice"/>
</head>
<body>
	<div class="row toolbar">
		<div class="col-md-12">
			<a href="@" onclick="window.print()" class="btn btn-default btn-sm pull-right"><span class="glyphicon glyphicon-print"></span></a>
		</div>
	</div>
	<h4>Recibo oficial de caja</h4>
	<div class="row">
		<div class="col-md-12"><strong class="pull-right">${payment.dateCreated.format("yyyy-MM-dd")}</strong></div>
	</div>

	<table class="table table-bordered">
		<tbody>
			<tr>
				<td style="width:25%;">Recibimos de</td>
				<td>${payment.sale.client}</td>
			</tr>
			<tr>
				<td style="width:25%;">La cantidad de</td>
				<td>${payment.payment} cordobas</td>
			</tr>
			<tr>
				<td style="width:25%;">Direccion</td>
				<td>${payment.sale.client.address}</td>
			</tr>
			<tr>
				<td style="width:25%;">Concepto de pago</td>
				<td>Abono por compra de ${payment.sale.items.total.sum()} en productos ${payment.sale.items.product}</td>
			</tr>
			<tr>
				<td>Saldo</td>
				<td>${payment.sale.items.total.sum() - payment.payment}</td>
			</tr>
		</tbody>
	</table>
</body>
</html>