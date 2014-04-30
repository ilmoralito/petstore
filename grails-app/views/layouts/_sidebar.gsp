<g:link controller="user" class="btn btn-default btn-block">Perfil</g:link>
<br>
<nav>
	<ul class="nav nav-pills nav-stacked">
		<li class="${controllerName == 'client' ? 'active' : ''}"><g:link controller="client">Clientes</g:link></li>
		<li><g:link controller="user">Proveedores</g:link></li>
		<li><g:link controller="logout">Salir</g:link></li>
	</ul>
</nav>