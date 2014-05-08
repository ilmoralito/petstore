<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Ventas</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<g:render template="toolbar"/>
	<div class="row">
		<div class="col-md-4">
			<g:form action="create">
				<div class="form-group">
					<label for="client">Cliente</label>
					<g:select name="client" from="${clients}" class="form-control"/>
				</div>
				<div class="form-group">
					<table class="table table-hover">
						<thead>
							<th>Producto</th>
						</thead>
						<tbody>
							<g:each in="${products}" var="product">
								<tr>
									<td>${product.name.toUpperCase()}</td>
								</tr>
								<tr>
									<td style="background-color:#F3F3F3;">
										<table class="table table-hover table-condensed" style="margin-bottom:0;">
											<thead>
												<th width="1"></th>
												<th>Presentacion</th>
												<th>Cantidad</th>
											</thead>
											<tbody>
												<g:each in="${product?.presentations}" var="presentation">
													<tr>
														<td><g:checkBox name="products"/></td>
														<td>${presentation}</td>
														<td><g:textField name="quantity" class="form-control input-sm" type="number" min="1"/></td>
													</tr>
												</g:each>
											</tbody>
										</table>
									</td>
								</tr>
							</g:each>
						</tbody>
					</table>
				</div>
				<g:submitButton name="send" value="Confirmar" class="btn btn-primary"/>
			</g:form>
		</div>
	</div>
</body>
</html>