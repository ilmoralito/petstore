<g:if test="${saleDetail}">
	<h4>${client} <small>${new Date().format("yyyy-MM-dd")}</small></h4>
	<br>
	<table class="table">
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
										<td width="1">
											<g:link event="deleteDetail">
												<span class="glyphicon glyphicon-trash"></span>
											</g:link>
										</td>
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
</g:if>
<g:else>
	<h1>...</h1>
</g:else>