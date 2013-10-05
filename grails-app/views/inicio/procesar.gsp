<html>
  <head>
    <meta name="layout" content="colegio"/>
  </head>
  <body>
   <div class="main-content">
        <div class="breadcrumbs" id="breadcrumbs">
          <script type="text/javascript">
            try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
          </script>

          <ul class="breadcrumb">
            <li>
              <i class="icon-home home-icon"></i>
              <a href="#">Colegio</a>

              <span class="divider">
                <i class="icon-angle-right arrow-icon"></i>
              </span>

            <li>
              <a href="#">Inscripcion</a>
              <span class="divider">
                <i class="icon-angle-right arrow-icon"></i>
              </span>
            </li>
            <li class="active">Archivo</li>
          </ul><!--.breadcrumb-->


        </div>

        <div class="page-content">
          <g:if test="${flash.inscripcionCobro == 'true'}">
            <div class="page-header position-relative">
              <h1>
                Inscripcion Archivo + Cobro
                <small>
                  <i class="icon-double-angle-right"></i>
                  Inscripcion Archivo de Alumnos y su Padre o Tutor, mas a gregar un cobro a los alumnos del archivo
                </small>
              </h1>
            </div>
          </g:if>
          <g:else>
            <div class="page-header position-relative">
              <h1>
                Inscripcion Archivo
                <small>
                  <i class="icon-double-angle-right"></i>
                  Inscripcion Archivo de Alumnos y su Padre o Tutor
                </small>
              </h1>
            </div>
          </g:else>
          <div class="row-fluid">
<!--aqui el update-->
            <div class="span12">
              <!--PAGE CONTENT BEGINS-->

              <div class="widget-box">
                <div class="widget-header widget-header-blue widget-header-flat">
              </div>

                <div class="widget-body">
                  <div class="widget-main">
                    <div class="row-fluid">
                      <g:if test="${flash.inscripcionCobro == 'true'}">
                        <g:render template="menuArchivoCobro" />
                      </g:if>
                      <g:else>
                        <g:render template="menuArchivo" />
                      </g:else>

                      <hr />
                        <div class="step-content row-fluid  position-relative" id="step-container">

                          <div class="step-pane active" id="step3">
                            <form class="form-horizontal" id="sample-form">
                              <div class="center">
                                <div class="alert alert-block alert-info">
                                  <p>
                                    <strong>
                                      <i class="icon-ok"></i>
                                      Confirmar!
                                    </strong>
                                    Este proceso registra la informacion en el sistema, por lo que importante que de <strong> click </strong> en procesar.
                                  </p>

                                  <p>
                                    <g:if test="${flash.inscripcionCobro == 'true'}">
                                      <g:link  controller="procesamientoMasivo" params="[institucionId:institucionId, cobro:true]">
                                      <span class="btn btn-app btn-success " href="#">
                                        <i class="icon-cogs bigger-230 "></i>
                                        <strong>  Procesar  </strong>
                                      <br>
                                      </span>
                                      </g:link>
                                    </g:if>
                                    <g:else>
                                      <g:link  controller="procesamientoMasivo" params="[institucionId:institucionId, cobro:false]">
                                      <span class="btn btn-app btn-success " href="#">
                                        <i class="icon-cogs bigger-230 "></i>
                                        <strong>  Procesar  </strong>
                                      <br>
                                      </span>
                                      </g:link>
                                    </g:else>
                                  </p>
                                </div>
                              </div>
                            </form>
                          </div>


                          <div class="step-pane" id="step4" align="center">
                            <img style="-webkit-user-select: none" src="http://www.jose-aguilar.com/blog/wp-content/uploads/2012/03/loading.gif" align="middle">
                          </div>
                          
                        </div>
                      <hr />
                    </div>
                  </div><!--/widget-main-->
                </div><!--/widget-body-->
              </div>



              <!--PAGE CONTENT ENDS-->
            </div><!--/.span-->
            <!-- aqui cierra --> 
          </div><!--/.row-fluid-->
        </div><!--/.page-content-->

        <div class="ace-settings-container" id="ace-settings-container">


          <div class="ace-settings-box" id="ace-settings-box">
         

            <div>
              <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-navbar" />
              <label class="lbl" for="ace-settings-navbar"> Fixed Navbar</label>
            </div>

            <div>
              <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-sidebar" />
              <label class="lbl" for="ace-settings-sidebar"> Fixed Sidebar</label>
            </div>

            <div>
              <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-breadcrumbs" />
              <label class="lbl" for="ace-settings-breadcrumbs"> Fixed Breadcrumbs</label>
            </div>

            <div>
              <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-rtl" />
              <label class="lbl" for="ace-settings-rtl"> Right To Left (rtl)</label>
            </div>
          </div>
        </div><!--/#ace-settings-container-->
      </div><!--/.main-content-->
    </div><!--/.main-container-->

      <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-small btn-inverse">
      <i class="icon-double-angle-up icon-only bigger-110"></i>
    </a>
   
  </body>
</html>