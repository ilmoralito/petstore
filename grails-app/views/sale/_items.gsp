<table class="table table-striped">
	<thead>
		<th>Compra</th>
		<th width="1">Total</th>
	</thead>
	<tbody>
		<g:each in="${items}" var="item">
			<tr>
				<td>${item.quantity} ${item.presentation} ${item.measure}</td>
				<td>${item.total}</td>
			</tr>
		</g:each>
		<tr>
			<td></td>
			<td>${items.total.sum()}</td>
		</tr>
	</tbody>
</table>