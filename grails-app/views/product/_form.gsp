<div class="row">
	<div class="col-md-4">
		<div class="form-group">
			<label for="name">Nombre</label>
			<g:textField name="name" value="${product?.name}" class="form-control" autofocus="true"/>
		</div>
		<div class="form-group">
			<label for="price">Precio</label>
			<g:textField name="price" value="${product?.price}" class="form-control"/>
		</div>
	</div>
</div>