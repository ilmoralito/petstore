<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Presentacion medida, cantidad, precio</title>
	<r:require modules="bootstrap-css, appJs"/>
</head>
<body>
	<g:link event="goBackToAdminPresentation" class="pull-right btn btn-default btn-sm">Regresar a ${product}</g:link>
	<br>
	<g:each in="${product?.presentations}" var="presentation">
		<br>
		<div class="row">
			<div class="col-md-9">
				<div class="row">
					<div class="col-md-6">
						${presentation}
					</div>
					<div class="col-md-6">
						<g:link event="deletePresentation" params="[presentation:presentation]" class="btn btn-default btn-sm pull-right"><span class="glyphicon glyphicon-trash"></span></g:link>
					</div>
				</div>
				<g:if test="${presentation?.details}">
					<table class="table table-striped">
						<thead>
							<th style="width:33%;">Medida</th>
							<th style="width:33%;">Cantidad</th>
							<th style="width:34%;">Precio</th>
							<th width="1"></th>
						</thead>
						<tbody>
							<g:each in="${presentation.details}" var="detail">
								<tr>
									<td><g:link event="editPresentationDetail" id="${detail.id}">${detail.measure}</g:link></td>
									<td>${detail.quantity}</td>
									<td>${detail.price}</td>
									<td><g:link event="deleteDetail" params="[id:detail.id, presentation:presentation]" id="${detail.id}"><span class="glyphicon glyphicon-trash"></span></g:link></td>
								</tr>
							</g:each>
						</tbody>
					</table>
				</g:if>
			</div>
			<div class="col-md-3">
				<g:set var="availableMeasure" value="${grailsApplication.config.ni.org.petstore.presentations[presentation.presentation] - presentation?.details?.measure}"/>
				<g:if test="${availableMeasure}">
					<g:form>
						<g:hiddenField name="presentation" value="${presentation}"/>
						<g:render template="/presentation/presentations/form"/>

						<g:submitButton name="confirm" value="Confirmar" class="btn btn-primary btn-block"/>
					</g:form>
				</g:if>
				<g:else>
					<div class="alert alert-info">Sin unidades de medida</div>
				</g:else>
			</div>
		</div>
	</g:each>
</body>
</html>