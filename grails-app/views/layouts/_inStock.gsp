<g:each in="${results}" var="k">
	<h4>${k.key}</h4>
	<g:each in="${k.value}" var="v">
		<table class="table table-striped">
			<tbody>
				<g:each in="${v.details.findAll { it.quantity <= 10 }}" var="l">
					<tr>
						<td>${l.quantity} ${v} ${l}</td>
					</tr>
				</g:each>
			</tbody>
		</table>
	</g:each>
</g:each>