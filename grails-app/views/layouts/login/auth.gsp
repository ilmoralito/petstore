<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title></title>
	<r:layoutResources/>
</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-4 col-md-offset-4">
				<h1 class="center">${grails.util.Metadata.current.'app.name'} <small>${grails.util.Metadata.current.'app.version'}</small></h1>
				<br>
				<g:layoutBody/>
				<g:if test='${flash.message}'>
					<div class='alert alert-info'>${flash.message}</div>
				</g:if>
			</div>
		</div>
	</div>
	<r:layoutResources/>
</body>
</html>
