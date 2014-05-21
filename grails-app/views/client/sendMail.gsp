<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Enviar correo</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<g:render template="navbar"/>
	<div class="row">
		<div class="col-md-6">
			<g:form action="sendMail">
				<g:hiddenField name="id" value="${client.id}"/>
				<div class="form-group">
					<div class="form-control"><b>De</b> ${grailsApplication.config.ni.org.petstore.owner.email}</div>
				</div>
				<div class="form-group">
					<g:each in="${client?.emails}" var="email">
						<div class="checkbox">
							<label>
								<g:checkBox name="emails" value="${email}" checked="false"/> ${email}
							</label>
						</div>
					</g:each>
				</div>
				<div class="form-group">
					<g:textField name="subject" class="form-control" placeholder="Asunto"/>
				</div>
				<div class="form-group">
					<g:textArea name="body" class="form-control" placeholder="Mensaje"/>
				</div>
				<g:submitButton name="send" value="Enviar" class="btn btn-primary"/>
			</g:form>
		</div>
	</div>
</body>
</html>