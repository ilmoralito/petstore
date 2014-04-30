<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title><g:layoutTitle default="petstore app"/></title>
	<r:layoutResources/>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-2">
				<g:render template="/layouts/sidebar"/>
			</div>
			<div class="col-md-10">
				<g:layoutBody/>
				<g:if test="${flash.message}">
					<br><div class="alert alert-info">${flash.message}</div>
				</g:if>
			</div>
		</div>
	</div>
	<r:layoutResources/>
</body>
</html>
