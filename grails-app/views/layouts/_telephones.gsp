<table class="table table-striped">
<tbody>
	<g:each in="${telephones}" var="telephone" status="index">
		<tr>
			<td>${telephone.telephoneCarrier}</td>
			<td>${telephone.number}</td>
			<td width="1">
				<g:if test="${actionName == 'edit'}">
					<g:link action="deleteTelephone" params="[id:telephone.id]"><span class="glyphicon glyphicon-trash btn-sm"></g:link>
				</g:if>
				<g:else>
					<g:link event="deleteTelephone" params="[index:index]"><span class="glyphicon glyphicon-trash btn-sm"></span></g:link>
				</g:else>
			</td>
		</tr>
	</g:each>
</tbody>
</table>