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
				<g:each in="${sales}" var="sale">
					<h4>${sale.dateCreated.format("yyyy-MM-dd HH:mm:ss")}</h4>

					<div class="row">
						<div class="col-md-8">
							<table class="table table-striped">
								<thead>
									<th>Compra</th>
									<th width="1">Total</th>
								</thead>
								<tbody>
									<g:each in="${sale.items}" var="item">
										<tr>
										<td>${item.quantity} ${item.presentation} ${item.measure}</td>
											<td>${item.total}</td>
										</tr>
									</g:each>
									<tr>
										<td></td>
										<td>${sale.items.total.sum()}</td>
									</tr>
								</tbody>
							</table>
						</div>
						<div class="col-md-4">
							<table class="table table-striped">
								<thead>
									<th>Fecha abono</th>
									<th width="1">Abono</th>
									<th width="1"></th>
								</thead>
								<tbody>
									<g:each in="${sale.payments}" var="payment">
										<tr>
											<td>${payment.dateCreated.format("yyyy-MM-dd")}</td>
											<td>${payment.payment}</td>
											<td><g:link><span class="glyphicon glyphicon-trash"></span></g:link></td>
										</tr>
									</g:each>
									<g:if test="${!sale.status}">
										<tr>
											<td>Pendiente</td>
											<td>${sale.items.total.sum() - sale.payments.payment.sum()}</td>
											<td></td>
										</tr>
									</g:if>
								</tbody>
							</table>
							<g:if test="${!sale.status}">
								<g:form action="pay" autocomplete="off">
									<g:hiddenField name="clientId" value="${params?.clientId}"/>
									<g:hiddenField name="status" value="${params?.status}"/>
									<g:hiddenField name="saleId" value="${sale.id}"/>

									<div class="form-group">
								    <label class="sr-only" for="payment">Abono</label>
										<g:textField name="payment" class="form-control input-sm"/>
								  </div>
									<g:submitButton name="send" value="Abonar" class="btn btn-default btn-xs"/>
								</g:form>
							</g:if>
						</div>
					</div>
				</g:each>
			</g:if>
		</div>
		<div class="col-md-3">
			<g:render template="tabs"/>
			<g:form action="list">
				<div class="form-group">
					<label for="client">Cliente</label>
					<g:select name="clientId" from="${clients}" optionKey="id" value="${params?.client}" class="form-control"/>
				</div>
				<div class="form-group">
					<label for="status">Tipo de compra</label>
					<br>
					<g:radioGroup name="status" labels="['Cancelado', 'Credito']" values="[true, false]" value="${params?.status ?: true}">
						${it.radio} <g:message code="${it.label}"/>
					</g:radioGroup>
				</div>
				<g:submitButton name="send" value="Listar" class="btn btn-primary"/>
			</g:form>
		</div>
	</div>
</body>
</html>