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
		<div class="col-md-9">
			<g:if test="${sales}">
				<h4>Resultados</h4>
				<table class="table table-hover">
					<thead>
						<th width="1">#</th>
						<th>Cliente</th>
					</thead>
					<tbody>
						<g:each in="${sales}" var="sale" status="i">
							<tr>
								<td>${i + 1}</td>
								<td>
									<g:link action="detail" params="[clientId:sale.client.id, from:params?.from, to:params?.to]">
										${sale}
									</g:link>
								</td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</g:if>
			<g:else>
				<h4>...NADA QUE MOSTRAR...</h4>
			</g:else>
		</div>
		<div class="col-md-3">
			<g:render template="toolbar"/>
			<h4>Filtrar</h4>
			<g:form action="list">
				<div class="form-group">
					<g:textField name="from" value="${params?.from}" class="form-control" placeholder="Desde"/>
				</div>
				<div class="form-group">
					<g:textField name="to" value="${params?.to}" class="form-control" placeholder="Hasta"/>
				</div>
				<g:submitButton name="send" value="Buscar" class="btn btn-primary btn-block"/>
			</g:form>
			<g:if test="${params?.from}">
				<br>
				<div class="panel panel-info">
					<div class="panel-heading">Totales</div>
					<div class="panel-body">
						<div class="row">
							<div class="col-md-6">Dinero</div>
							<div class="col-md-6">aa</div>
						</div>
					</div>
				</div>
			</g:if>
		</div>
	</div>
</body>
</html>