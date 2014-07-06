<div class="row">
	<div class="col-md-12">
		<g:form action="list" class="form-inline pull-right" role="form">
			<g:textField name="query" class="form-control" value="${params?.query}"/>
			<g:submitButton name="send" value="Buscar" class="btn btn-default"/>
			<g:link controller="${controllerName}" action="${controllerName == 'client' ? 'createClient' : 'create'}" class="btn btn-default">Crear</g:link>
		</g:form>
	</div>
</div>
<br>