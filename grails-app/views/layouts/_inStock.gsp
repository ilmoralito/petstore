<g:each in="${results}" var="product">
	<h4>${product.key}</h4>
	<g:each in="${product.value}" var="presentation">
		<g:each in="${presentation.details.findAll { it.quantity <= 10 }}" var="detail">
			<p>
				<g:link controller="detail" action="edit" id="${detail.id}">
					${detail.quantity} ${presentation} ${detail}
				</g:link>
			</p>
		</g:each>
	</g:each>
</g:each>