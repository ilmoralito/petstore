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
		<div class="col-md-12">
			<span class="pull-right">${sale.dateCreated.format("yyyy-MM-dd")}</span>
		</div>
	</div>

	<div class="row">
		<div class="col-md-12">
			<span class="pull-right">#${sale.invoice}</span>
		</div>
	</div>

	<div class="row">
		<div class="col-md-12">
			<span class="pull-right">${sale.client.id}</span>
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
	<table class="table table-striped">
		<thead>
			<th width="1">Cantidad</th>
			<th>Descripcion</th>
			<th width="1">P.Unit</th>
			<th width="1">Total</th>
		</thead>
		<tbody>
			<g:each in="${sale.items}" var="item">
				<g:set var="presentation" value="${item.presentation.toString()}"/>
				<g:set var="measure" value="${item.measure.toString()}"/>
				<tr>
					<td>${item.quantity}</td>
					<td>${item.presentation} ${item.measure}</td>
					<td>${item.product.presentations.find { it.presentation == presentation }.details.find{ it.measure == measure }.price}</td>
					<td>${item.total}</td>
				</tr>
			</g:each>
			<tr>
				<td></td>
				<td></td>
				<td></td>
				<td>${sale.items.total.sum()}</td>
			</tr>
		</tbody>
	</table>
</body>
</html>