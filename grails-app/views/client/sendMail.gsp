<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Enviar correo a ${client}</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<g:render template="navbar"/>
	<div class="row">
		<div class="col-md-6">
			<g:form action="sendMail">
				<div class="form-group">
					<div class="form-control"><b>De</b> ${grailsApplication.config.ni.org.petstore.email}</div>
				</div>
				<div class="form-group">
					<div class="form-control"><b>Para</b> ${client.email}</div>
				</div>
				<div class="form-group">
					<g:textField name="subject" class="form-control" placeholder="Asunto"/>
				</div>
				<div class="form-group">
					<g:textArea name="message" class="form-control" placeholder="Mensaje"/>
				</div>
				<g:submitButton name="send" value="Enviar" class="btn btn-primary"/>
			</g:form>
		</div>
	</div>
</body>
</html>