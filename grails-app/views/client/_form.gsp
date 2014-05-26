<div class="row">
	<div class="col-md-4">
		<div class="form-group">
			<label for="fullName">Nombre completo</label>
			<g:textField name="fullName" value="${client?.fullName}" class="form-control" autofocus="true"/>
		</div>
		<div class="form-group">
			<label for="storeName">Nombre de agroservicio</label>
			<g:textField name="storeName" value="${client?.storeName}" class="form-control"/>
		</div>
		<div class="form-group">
			<label for="address">Direccion</label>
			<g:textField name="address" value="${client?.address}" class="form-control"/>
		</div>
		<div class="form-group">
			<label for="city">Ciudad</label>
			<g:select name="city" from="${grailsApplication.config.ni.org.petstore.cities}" value="${client?.city ?: params?.city}" class="form-control"/>
		</div>
	</div>
</div>