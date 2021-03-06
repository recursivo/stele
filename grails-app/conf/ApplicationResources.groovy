modules = {
  application {
    resource url:'js/application.js'
  }

  paraCamada {
    dependsOn 'bootstrapDatePicker'
    dependsOn 'handlebars'
    dependsOn 'validation'
    resource url:'js/paraCamada/cobroUnitario.js'
    resource url:'js/paraCamada/cobroRecurrente.js'
    resource url:'js/paraCamada/operacionDescuento.js'
    resource url:'js/paraCamada/descuentoUnitario.js'
    resource url:'js/paraCamada/descuentoRecurrente.js'
    resource url:'js/paraCamada/recargo.js'
    resource url:'js/paraCamada/app.js'
  }

  pagoVentanilla{
    dependsOn 'bootstrapDatePicker'
    resource url:'js/pagoVentanilla/pagoInmediato.js'
    resource url:'js/pagoVentanilla/app.js'
  }

  conciliacion{
    dependsOn 'bootstrapDatePicker'
    dependsOn 'validation'
    resource url:'js/conciliacion/comprobante.js'
    resource url:'js/conciliacion/app.js'
  }

  handlebars{
    resource url:'js/handlebars/handlebars-v1.3.0.js'
  }

  telefono {
    resource url:'js/telefono/index.js'
  }

  auth {
    dependsOn 'steleJS'
    resource url:'css/login/auth.css'
  }

  upload {
    resource url:'js/upload/css/basic.css'
    resource url:'js/upload/css/dropzone.css'
  }

  styledrop {
    resource url:'js/perfil/styleDropzone.js'
  }

  uploadImg{
    dependsOn 'styledrop'
    resource url:'js/perfil/uploadImg.js'
  }
  
  validation {
    resource url:'js/jquery-1.8.2.min.js'
    resource url:'js/common/jquery.validate.min.js'
  }

  validarEsquemaDePago {
    dependsOn 'validation'
    resource url:'js/esquemaDePago/validarEsquema.js'
  }

  registrar {
    dependsOn 'validation'
    resource url:'js/registro/index.js'
  }

  perfilValidate {
    dependsOn 'validation'
    resource url:'js/perfil/validates.js'
  }

  pagosParaCamada {
    resource url:'js/esquemaDePago/paraCamada.js'
  }
  
  generarPagos {
    dependsOn 'validation'
    resource url: 'js/esquemaDePago/generar.js'
  }

  inscripcion {
    dependsOn 'validation'
    resource url: 'js/inscripcion/validar.js'
  }

  autocomplete {
    resource url: 'js/esquemaDePago/autocomplete.js'
  }

  steleCss {
    resource url:'new/assets/plugins/bootstrap/css/bootstrap.min.css'
    resource url:'new/assets/css/style.css'
    resource url:'new/assets/css/headers/header1.css'
    resource url:'assets/css/bootstrap-responsive.min.css'
    resource url:'new/assets/css/responsive.css'
    resource url:'new/assets/plugins/font-awesome/css/font-awesome.css'
    resource url:'new/assets/plugins/flexslider/flexslider.css'
    resource url:'new/assets/plugins/bxslider/jquery.bxslider.css'
    resource url:'new/assets/plugins/horizontal-parallax/css/horizontal-parallax.css'
    resource url:'new/assets/css/pages/page_pricing.css'
    resource url:'new/assets/css/pages/page_log_reg_v1.css'
    resource url:'new/assets/css/themes/default.css'
  }

  steleJs {
    resource url:'new/assets/plugins/bootstrap/js/bootstrap.min.js'
    resource url:'new/assets/plugins/back-to-top.js'
    resource url:'new/assets/plugins/flexslider/jquery.flexslider-min.js'
    resource url:'new/assets/plugins/horizontal-parallax/js/sequence.jquery-min.js'
    resource url:'new/assets/plugins/horizontal-parallax/js/horizontal-parallax.js'
    resource url:'new/assets/plugins/bxslider/jquery.bxslider.js'
    resource url:'new/assets/js/app.js'
  }

  stele {
    dependsOn 'steleCss'
    dependsOn 'steleJs'
  }
  
  bootstrapDatePicker{
    resource url: 'datepicker/css/datepicker.css'
    resource url: 'datepicker/js/bootstrap-datepicker.js'
    resource url: 'datepicker/js/locales/bootstrap-datepicker.es.js'
  }

  cobro {
    dependsOn 'pagosParaCamada'
    dependsOn 'generarPagos'
    dependsOn 'autocomplete'
    dependsOn 'bootstrapDatePicker'
    resource url: 'js/cobro/cobro.js'
  }
  
  customBootsrapCss{
    resource url:'assets/css/bootstrap.min.css'
    resource url:'assets/css/bootstrap-responsive.min.css'
  }
  customFontAwesomeCss{
    resource url:'assets/css/font-awesome.min.css'
  }
  dropzoneCss {
    resource url:'assets/css/dropzone.css'
  }
  customAceCss{
    resource url:'assets/css/ace-fonts.css'
    resource url:'assets/css/ace.min.css'
    resource url:'assets/css/ace-responsive.min.css'
    resource url:'assets/css/ace-skins.min.css'
  }
  colegioCss {
    dependsOn 'customBootsrapCss'
    dependsOn 'customFontAwesomeCss'
    dependsOn 'customAceCss'
    dependsOn 'dropzoneCss'
  }
  jquery2{
    resource url:'assets/js/jquery-2.0.3.min.js', disposition:'head', wrapper: { s ->
      def url = s.find(/src.+.js|.css/) - "src=\""
      """
        <!--[if !IE]>-->
        <script type="text/javascript">
          window.jQuery || document.write("<script src='$url'>"+"<"+"/script>");
        </script>
        <!--<![endif]-->
      """
    }
  }
  jquery1{
    resource url:'assets/js/jquery-1.10.2.min.js', disposition:'head', wrapper: { s ->
      def url = s.find(/src.+.js|.css/) - "src=\""
      """
        <!--[if IE]>
        <script type="text/javascript">
         window.jQuery || document.write("<script src='url'>"+"<"+"/script>");
        </script>
        <![endif]-->
      """
    }
  }
  colegioJs {
    resource url:'assets/js/ace-extra.min.js'
    resource url:'assets/js/bootstrap.min.js'
    resource url:'assets/js/ace-elements.min.js'
	resource url:'assets/js/ace.min.js'
    resource url:'assets/js/uncompressed/ace.js'
    
    resource url:'assets/js/bootbox.min.js'
    resource url:'assets/js/dropzone.min.js'
    resource url:'assets/js/jquery.nestable.min.js'
    resource url:'assets/js/jquery.dataTables.min.js'
    resource url:'assets/js/jquery.dataTables.bootstrap.js'
    resource url:'assets/js/jquery-ui-1.10.3.custom.min.js'
    resource url:'assets/js/chosen.jquery.min.js'
    resource url:'assets/js/jquery.autosize-min.js'
    resource url:'assets/js/jquery.inputlimiter.1.3.1.min.js'
    resource url:'assets/js/jquery.maskedinput.min.js'
  }
  colegio {
    dependsOn 'colegioCss'
    dependsOn 'jquery2'
    dependsOn 'jquery1'
    dependsOn 'colegioJs'
  }

  busquedaDependientes{ 
    dependsOn 'handlebars'
    resource url: 'js/dependiente/busqueda.js'
    resource url: 'js/dependiente/busquedaAlumno.js'
    resource url: 'js/dependiente/dependiente.js'
    resource url: 'js/dependiente/app.js'
  }
  
  reporteAlumnosInscritos {
	  resource url: 'js/reporteAlumnosInscritos/index.js'
  }
  
  graficacion {
	  resource url:'Highcharts-4.0.4/js/highcharts.js'
	  resource url:'Highcharts-4.0.4/js/highcharts-3d.js'
	  resource url:'Highcharts-4.0.4/js/modules/exporting.js'
	  resource url:'Highcharts-4.0.4/js/themes/stele.js'
  }
  
}
