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
				<td style="width:16%;">Recibimos de</td>
				<td colspan="3">${payment.sale.client.storeName}, ${payment.sale.client}</td>
			</tr>
			<tr>
				<td style="width:16%;">La cantidad de</td>
				<td colspan="3">${payment.payment} cordobas</td>
			</tr>
			<tr>
				<td>Direccion</td>
				<td>${payment.sale.client.address}</td>
				<td>Codigo</td>
				<td>${payment.sale.client.id}</td>
			</tr>
			<tr>
				<td style="width:16%;">Concepto de pago</td>
				<td colspan="3">
					<g:if test="${payment.sale.getSaldo(payment)}">
						Abono
					</g:if>
					<g:else>
						Abono y cancelacion de factura #${payment.sale}
					</g:else>
				</td>
			</tr>
		</tbody>
	</table>

	<g:if test="${payment.checks}">
		<h4>Cheques</h4>
		<table class="table table-bordered">
			<thead>
				<th style="width:16%;">Cheque</th>
				<th>Banco</th>
				<th>Valor</th>
			</thead>
			<tbody>
				<g:each in="${payment.checks}" var="check">
					<tr>
						<td>${check.checkNumber}</td>
						<td>${check.banc}</td>
						<td>${check.checkValue}</td>
					</tr>
				</g:each>
				<tr>
					<td></td>
					<td colspan="2">258</td>
				</tr>
			</tbody>
		</table>
	</g:if>
</body>
</html>