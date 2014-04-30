<div class="row">
	<div class="col-md-4">
		<div class="form-group">
			<label for="fullName">Nombre completo</label>
			<g:textField name="fullName" value="${client?.fullName}" class="form-control" autofocus="true"/>
		</div>
		<div class="form-group">
			<label for="storeName">Nombre de la tienda</label>
			<g:textField name="storeName" value="${client?.storeName}" class="form-control"/>
		</div>
		<div class="form-group">
			<label for="address">Direccion</label>
			<g:textField name="address" value="${client?.address}" class="form-control"/>
		</div>
		<div class="form-group">
			<label for="city">Ciudad</label>
			<g:select name="city" from="${client?.constraints?.city?.inList}" value="${client?.city}" class="form-control"/>
		</div>
		<div class="form-group">
			<label for="telephone">Telefono</label>
			<g:textField name="telephone" value="${client?.telephone}" class="form-control"/>
		</div>
		<div class="form-group">
			<label for="email">Email</label>
			<g:textField name="email" type="email" value="${client?.email}" class="form-control"/>
		</div>
	</div>
</div>