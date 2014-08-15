<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Ventas</title>
	<r:require modules="bootstrap-css, app, printInvoice"/>
</head>
<body>
	<div class="row toolbar">
		<div class="col-md-12">
			<div class="pull-right">
				<a href="#" class="btn btn-default btn-sm" onclick="window.print()"><span class="glyphicon glyphicon-print"></span></a>
				<g:if test="${!sale?.payments}">
					<g:link action="changeSaleStatus" id="${params?.id}" class="btn btn-default btn-sm"><ps:saleStatus status="${sale.status}"/></g:link>
				</g:if>
			</div>
		</div>
	</div>
	<br>

	<div class="row">
		<div class="col-md-3">
			<g:img dir="images" file="grails_logo.png"/>
			<p>Ruc 2810412840012F</p>
		</div>
		<div class="col-md-6">
			<div style="text-align:center;">
				<h2 style="margin-top:0;">PROVETNIC, S.A</h2>
				<p>Productos Veterinarios de Nicaragua</p>
				<p>Plaza el Sol 3c. al sur, 35 vrs. arriba. Managua, Nicaragua</p>
				<p>Telf.: 2231-4129 - Cel: 8614 4136 / 8774 4597</p>
				<p>FACTURA</p>
			</div>
		</div>
		<div class="col-md-3">
			<div class="pull-right">
				<h4 style="margin-top:0;">${sale.dateCreated.format("yyyy-MM-dd")}</h4>
				<h4>#${sale.invoice}</h4>
				<h4>${sale.client.id}</h4>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-md-12">
			<div class="pull-right">
				<label class="checkbox-inline">
					<input type="checkbox" ${sale.status ? 'checked' : ''} disabled="true">
					Contado
				</label>

				<label class="checkbox-inline">
					Credito
					<input type="checkbox" ${!sale.status ? 'checked' : ''} disabled="true">
				</label>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-md-6"><span class="pull-left"><b>Cliente:</b>${sale.client.getClientAndStoreInfo()}</span></div>
		<div class="col-md-6"><span class="pull-right"><b>Dir:</b>${sale.client.getFullAddress()}</span></div>
	</div>

	<br>
	<table class="table table-striped table-bordered">
		<thead>
			<th width="1">Cantidad</th>
			<th colspan="3">Descripcion</th>
			<th width="1">P.Unit</th>
			<th width="1">Total</th>
		</thead>
		<tbody>
			<g:each in="${sale.items}" var="item">
				<g:set var="presentation" value="${item.presentation.toString()}"/>
				<g:set var="measure" value="${item.measure.toString()}"/>
				<tr>
					<td>${item.quantity}</td>
					<td colspan="3">${item.presentation} ${item.measure}</td>
					<td>${item.product.presentations.find { it.presentation == presentation }.details.find{ it.measure == measure }.price}</td>
					<td>${item.total}</td>
				</tr>
			</g:each>
			<tr>
				<td>
					<div class="info">
						<p>NO ACEPTAMOS DEVOLUCIONES</p>
						<p>FAVOR EMITIR CHECQUE A NOMBRE DE PROVETNIC, S.A</p>
					</div>
				</td>
				<td style="width:30%;">
					<div class="info" style="text-align:justify;">
						Pagare a la orden de: PROVETNIC, S.A en la fecha de vencimiento.
						En caso de faltar en pago en la fecha indicada incurrire(mos)
						en mora de 3% mensual sin nececidad de requerimiento o
						intimidacion judicial o extrajudicial, y desde que la mora principie
						y hasta el total y efectivo pago reconocere(mos) a los acreedores,
						intereses moratorios al tipo legal sobre la cantidad que estuviese
						pendiente de pago.
					</div>
				</td>
				<td style="padding:0;">
					<br>
					<br>
					<hr>
					<p class="info" style="position:relative; top:0;">ENTREGE CONFORME</p>
				</td>
				<td style="padding:0;">
					<br>
					<br>
					<hr>
					<p class="info">RECIBI CONFORME</p>
				</td>
				<td></td>
				<td>${sale.items.total.sum()}</td>
			</tr>
		</tbody>
	</table>
</body>
</html>