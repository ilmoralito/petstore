<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Presentacion medida, cantidad, precio</title>
	<r:require modules="bootstrap-css, appJs"/>
</head>
<body>
	<g:link event="goBackToAdminPresentation" class="pull-right">Regresar</g:link>
	<h4>${product}</h4>
	<table class="table table-hover">
		<tbody>
			<g:each in="${product?.presentations}" var="presentation">
				<tr>
					<td class="presentations">${presentation}</td>
					<td width="1"><g:link event="deletePresentation" params="[presentation:presentation]"><span class="glyphicon glyphicon-trash"></span></g:link></td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="row">
							<div class="col-md-9">
								<g:if test="${presentation?.details}">
									<table class="table table-striped table-hover">
										<thead>
											<th>Medida</th>
											<th width="1">Cantidad</th>
											<th width="1">Precio</th>
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
					</td>
				</tr>
			</g:each>
		</tbody>
	</table>
</body>
</html>