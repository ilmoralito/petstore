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
				<g:each in="${sales}" var="sale">
					<h4>
						<g:link action="show" params="[id:sale.id, status:params?.status]">
							Factura #${sale.invoice}, ${sale.dateCreated.format("yyyy-MM-dd HH:mm:ss")}
						</g:link>
					</h4>
					<div class="row">
						<div class="col-md-${sale.status && !sale.payments ? '12' : '6'}">
							<g:render template="items" model="[items:sale.items]"/>
						</div>
						<g:if test="${!params.status.toBoolean() || sale.payments}">
						<div class="col-md-6">
							<table class="table table-striped table-hover">
								<thead>
									<th>Fecha</th>
									<th>Recibo</th>
									<th width="1">Abono</th>
									<!--Display only in credit-->
									<g:if test="${!params?.status?.toBoolean()}">
										<th width="1"></th>
									</g:if>
									<th width="1"></th>
								</thead>
								<tbody>
									<g:each in="${sale.payments}" var="payment">
										<tr>
											<td>${payment.dateCreated.format("yyyy-MM-dd")}</td>
											<td>${payment.receipt}</td>
											<td>${payment.payment}</td>
											<!--Display only in credit sale-->
											<g:if test="${!params?.status?.toBoolean()}">
												<td>
												  <g:link action="deletePayment" params="[paymentId:payment.id, saleId:sale.id]">
												    <span style="padding:0;" class="glyphicon glyphicon-trash btn-sm"></span>
												  </g:link>
												</td>
											</g:if>
											<td>
												<g:link controller="payment" action="show" id="${payment.id}">
											    <span style="padding:0;" class="glyphicon glyphicon-print btn-sm"></span>
											  </g:link>
											</td>
										</tr>
									</g:each>
									<g:if test="${!sale.status}">
										<tr>
											<td>Saldo</td>
											<td colspan="4"><div class="pull-right">${sale?.items?.total?.sum() - (sale?.payments?.payment?.sum() ?: 0)}</div></td>
										</tr>
									</g:if>
								</tbody>
							</table>
							<g:if test="${!sale.status}">
								<g:form action="pay" autocomplete="off">
									<g:hiddenField name="clientId" value="${params?.clientId}"/>
									<g:hiddenField name="saleId" value="${sale.id}"/>
									<g:hiddenField name="status" value="${params?.status}"/>

								  <div class="form-group">
								    <label class="sr-only" for="receipt">Recibo</label>
										<g:textField name="receipt" class="form-control input-sm" placeholder="Numero de recibo"/>
								  </div>
									<div class="form-group">
								    <label class="sr-only" for="payment">Abono</label>
										<g:textField name="payment" class="form-control input-sm" placeholder="Abono"/>
								  </div>
									<g:submitButton name="send" value="Abonar" class="btn btn-default btn-xs"/>
								</g:form>
								<g:link action="payment" params="[saleId:sale.id]" class="btn btn-default btn-sm">Abonar</g:link>
							</g:if>
						</div>
						</g:if>
					</div>
				</g:each>
			</g:if>
		</div>
		<div class="col-md-3">
			<g:render template="tabs"/>
			<g:if test="${clients}">
				<g:form action="list">
					<div class="form-group">
						<g:select name="clientId" from="${clients}" optionKey="id" value="${params?.clientId}" class="form-control"/>
					</div>
					<div class="form-group">
						<g:radioGroup name="status" labels="['Contado', 'Credito']" values="[true, false]" value="${params?.status ?: true}">
							${it.radio} <g:message code="${it.label}"/>
						</g:radioGroup>
					</div>
					<g:submitButton name="send" value="Listar" class="btn btn-block btn-primary"/>
				</g:form>
			</g:if>
			<g:else>
				No existen ventas registradas aun en el sistema
			</g:else>
		</div>
	</div>
</body>
</html>