<g:set var="notUsedPresentations" value="${presentations - product?.presentations?.presentation}"/>
<g:if test="${notUsedPresentations}">
	<g:hiddenField name="id" value="${params?.id}"/>
	<g:hiddenField name="providerId" value="${params?.providerId}"/>
	<div class="form-group">
		<g:select name="presentation" from="${notUsedPresentations}" class="form-control"/>
	</div>
	<div class="form-group">
		<g:textField name="price" class="form-control" placeholder="Precio"/>
	</div>
	<div class="form-group">
		<g:textField name="quantity" class="form-control" placeholder="Cantidad"/>
	</div>
</g:if>
<g:else>
	<h1>...</h1>
</g:else>	