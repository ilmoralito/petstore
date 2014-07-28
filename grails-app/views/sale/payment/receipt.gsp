<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="receipt">
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<!--toolbar-->
	<div class="row">
		<div class="col-md-12">
			<g:link action="list" params="[status:sale.status, clientId:sale.clientId]" class="btn btn-default btn-sm pull-right">Regresar</g:link>
		</div>
	</div>

	<h4>Factura #${sale.invoice}</h4>
	<div class="row">
		<div class="col-md-6">
			<g:form>
				<div class="form-group">
					<g:textField name="receipt" class="form-control" placeholder="# Recibo" autofocus="true"/>
				</div>
				<div class="form-group">
					<g:textField name="payment" class="form-control" placeholder="Efectivo"/>
				</div>
				<div class="form-group">
					<input type="number" name="discount" class="form-control" min="1" max="100" placeholder="Descuento">
				</div>
				<g:submitButton name="confirm" class="btn btn-primary btn-sm" value="Confirmar"/>
			</g:form>		
		</div>
		<div class="col-md-6">
			<g:form>
				<div class="form-group">
					<g:textField name="checkNumber" class="form-control" placeholder="# cheque"/>
				</div>
				<div class="form-group">
					<g:select name="banc" from="${bancs}" class="form-control"/>
				</div>
				<div class="form-group">
					<g:textField name="checkValue" class="form-control" placeholder="Cantidad"/>
				</div>
				<g:submitButton name="addCheck" class="btn btn-primary btn-sm" value="Agregra cheque"/>
			</g:form>

			<g:if test="${checks}">
				<table class="table table-striped">
					<thead>
						<th width="1">#</th>
						<th>Banco</th>
						<th>Valor</th>
						<th width="1"></th>
					</thead>
					<tbody>
						<g:each in="${checks}" var="check" status="index">
							<tr>
								<td>${check.checkNumber}</td>
								<td>${check.banc}</td>
								<td>${check.checkValue}</td>
								<td>
									<g:link event="deleteCheck" params="[index:index]">
										<span class="glyphicon glyphicon-trash btn-sm"></span>
									</g:link>
								</td>
							</tr>
						</g:each>
					</tbody>
				</table>
			</g:if>
		</div>
	</div>
</body>
</html>