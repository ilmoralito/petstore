<ul class="nav nav-tabs">
 	<li class="${actionName == 'show' ? 'active' : ''}"><g:link action="show" params="[id:params?.id]">Datos de ${client}</g:link></li>
 	<li class="${actionName == 'history' ? 'active' : ''}"><g:link action="history" params="[id:params?.id]">Historial</g:link></li>
 	<li class="${actionName == 'sendMail' ? 'active' : ''}"><g:link action="sendMail" params="[id:params?.id]">Enviar email</g:link></li>
</ul>
<br>