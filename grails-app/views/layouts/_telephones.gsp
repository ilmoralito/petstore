<table class="table table-striped">
<tbody>
	<g:each in="${telephones}" var="telephone" status="index">
		<tr>
			<td>${telephone.telephoneCarrier}</td>
			<td>${telephone.number}</td>
			<td width="1"><g:link event="deleteTelephone" params="[index:index]"><span class="glyphicon glyphicon-trash btn-sm"></span></g:link></td>
		</tr>
	</g:each>
</tbody>
</table>