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
					<div class="col-md-6"><b>${presentation.presentation}</b></div>
					<div class="col-md-6">${presentation.quantity}</div>
				</div>
			</g:each>
		</g:each>
	</div>
</div>