<div class="panel panel-default">
	<div class="panel-heading">
		Pocas existencias
	</div>
	<div class="panel-body">
		<g:each in="${presentationsGroupedByProduct.keySet()}" var="product">
			<div class="row">
				<div class="col-md-12">${product.name.toUpperCase()}</div>
			</div>
			<g:each in="${presentationsGroupedByProduct[product]}" var="presentation">
				<div class="row">
					<div class="col-md-6">
						<g:link controller="presentation" action="edit" params="[id:presentation?.id, productId:presentation?.product?.id, providerId:presentation?.product?.provider?.id]">
							${presentation.presentation}
						</g:link>
					</div>
					<div class="col-md-6">${presentation.quantity}</div>
				</div>
			</g:each>
		</g:each>
	</div>
</div>