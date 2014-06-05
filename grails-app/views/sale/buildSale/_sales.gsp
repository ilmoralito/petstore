<g:if test="${saleDetail}">
	<h4>${client}</h4>
	<h5>${new Date().format("yyyy-MM-dd")}</h5>
	<table class="table">
		<thead>
			<th>Producto</th>
		</thead>
		<tbody>
			<g:each in="${saleDetail.keySet()}" var="product" status="i">
				<tr>
					<td>${product}</td>
				</tr>
				<tr>
					<td style="padding:0;">
						<table class="table table-hover" style="margin-bottom:0;">
							<tbody>
								<g:each in="${saleDetail[product]}" var="detail">
									<tr>
										<td>${detail.quantity} <b>${detail.presentation}</b> de ${detail.measure}</td>
										<td width="1">${detail.total}</td>
										<td width="1"><g:link event="deleteDetail"><span class="glyphicon glyphicon-trash"></span></g:link></td>
									</tr>
								</g:each>
							</tbody>
						</table>
					</td>
				</tr>
			</g:each>
			<tr>
				<td>TOTAL <span class="pull-right">${sales.total.sum()}</span></td>
			</tr>
		</tbody>
	</table>
	<g:submitButton name="confirm" value="Confirmar" class="btn btn-primary"/>
</g:if>
<g:else>
	<h1>...</h1>
</g:else>