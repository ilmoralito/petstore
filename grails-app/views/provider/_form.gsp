<div class="form-group">
	<g:textField name="name" value="${provider?.name}" class="form-control" placeholder="Nombre proveedor" autofocus="true"/>
</div>
<div class="form-group">
	<g:select name="currencyOfPayment" from="['Cordoba', 'Dolar']" value="${provider?.currencyOfPayment}" noSelection="${['':'Selecciona moneda de pago']}" class="form-control"/>
</div>
<div class="form-group">
	<g:textField name="contactName" value="${provider?.contactName}" placeholder="Nombre contacto" class="form-control"/>
</div>