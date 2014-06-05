<g:if test="${saleDetail}">
	<h4>${client}</h4>
	<h5>${new Date().format("yyyy-MM-dd")}</h5>
	<table class="table">
		<thead>
			<th>Producto</th>
		</thead>
		<tbody>
				<g:each in="${saleDetail.keySet()}" var="product">
					<tr>
						<td>${product}</td>
					</tr>
					<tr>
						<td style="padding:0;">
							<table class="table table-hover">
								<thead>
									<th>Presentacion</th>
									<th>Medida</th>
									<th>Cantidad</th>
									<th>Total</th>
									<th width="1"></th>
								</thead>
								<tbody>
									<g:each in="${saleDetail[product]}" var="detail">
										<tr>
											<td>${detail.presentation}</td>
											<td>${detail.measure}</td>
											<td>${detail.quantity}</td>
											<td>${detail.total}</td>
											<td><g:link event="deleteDetail"><span class="glyphicon glyphicon-trash"></span></g:link></td>
										</tr>
									</g:each>
								</tbody>
							</table>
						</td>
					</tr>
				</g:each>
		</tbody>
	</table>
	<g:submitButton name="confirm" value="Confirmar" class="btn btn-primary"/>
</g:if>
<g:else>
	<h1>...</h1>
</g:else>