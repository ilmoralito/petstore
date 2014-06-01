<div class="form-group">
	<g:if test="${!flag}">
		<g:select name="measure" from="${availableMeasure}" class="form-control"/>
	</g:if>
	<g:else>
		<g:hiddenField name="measure" value="${detail?.measure}"/>
		<span class="form-control">${detail?.measure}</span>
	</g:else>
</div>
<div class="form-group">
	<g:textField name="quantity" value="${detail?.quantity}" class="form-control" placeholder="Cantidad"/>
</div>
<div class="form-group">
	<g:textField name="price" value="${detail?.price}" class="form-control" placeholder="Precio"/>
</div>