<g:form id="busquedaDependientes" name="busquedaDependientes" url="[controller: 'dependiente', action:'search']">
<div class="span3 widget-container-span">
  <div class="widget-box">
    <div class="widget-header">
      <h5>Búsqueda</h5>
    </div>
    <div class="widget-body">
      <div class="widget-main">
        <div class="control-group">
          <label class="control-label" for="selectGrupo">Turno</label>
          <div class="controls">
            <input type="hidden" name="getNivelUrl" value="${g.createLink(action:'ajaxTurnoANivel', controller:'utilidades')}" /> 
            <g:select name="turno" id="turno" from="${turnos}" noSelection="['':'-Selecciona el Turno-']" />
          </div>
        </div>
        <div class="control-group">
          <label class="control-label" for="selectNivel">Nivel</label>
          <div class="controls">
            <input type="hidden" name="getGrupoUrl" value="${g.createLink(action:'ajaxNivelAGrado', controller:'utilidades')}" />
            <g:select name="nivel" from="${niveles}" noSelection="['':'-Selecciona el Nivel-']" />
         </div>
       </div>  
       <div class="control-group">
        <label class="control-label" for="selectNivel">Grado</label>
        <div class="controls">
          <input type="hidden" name="getGradoUrl" value="${g.createLink(action:'ajaxGradoAGrupo', controller:'utilidades')}" />
          <g:select name="grado" from="${grados}" noSelection="['':'-Selecciona el Grado-']" />
        </div>
      </div>
      <div class="control-group">
        <label class="control-label" for="selectNivel">Grupo</label>
        <div class="controls">
          <g:select name="grupo" from="${grupos}" noSelection="['':'-Selecciona el Grupo-']" />
        </div>
      </div>  
    </div>
    <div class="widget-toolbox padding-8 clearfix ">
      <button type="submit" class="btn  btn-info">
        Agregar
        <i class="icon-arrow-right icon-on-right"></i>
      </button>
      <button type="reset" class="btn btn-info pull-right">
        Limpiar
      </button>
    </div>
  </div>
</div>
</div>
</g:form>

<script id="nivel-template" type="text/x-handlebars-template">
    <option value="">-Selecciona el Nivel-</option>
    {{#each this}}
      <option value="{{this}}">{{this}}</option> 
    {{/each}}
</script>

<script id="grado-template" type="text/x-handlebars-template">
  <option value="">-Selecciona el Grado-</option>
  {{#each this}}
    <option value="{{this}}">{{this}}</option> 
  {{/each}}
</script>
<script id="grupo-template" type="text/x-handlebars-template">
  <option value="">-Selecciona el Grupo-</option>
  {{#each this}}
    <option value="{{this}}">{{this}}</option>
  {{/each}}
</script>
