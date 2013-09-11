<!DOCTYPE html>
<html> 
    <head>
        <title>Stete | Registro</title>
        <meta name="layout" content="steleTwitterBootstrap"/>
        <r:require module="assets" />
    </head> 
        <body>
            <header>
                <!--=== Content Part ===-->
                <div class="body">
                    <div class="breadcrumbs margin-bottom-50">
                        <div class="container">
                            <h1 class="color-green pull-left">Registro</h1>
                        </div><!--/container-->
                    </div><!--/breadcrumbs-->
                	<div class="container">	

                		<div class="row-fluid margin-bottom-10">
                		<div class="span3">
                            <g:render template="metas" />
                            <div class="who margin-bottom-30">
                                <div class="headline"><h3>Contáctanos</h3></div>
                                <p>Si requieres más información sobre nuestros servicios</p>
                                <ul class="unstyled">
                                    <li><a href="#"><i class="icon-envelope-alt"></i>info@stele.mx</a></li>
                                    <li><a href="#"><i class="icon-phone-sign"></i>+52 (55) 555 5555</a></li>
                                    <li><a href="#"><i class="icon-globe"></i>www.stele.mx</a></li>
                                    <li><a href="#"><i class="icon-twitter"></i>@SteleMX</a></li>
                                </ul>
                            </div>
                        </div><!--/span3-->
                            <g:form id="registroBasico" name="registroBasico" controller="registro" action="crear" class="reg-page">
                            	<h3>Registra una nueva cuenta</h3>
                                <div class="control-group">    
                                    <label class="control-label" for="inputInstitucion"><i class="icon-book"></i> Nombre del colegio <span class="color-red">*</span></label>
                                    <div class="controls">
                                        <input id="institucion.nombre" value="${params?.institucion?.nombre}" name="institucion.nombre"  type="text" class="span12" />
                                    </div>
                                    <label class="control-label" for="inputNombre"><i class="icon-user"></i> Nombre del responsable <span class="color-red">*</span></label>
                                    <div class="controls">
                                        <input id="perfil.nombre" name="perfil.nombre" type="text" class="span12">
                                    </div>
                                    <label class="control-label" for="inputApellidoPaterno"><i class="icon-user"></i> Apellido Paterno del responsable <span class="color-red">*</span></label>
                                    <div class="controls">
                                        <input id="perfil.apellidoPaterno" name="perfil.apellidoPaterno" type="text" class="span12">
                                    </div>
                                    <label class="control-label" for="inputApellidoMaterno"><i class="icon-user"></i> Apellido Materno del responsable <span class="color-blue">No obligatorio</span></label>
                                    <div class="controls">
                                        <input id="perfil.apellidoMaterno" name="perfil.apellidoMaterno" type="text"  class="span12">
                                    </div>
                                    <label class="control-label" for="inputEmail"><i class="icon-envelope"></i> Correo electrónico <span class="color-red">*</span></label>
                                    <div class="controls">
                                        <input id="usuario.username" name="usuario.username" placeholder="your@mail.com" type="text" class="span12">
                                    </div>
                                    <label><i class="icon-phone"></i> Teléfono <span class="color-red">*</span></label>
                                    <input type="text" class="span12" />
                                </div>
                                <div class="controls">
                                    <div class="span6">
                                        <label class="control-label" for="inputPassword">Contraseña <span class="color-red">*</span></label>
                                        <div class="controls">
                                            <input id="usuario.password" class="passwordOrigin" name="usuario.password" class="span12" type="password">
                                        </div>
                                    </div>
                                    <div class="span6">
                                        <label class="control-label" for="inputConfirmPassword">Confirma <span class="color-red">*</span></label>
                                        <div class="controls">
                                            <input id="inputConfirmPassword" name="inputConfirmPassword" type="password" class="span12">
                                        </div>
                                    </div>
                                </div>
                                <div class="control-group">    
                                    <div class="controls">
                                        <recaptcha:ifEnabled>
                                          <recaptcha:recaptcha theme="red"/>
                                        </recaptcha:ifEnabled>
                                      </div>
                                </div>
                                <div class="controls form-inline">
                                    <label class="checkbox"><input type="checkbox" />&nbsp; He leído los <a href="">términos y condiciones.</a></label>
                                    <button type="submit" class="btn-u pull-right"> Registrar </button>
                                </div>
                                <hr />
                				<p>¿Ya estás registrado? <a href="page_login.html" class="color-green">Accede</a> a tu cuenta.</p>
                            </g:form>
                        </div><!--/row-fluid-->
                	</div><!--/container-->		
                </div><!--/body-->
                <!--=== End Content Part ===-->
            </header>



        <!-- JS Global Compulsory -->           
        <script type="text/javascript" src="assets/js/jquery-1.8.2.min.js"></script>
        <script type="text/javascript" src="assets/js/modernizr.custom.js"></script>        
        <script type="text/javascript" src="assets/plugins/bootstrap/js/bootstrap.min.js"></script> 
        <!-- JS Implementing Plugins -->           
        <script type="text/javascript" src="assets/plugins/back-to-top.js"></script>
        <!-- JS Page Level -->           
        <script type="text/javascript" src="assets/js/app.js"></script>
        <script type="text/javascript">
            jQuery(document).ready(function() {
                App.init();
            });
        </script>
        <!--[if lt IE 9]>
            <script src="assets/js/respond.js"></script>
        <![endif]-->

        </body>
</html> 