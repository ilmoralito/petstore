<nav>
	<ul class="nav nav-pills nav-stacked">
		<li class="${controllerName == 'user' ? 'active' : ''}"><g:link controller="user">Perfil</g:link></li>
		<li class="${controllerName == 'client' ? 'active' : ''}"><g:link controller="client">Clientes</g:link></li>
		<li class="${controllerName == 'provider' || controllerName == 'product' || controllerName == 'presentation' ? 'active' : ''}"><g:link controller="provider">Proveedores</g:link></li>
		<li class="${controllerName == 'sale' && actionName == 'buildSale' ? 'active' : ''}"><g:link controller="sale" action="buildSale">Ventas</g:link></li>
		<li class="${controllerName == 'sale' && actionName in ['list'] ? 'active' : ''}"><g:link controller="sale" action="list">Historial de ventas</g:link></li>
		<li><g:link controller="logout">Salir</g:link></li>
	</ul>
</nav>