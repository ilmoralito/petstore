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
		<div class="col-md-12">
			<div class="btn-group pull-right">
				<a href="" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-print"></span></a>
				<g:link action="changeSaleStatus" id="${params?.id}" class="btn btn-default btn-sm"><ps:saleStatus status="${sale.status}"/></g:link>
			</div>
		</div>
	</div>
	<br>
	<table class="table">
		<tbody>
			<tr>
				<td style="width:20%;">Cliente</td>
				<td>${sale.client}</td>
			</tr>
			<tr>
				<td>Numero de factura</td>
				<td>${sale.invoice}</td>
			</tr>
			<tr>
				<td>Estado</td>
				<td><ps:saleStatus status="${sale.status}"/></td>
			</tr>
		</tbody>
	</table>
		
	<g:render template="items" model="[items:sale.items]"/>
</body>
</html>