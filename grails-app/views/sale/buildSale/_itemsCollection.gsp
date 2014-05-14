<g:if test="${session.itemsCollection}">
	<div class="row">
		<div class="col-md-6">CLIENTE: <b>${client.fullName.toUpperCase()}</b></div>
		<div class="col-md-6"><span class="pull-right">FECHA: <b>${new Date().format("yyyy-MM-dd")}</b></span></div>
	</div>
	<br>
	<g:form>
		<table class="table table-hover">
			<thead>
				<th width="1"></th>
				<th width="5">Producto</th>
				<th width="15">Presentacion</th>
				<th>Total</th>
				<th width="1"></th>
			</thead>
			<tbody>
				<g:each in="${session.itemsCollection}" var="item" status="i">
					<tr>
						<td>${item.quantity}</td>
						<td>${item.product}</td>
						<td>${item.presentation}</td>
						<td>${item.total}</td>
						<td><g:link action="buildSale" event="removeItem" params="[index:i]"><span class="glyphicon glyphicon-trash"></span></g:link></td>
					</tr>
				</g:each>
				<tr>
					<td><b><ps:itemsQuantity/></b></td>
					<td></td>
					<td></td>
					<td><b><ps:itemsTotal/></b></td>
					<td></td>
				</tr>
			</tbody>
		</table>
		<g:submitButton name="confirmSale" value="Confirmar" class="btn btn-default"/>
	</g:form>
</g:if>
<g:else>
	<h1>...</h1>
</g:else>