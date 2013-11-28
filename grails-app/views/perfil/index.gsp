<%@ page import="com.makingdevs.TipoDeTelefono" %>
<html>
  <head>
    <meta name="layout" content="colegio"/>
    <r:require modules="telefono, uploadImg,bootstrap-js,bootstrapDatePicker,upload"/>
  </head>

  <body>
    <r:script type="text/javascript">
      $(document).ready(function() {
        $('.fechaNacimiento').datepicker({
          format : "dd/mm/yyyy",
          language : 'es',
          autoclose : true
        });
      });
      $(function() {
        console.log("hola");
        var urlValue = $("input#url").val() 
          Dropzone.options.dropzone = {
          url : urlValue,
          maxFilesize : .5,
          addRemoveLinks : false
          };
      });
    </r:script>
    <div class="page-content">
     <div class="page-header position-relative">
       <h1>
         Editar perfil
       </h1>
     </div><!--/.page-header-->

     <div class="row-fluid">
       <div class="span12">
         <!--PAGE CONTENT BEGINS-->
           <div id="user-profile-1" class="user-profile row-fluid">
               <div class="tabbable">
                 <ul class="nav nav-tabs padding-18">
                   <li class="active">
                     <a data-toggle="tab" href="#home">
                       <i class="green icon-user bigger-120"></i>
                       Perfil
                     </a>
                   </li>

                   <li>
                     <a data-toggle="tab" href="#feed">
                       <i class="orange icon-rss bigger-120"></i>
                       Informacion de contacto
                     </a>
                   </li>

                   <li>
                     <a data-toggle="tab" href="#password">
                       <i class="pink icon-key bigger-120"></i>
                       Contraseña 
                     </a>
                   </li>
                 </ul>

                 <div class="tab-content no-border ">
                   <div id="home" class="tab-pane in active">
                     <div class="row-fluid">
                     <div class="span12">
                       <div class="span3 center">
                         <input type="hidden" value="${createLink(controller:'perfil', action:'uploadImage', id: usuarioActual.perfil.id)}" id="url" />
                         <input type="file" id="dropzone" class="dropzone" />
                         <div class="space-4"></div>
                         <div class="width-80 label label-info label-large arrowed-in arrowed-in-right">
                           <div class="inline position-relative">
                             <span class="white middle bigger-120">${usuarioActual.perfil.nombre} ${usuarioActual.perfil.apellidoPaterno} ${usuarioActual.perfil.apellidoMaterno}</span>
                           </div>
                         </div>
                       </div>

                       <div class="span9">
                         <div class="profile-user-info profile-user-info-striped">
                           <div class="profile-contact-info">
                             <div class="profile-contact-links center">
                                 <i class="icon-envelope bigger-120 pink"></i>
                                 ${usuarioActual.username}
                                 <i class="icon-phone bigger-125 blue"></i>
                                  <g:findAll in="${usuarioActual.perfil.telefonos}" expr="it.principal ==  true">
                                    ${it.numeroTelefonico}
                                  </g:findAll>
                             </div>
                           </div>  
                         
                           <div class="profile-info-row ">
                             <div class="profile-info-name"> Nombre </div>

                             <div class="profile-info-value  align-left">
                                 <input type="text" id="form-field-1" placeholder="${usuarioActual.perfil.nombre}" readonly/>
                                   <input type="text" id="form-field-1" placeholder="${usuarioActual.perfil.apellidoPaterno}" readonly/>
                                   <input type="text"  placeholder="${usuarioActual.perfil.apellidoMaterno}" readonly/>
                             </div>
                           </div>




                           <div class="profile-info-row">
                             <div class="profile-info-name"> Sexo </div>

                             <div class="profile-info-value">
                                 <input class="ace" type="radio" name="form-field-sexo" >
                                 <span class="lbl"> Femenino</span>
                                 <input class="ace" type="radio"   name="form-field-sexo">
                                 <span class="lbl"> Masculino</span> 
                             </div>
                           </div>

                           <div class="profile-info-row">
                             <div class="profile-info-name"> Fecha Nacimiento </div>
                              <g:formRemote name="fechaDeNacimiento" update="fechaNacimientoDiv" url="[controller:'perfil', action:'actualizarFechaNacimiento', params:[id: "${usuarioActual.perfil.id}"]]">
                                <div class="profile-info-value" id="fechaNacimientoDiv">
                                  <div id="fechaNamiciento" class="input-append date" data-date="12-02-2012" data-date-format="dd-mm-yyyy">
                                    <input id="fechaNacimiento" name="fechaNacimiento" class="fechaNacimiento" data-format="yyyy-mm-dd" type="text" placeholder="${usuarioActual.perfil?.fechaDeNacimiento?.format("dd/MM/yyyy") ?: ''}"></input>
                                    <span class="add-on">
                                      <i class="icon-calendar"></i>
                                    </span>
                                    <p></p>
                                     <button type="submit" class="btn btn-mini">
                                        Actualizar
                                      </button>
                                  </div>
                                </div>
                              </g:formRemote>
                           </div>
                         </div>
                       </div>
                     </div>
                     </div>

                 <div class="row-fluid">                           
                    <div class="hr dotted"></div>
                     </div>
                    <g:each in="${usuarioActual.dependientes}"> 
                      <div class="row-fluid">
                      <div class="span12">
                       <div class="span3 center">
                         <input type="file" />
                         <div class="space-4"></div>
                         <div class="width-80 label label-purple label-large arrowed-in arrowed-in-right">
                           <div class="inline position-relative">
                               <span class="white middle bigger-120">${it.perfil.nombre} ${it.perfil.apellidoPaterno} ${it.perfil.apellidoMaterno}</span>
                           </div>
                         </div>
                       </div>

                       <div class="span9">
                         <div class="space-6"></div>
                         <div class="profile-user-info profile-user-info-striped">
                           <div class="profile-info-row ">
                             <div class="profile-info-name"> Grado </div>

                             <div class="profile-info-value  align-left">
                             <span>${it.historialAcademico.distribucionInstitucional.nivelDeEstudio.first()}</span>
                             </div>
                           </div>

                           <div class="profile-info-row">
                             <div class="profile-info-name"> Grupo </div>

                             <div class="profile-info-value">
                                 <span>${it.historialAcademico.distribucionInstitucional.grado.first()}° ${it.historialAcademico.distribucionInstitucional.grupo.first()}</span>
                             </div>
                           </div>

                           <div class="profile-info-row">
                            <div class="profile-info-name"> Fecha Nacimiento </div>
                              <g:formRemote name="fechaDeNacimiento" update="fechaNacimientoDiv" url="[controller:'perfil', action:'actualizarFechaNacimiento', params:[id: "${it.perfil.id}"]]">
                                <div class="profile-info-value" id="fechaNacimientoDiv">
                                  <div id="fechaNamiciento" class="input-append date" data-date="12-02-2012" data-date-format="dd-mm-yyyy">
                                    <input id="fechaNacimiento" name="fechaNacimiento" class="fechaNacimiento"data-format="yyyy-mm-dd" type="text" placeholder="${it.perfil?.fechaDeNacimiento?.format("dd/MM/yyyy") ?: ''}"></input>
                                    <span class="add-on">
                                      <i class="icon-calendar"></i>
                                    </span>
                                    <p></p>
                                     <button type="submit" class="btn btn-mini">
                                        Actualizar
                                      </button>
                                  </div>
                                </div>
                              </g:formRemote>
                           </div>
                         </div>
                         </div>
                       </div>
                      </div>
                    </g:each>
                   </div><!--#home-->

                <div id="feed" class="tab-pane">
                  <g:render template="/telefono/list" model="[telefonos:usuarioActual.perfil.telefonos]" />
                </div>

                <div id="password" class="tab-pane">
                  <g:form name="password" controller="perfil" action="actualizarPassword">
                    <div class="profile-user-info profile-user-info-striped">
                      <div class="profile-info-row ">
                        <div class="profile-info-name"> Nueva contraseña </div>

                        <div class="profile-info-value  align-left">
                          <input type="password" id="nuevaContrasenia" name="nuevaContrasenia" placeholder="Nueva contraseña">
                        </div>
                      </div>
                      <div class="profile-info-row ">
                        <div class="profile-info-name"> Confirmar  </div>
                        <div class="profile-info-value  align-left">
                          <input type="password" id="confirmaContrasenia" name="confirmaContrasenia" placeholder="Confirma contraseña">
                        </div>
                      </div>
                      <div class="profile-info-value  align-left" style="text-align:right;">
                        <button type="submit" class="btn btn-primary">
                          Actualizar contraseña
                        </button>
                      </div>
                    </div>
                  </g:form>
                </div>

               <div class="form-actions center">
                 
               </div>


           </div>
         </div>
         <!--PAGE CONTENT ENDS-->
       </div><!--/.span-->
     </div><!--/.row-fluid-->
    </div><!--/.page-content-->
  </body>
</html>
