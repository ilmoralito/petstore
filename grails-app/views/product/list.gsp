<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Productos</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<g:set var="presentations" value="${grailsApplication.config.ni.org.petstore.presentations}"/>
	<div class="row">
		<div class="col-md-9">
			<g:if test="${products}">
				<h4>${provider}</h4>
				<table class="table table-hover">
					<thead>
						<th>Productos</th>
						<th width="1"></th>
						<th width="1"></th>
					</thead>
					<tbody>
						<g:each in="${products}" var="product">
							<g:set var="notUsedPresentations" value="${presentations - product?.presentations?.presentation}"/>

							<g:if test="${product?.id?.toInteger() == params?.id?.toInteger()}">
								<tr>
									<td colspan="3" style="background-color:#F3F3F3;">
										<g:render template="/presentation/toolbar" model="[product:product]"/>
										<g:if test="${params?.presentationId}">
											<g:form controller="presentation" action="update">
												<g:render template="/presentation/form" model="[notUsedPresentations:notUsedPresentations]"/>
												<g:submitButton name="send" value="Agregar" class="btn btn-primary"/>
											</g:form>
										</g:if>
										<g:else>
											<div class="row">
												<g:if test="${product?.presentations}">
													<div class="col-md-9">
														<table class="table">
															<thead>
																<th width="5">Presentacion</th>
																<th width="5">Precio</th>
																<th>Cantidad</th>
																<th width="1"></th>
															</thead>
															<tbody>
																<g:each in="${product?.presentations}" var="presentation">
																	<tr>
																		<td><g:link controller="presentation" action="edit" params="[id:presentation?.id, productId:params?.id, providerId:params?.providerId]">${presentation}</g:link></td>
																		<td>${presentation?.price}</td>
																		<td>${presentation?.quantity}</td>
																		<td><g:link controller="presentation" action="delete" params="[id:presentation?.id, productId:params?.id, providerId:params?.providerId]"><span class="glyphicon glyphicon-trash"></span></g:link></td>
																	</tr>
																</g:each>
															</tbody>
														</table>
													</div>
													<div class="col-md-3">
														<g:if test="${notUsedPresentations}">
															<g:form controller="presentation" action="save" autocomplete="off">
																<g:render template="/presentation/form" model="[notUsedPresentations:notUsedPresentations]"/>
																<g:submitButton name="send" value="Agregar" class="btn btn-primary btn-block"/>
															</g:form>
														</g:if>
													</div>
												</g:if>
												<g:else>
													<div class="col-md-12">
														<g:form controller="presentation" action="save" autocomplete="off">
															<g:render template="/presentation/form" model="[presentations:presentations, product:product]"/>
															<g:submitButton name="send" value="Agregar" class="btn btn-primary"/>
														</g:form>
													</div>
												</g:else>
										</div>
									</g:else>
									</td>
								</tr>
							</g:if>
							<g:else>
								<tr>
									<td><g:link action="list" params="[id:product.id, providerId:params?.providerId]">${product}</g:link></td>
									<td><g:link action="edit" params="[id:product.id, providerId:params?.providerId]"><span class="glyphicon glyphicon-pencil"></span></g:link></td>
									<td><g:link action="delete" id="${product.id}"><span class="glyphicon glyphicon-trash"></span></g:link></td>
								</tr>
							</g:else>
						</g:each>
					</tbody>
				</table>
			</g:if>
			<g:else>
				<div class="alert alert-info">Nada que mostrar</div>
			</g:else>
		</div>
		<div class="col-md-3">
			<h4>Agregar producto</h4>
			<g:form action="save" autocomplete="off">
				<g:hiddenField name="providerId" value="${params?.providerId}"/>
				<div class="form-group">
					<g:textField name="name" class="form-control" placeholder="Nombre del producto"/>
				</div>
				<g:submitButton name="send" value="Agregar" class="btn btn-primary btn-block"/>
			</g:form>
		</div>
	</div>
</body>
</html>