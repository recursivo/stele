  <g:if test="${flash.message}">
    <input type="hidden" name="message" value="${flash.message}"/>
  </g:if>
  
  <input type="hidden" name="camada" value="${camada}" >
  <input type="hidden" name="listaDependientes" value="${listaDependientes}">

  <div class="alert alert-info">
    <button class="close" data-dismiss="alert" type="button">
      <i class="icon-remove"></i>
    </button>
    <strong>Nota! </strong>
      Sólo puede seleccionar un concepto: cobro unitario o recurrente
    <br/>
  </div>
  
  <div class="row-fluid">
    <g:form id="pagoGeneracion" name="pagoGeneracion" controller="esquemaDePago" action="generarPagoParaLaCamada" >
    <div class="span3">
      <div class="control-group">
        <label class="control-label" for="txtConcepto">Concepto</label>
          <div class="controls">
            <input type="hidden" id="urlConcepto" value="${g.createLink(action:'obtenerEsquemaDePagoPorConcepto', controller:'esquemaDePago')}" />
            <div class="input-prepend">
              <input type="text" id="conceptoDePago" class="typeahead2" data-provide="typeahead" name="conceptoDePago" placeholder="Concepto" autocomplete="off" >
                <span class="add-on">
                  <i class="icon-edit"></i>
                </span>
            </div>
          </div>
      </div>
                                        
      <div class="control-group">
        <label class="control-label" for="txtConcepto">Importe</label>
          <div class="controls">
            <div class="input-prepend">
              <span class="add-on">
                <i class="icon-usd"></i>
              </span>
              <input type="text" class="cantidadDePago" id="cantidadDePago" name="cantidadDePago" placeholder="0.0">
            </div>  
          </div>
      </div>
                                        
      <div class="control-group">
        <label class="control-label" for="txtConcepto">Fecha Vencimiento</label>
        <div class="controls">
          <div  class="input-append date">
            <input id="fechaDeVencimiento" name="fechaDeVencimiento" type="text" class="form-control vencimiento"/>
            <span class="add-on">
              <i class="icon-calendar"></i>
            </span>
          </div>
        </div>
      </div>
      </g:form>
    </div><!--/ span3 -->
                                
    <div class="span6">
      <ul class="nav nav-tabs padding-10">
        <li class="active">
          <a data-toggle="tab" href="#faq-tab-666">
            <i class="green icon-tag bigger-120"></i>
            Descuento
          </a>
        </li>
        <li>
          <a data-toggle="tab" href="#faq-tab-777">
            <i class="red icon-sort-by-attributes icon-flip-vertical bigger-120"></i>
            Recargo
          </a>
        </li>
      </ul>
      <div class="tab-content">
        <div id="faq-tab-666" class="tab-pane active">
          <div class="alert alert-info">
            <button class="close" data-dismiss="alert" type="button">
              <i class="icon-remove"></i>
            </button>
            <strong>Nota! </strong>
              Sólo puede seleccionar importe o porcentaje de descuento <br>
            <strong>Nota! </strong>
              Seleccionar fecha de vencimiento o dias antes de vencer el pago
            <br/>
          </div>
          <div class="row-fluid">
            <g:form url="[controller:'descuento', action:'nuevo']" name="descuentoUnitarioForm" id="descuentoUnitarioForm">
            <div class="span6">
                <div class="control-group">
                  <label class="control-label" for="txtConcepto"> Descuento </label>
                  <div class="controls">
                    <input type="hidden" id="urlDescuento" value="${g.createLink(action:'obtenerDescuentosInstitucion',controller:'descuento')}" />
                    <div class="input-prepend">
                      <input type="text" id="nombreDeDescuento" name="discountName" class="typeahead2" data-provide="typeahead" placeholder="Nombre" autocomplete="off">
                      <span class="add-on">
                        <i class="icon-edit"></i>
                      </span>
                    </div>  
                  </div>
                </div>

                <div class="control-group">
                  <label class="control-label" for="txtConcepto"> Importe </label>
                  <div class="controls">
                    <div class="input-prepend"> 
                      <span class="add-on">
                        <i class="icon-usd"></i>
                      </span>
                      <input class="input-medium" id="cantidad" name="amount" type="text" placeholder="0.0">
                    </div>
                  </div>
                </div>

                <div class="control-group">
                  <label class="control-label" for="txtConcepto">Fecha Vencimiento</label>
                  <div class="controls">                  
                    <div class="input-append date">
                      <input type="text" id="fechaDeVencimientoDesc" name="expirationDacontrol" />
                      <span class="add-on">
                        <i class="icon-calendar"></i>
                      </span>
                    </div>
                  </div>
                </div>              
            </div>
            
            <div class="span6">
              <div class="control-group">
                <div class="input-prepend">
                  <label class="control-label" for="txtConcepto"> Dias antes </label> 
                  <div class="controls">

                    <div class="input-prepend">
                      <g:select name="previousDaysForCancelingDiscount" id="diasPreviosParaCancelarDescuento" from="${0..30}" noSelection="['':'- Dia -']"/>
                    </div>
                  </div>
                </div>
              </div>
              
              <div class="control-group">
                <div class="input-append">
                  <label class="control-label" for="txtConcepto"> Procentaje </label>
                  <div class="controls">
                    <input type="text" class="input-mini" id="porcentaje" n  placeholder="0.0">
                    <span class="add-on">%</span>
                  </div>
                </div>
              </div>
              
              <div class="contro-group">
                <div class="controls">
                  <input class="btn btn-primary" type="submit" id="descuentoButton" name="descuentoButton" value ="Crear Descuento">
                </div>
              </div>
            </div>
            </g:form>
          </div>
        </div>
        <div id="faq-tab-777" class="tab-pane">
          <div class="row-fluid">
            <g:form name="recargoForm" url="[controller:'recargo',action:'nuevo']" id="recargoForm">
            <div class="span6">
              <div class="control-group">
                <label class="control-label" for="txtConcepto">Importe</label>
                <div class="controls">
                  <div class="input-prepend">
                    <span class="add-on">
                      <i class="icon-usd"></i>
                    </span>
                    <input class="input-mini" id="recCantidad" name="amount" type="text" placeholder="0.0">
                  </div>
                </div>
              </div>
              <div class="control-group">
                <label class="control-label" for="txtConcepto">Porcentaje</label>
                <div class="controls">
                  <div class="input-append">
                    <input class="input-mini" id="recPorcentaje" name="percentage" type="text" placeholder="0.0">
                    <span class="add-on">%</span>
                  </div>
                </div>
              </div>
              <div class="contro-group">
                <div class="controls">
                  <input class="btn btn-primary" type="submit" id="recargoButton" value ="Crear Recargo">
                </div>
              </div>
            </div>
            </g:form> 
            <div class="span2">
              <div class="recargoCreado" name="recargoCreado2">
                <g:render template="/recargo/list" />
              </div>
            </div>
          </div>

        </div>
      </div>

      <input type="hidden" id="idRecargo" name="idRecargo">                                  
      <input type="hidden" id="idsDescuentos" name="idsDescuentos">
                                  
      <label class="hidden cantidadRecargo" >Recargo Cantidad</label>
      <input class="hidden cantidadRecargo" id="cantidadRecargo" name="cantidadRecargo" readonly>
                                  
      <label class="hidden porcentajeRecargo">Recargo Porcentaje</label>
      <input class="hidden porcentajeRecargo" id="porcentajeRecargo" name="recargoPorcentaje" readonly>
                                  
      <div class="descuentosDiv">
        <!-- TODO Poner estilo en un archivo .css -->
        <table class="table hidden cuTable" style="table-layout:fixed;width:100%;word-wrap:break-word;margin-top:10px;">
          <thead>
            <tr>
              <th>Descuento</th>
              <th>Importe</th>
              <th>Fecha de Vencimiento</th>
            </tr>
          </thead>
          <tbody class="cobroUnitarioDescuentosTableBody">
          </tbody>
        </table>
      </div>                            
    </div>                                
    
    <div class="span3">      
      <div class="descuentoCreado">
        <g:render template="/descuento/list", model="[:]" />
      </div>
    </div>

  </div>

