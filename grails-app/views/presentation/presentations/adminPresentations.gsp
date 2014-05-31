<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="layout" content="no-main">
	<title>Presentacion</title>
	<r:require modules="bootstrap-css, app"/>
</head>
<body>
	<g:set var="presentations" value="${grailsApplication.config.ni.org.petstore.presentations.keySet()}"/>
	<g:set var="productPresentations" value="${product?.presentations}"/>

	<h4>${provider} / ${product} / Presentaciones</h4>
	<g:form>
		<table class="table">
			<tbody>
				<g:each in="${presentations}" var="presentation">
					<tr>
						<td width="1">
							<g:if test="${presentation in productPresentations.presentation}">
								<g:checkBox name="presentations" value="${presentation}" disabled="true"/>
							</g:if>
							<g:else>
								<g:checkBox name="presentations" value="${presentation}" checked="false"/>
							</g:else>
						</td>
						<td>${presentation}</td>
					</tr>
				</g:each>
			</tbody>
		</table>
		<g:submitButton name="confirm" value="Confirmar" class="btn btn-primary"/>
	</g:form>
</body>
</html>