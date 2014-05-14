<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Agregar cantidad</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<g:render template="toolbar"/>
	<div class="row">
		<div class="col-md-9">
			<g:render template="buildSale/itemsCollection"/>
		</div>
		<div class="col-md-3">
			<g:form>
				<div class="form-group">
					<label for="quantity">Cantidad</label>
					<input type="number" name="quantity" id="quantity" min="1" max="${presentation?.quantity}" class="form-control" placeholder="${presentation?.quantity} en existencias" required autofocus="true">
				</div>
				<g:submitButton name="confirm" value="Confirmar" class="btn btn-default"/>
				<g:submitButton name="cancel" value="Regresar" class="btn btn-primary"/>
			</g:form>
		</div>
	</div>
</body>
</html>