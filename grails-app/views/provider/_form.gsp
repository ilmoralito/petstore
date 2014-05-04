<div class="row">
	<div class="col-md-4">
		<div class="form-group">
			<label for="name">Nombre del proveedor</label>
			<g:textField name="name" value="${provider?.name}" class="form-control" autofocus="true"/>
		</div>
		<div class="form-group">
			<label for="contactName">Nombre del contacto</label>
			<g:textField name="contactName" value="${provider?.contactName}" class="form-control"/>
		</div>
		<div class="form-group">
			<label for="contactTelephoneNumber">Telefono de contacto</label>
			<g:textField name="contactTelephoneNumber" value="${provider?.contactTelephoneNumber}" class="form-control"/>
		</div>
	</div>
</div>