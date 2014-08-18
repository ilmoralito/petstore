<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title><g:layoutTitle default="provetnicsa"/></title>
	<r:layoutResources/>
</head>
<body>
	<div class="container">
		<div class="row toolbar">
			<div class="col-md-12">
				<div class="pull-right">
					<g:link action="list" class="btn btn-default btn-sm">Regresar</g:link>
					<g:if test="${!sale?.payments}">
						<g:link action="changeSaleStatus" id="${params?.id}" class="btn btn-default btn-sm"><ps:saleStatus status="${sale.status}"/></g:link>
					</g:if>
					<a href="#" class="btn btn-default btn-sm" onclick="window.print()"><span class="glyphicon glyphicon-print"></span></a>
				</div>
			</div>
		</div>
		<br>
		<div class="row">
			<div class="col-md-12">
				<g:layoutBody/>
			</div>
		</div>
	</div>
	<r:layoutResources/>
</body>
</html>
