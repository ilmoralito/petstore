${detail}
<div class="form-group">
	<g:if test="${!flag}">
		<g:select name="measure" from="${availableMeasure}" value="${d?.measure}" class="form-control"/>
	</g:if>
	<g:else>
		<g:hiddenField name="measure" value="${detail?.measure}"/>
		<span class="form-control">${d?.measure}</span>
	</g:else>
</div>
<div class="form-group">
	<g:textField name="quantity" class="form-control" placeholder="Cantidad"/>
</div>
<div class="form-group">
	<g:textField name="price" class="form-control" placeholder="Precio"/>
</div>