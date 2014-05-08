<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Ventas</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<g:render template="toolbar"/>
	<div class="row">
		<div class="col-md-10">
			<g:if test="${results}">

			</g:if>
			<g:else>
				<h1>...</h1>
			</g:else>
		</div>
		<div class="col-md-2">
			<h4>Filtrar</h4>
			<g:form action="search">
				<div class="form-group">
					<g:textField name="from" value="${params?.from}" class="form-control" placeholder="Desde"/>
				</div>
				<div class="form-group">
					<g:textField name="to" value="${params?.to}" class="form-control" placeholder="Hasta"/>
				</div>
				<g:submitButton name="send" value="Buscar" class="btn btn-default"/>
			</g:form>
		</div>
	</div>
</body>
</html>