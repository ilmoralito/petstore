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
			<a href="#" onclick="window.print()" class="btn btn-default btn-sm pull-right"><span class="glyphicon glyphicon-print"></span></a>
		</div>
	</div>
	<div class="row">
		<div class="col-md-6"><h4>Recibo oficial de caja #${payment.receipt}</h4></div>
		<div class="col-md-6"><h4 class="pull-right">${payment.dateCreated.format("yyyy-MM-dd")}</h4></div>
	</div>

	<table class="table table-bordered">
		<tbody>
			<tr>
				<td style="width:20%;">Recibimos de</td>
				<td colspan="3">${payment.sale.client.storeName}, ${payment.sale.client}</td>
			</tr>
			<tr>
				<td style="width:20%;">La cantidad de</td>
				<td colspan="3">${payment.payment} cordobas</td>
			</tr>
			<tr>
				<td>Direccion</td>
				<td>${payment.sale.client.address}</td>
				<td>Codigo</td>
				<td>${payment.sale.client.id}</td>
			</tr>
			<tr>
				<td style="width:20%;">Concepto de pago</td>
				<td colspan="3">
					<g:if test="${payment.sale.getSaldo(payment)}">
						Abono
					</g:if>
					<g:else>
						Abono y cancelacion de factura #${payment.sale}
					</g:else>
				</td>
			</tr>
			<tr>
				<td>Saldo</td>
				<td colspan="3">${payment.sale.getSaldo(payment)}</td>
			</tr>
		</tbody>
	</table>
</body>
</html>