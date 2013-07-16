<html>
  <head>
    <meta name="layout" content="twitterBootstrap"/>
    <title>Esquema de pago</title>
    <r:require module="pagosParaCamada"/>
    <r:require module="generarPagos" />
  </head>

  <body>

    <div class="page-header">
      <h1><i class="icon-dollar"></i> · Crear un pago <small>con un esquema</small></h1>
    </div>
    <br />

    <div class="container-fluid">
      <div class="row-fluid">
        <g:formRemote id="pagoGeneracion" name="pagoGeneracion" url="[controller: 'esquemaDePago', action: 'generarPagoParaLaCamada']"  >
          <input type="hidden" id="camada" name="camada" value="${camada}">
          <div class="control-group">
            <label for="conceptoDePago" class="control-label">Concepto: </label>
            <div class="controls">
              <input type="text" id="conceptoDePago" name="conceptoDePago" placeholder="Concepto">
            </div>
          </div>
          <div class="control-group">
            <label for="cantidadDePago" class="control-label">Monto: </label>
            <div class="controls">
              <div class="input-prepend input-append">
                <span class="add-on">$</span>
                <input type="text" id="cantidadDePago" name="cantidadDePago" placeholder="0.0">
              </div>
            </div>
          </div>
          <div class="control-group">
            <label for="fechaDeVencimiento" class="control-label">Fecha de vencimiento: </label>
            <div class="controls">
              <g:datePicker name="fechaDeVencimiento" value="${new Date()}" precision="day" />
            </div>
          </div>

          <div class="control-group">
            <div class="controls">
              <a href="#descuento" role="button" class="btn btn-info" data-toggle="modal">Agregar descuento</a>
            </div>
          </div>

          <g:link controller="camada" action="show" params="[camada:camada]">Ver lista de alumnos</g:link>
          <div class="form-actions" style="text-align:right;">
            <button type="submit" class="btn btn-primary btn-large" >Generar pagos</button>
          </div>
        </g:formRemote>

      </div>
    </div>

    <div id="descuento" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="descuentoLabel" aria-hidden="true">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
        <h3 id="descuentoLabel">Datos del descuento</h3>
      </div>

      <g:form controller="descuento" action="nuevo" class="form-horizontal">
        <div class="modal-body">
          <g:render template="/descuento/nuevoDescuento" />
        </div>
        <div class="modal-footer">
          <button class="btn" data-dismiss="modal" aria-hidden="true">Cancelar</button>
          <button class="btn btn-primary">Aplicar descuento</button>
        </div>
      </g:form>

    </div>

  </body>
</head>
