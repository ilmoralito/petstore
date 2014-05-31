<nav>
	<ul class="nav nav-pills nav-stacked">
		<li class="${controllerName == 'user' ? 'active' : ''}"><g:link controller="user">Perfil</g:link></li>
		<li class="${controllerName == 'client' ? 'active' : ''}"><g:link controller="client">Clientes</g:link></li>
		<li class="${controllerName == 'provider' || controllerName == 'product' || controllerName == 'presentation' ? 'active' : ''}"><g:link controller="provider">Proveedores</g:link></li>
		<li class="${controllerName == 'sale' ? 'active' : ''}"><g:link controller="sale" action="buildSale">Ventas</g:link></li>
		<li><g:link controller="logout">Salir</g:link></li>
		<li></li>
	</ul>
</nav>