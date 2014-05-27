<g:hiddenField name="id" value="${params?.id}"/>
<g:hiddenField name="providerId" value="${params?.providerId}"/>
<g:if test="${actionName != 'edit'}">
	<div class="form-group">
		<g:select name="presentation" from="${notUsedPresentations}" value="${presentation?.presentation}" class="form-control"/>
	</div>
</g:if>
<div class="form-group">
	<g:select name="measure" from="${}" value="${presentation?.measure}" class="form-control"/>
</div>
<div class="form-group">
	<g:textField name="price" class="form-control" value="${presentation?.price}" placeholder="Precio"/>
</div>
<div class="form-group">
	<g:textField name="quantity" class="form-control" value="${presentation?.quantity}" placeholder="Cantidad"/>
</div>