<div class="row-fluid">
  <div class="span12 widget-container-span">
    <div class="widget-box">
      <div class="widget-header widget-header-small header-color-blue">
        <h5 class="bigger lighter">
          <i class="icon-money"></i>
          Pagos
        </h5>
        <div class="widget-toolbar">              
        </div> 
      </div>
      <div class="widget-body">
        <div class="widget-main no-padding">
          <table class="table table-striped table-bordered table-hover">
            <thead>
              <tr>
                <th> </th>    
                <th colspan="2" ></th>
                <th colspan="3" class="center green" >Descuento</th>
                <th></th>
                <th></th>
                <th></th>
              </tr>
               <tr>
                <th>Concepto</th>                
                <th>F. Vencimiento</th>
                <th>Monto</th>
                <th class=" green">
                  F. Vencimiento
                </th>
                <th class=" green">
                  Descuentos
                </th>
                <th class=" green">
                  Total
                </th>
                <th></th>
                <th>Comprobante</th>
                <th>Recibo de pago</th>
              </tr> 
            </thead>                      
            <tbody>
              <g:each in="${pagosEnTiempo}">
                <tr>
                  <td>${it.paymentConcept}</td>
                  <td>${it.dueDate.format('dd-MMM-yyyy')}</td>
                  <td>$ ${it.paymentAmount}</td>      
                  <td>
                    <g:each in="${it.applicableDiscounts.sort{it.id}}" var="applicableDiscount">
                      <p><g:formatDate format="dd-MMM-yyyy" date="${applicableDiscount.expirationDate}"/></p>
                    </g:each>
                  </td>
                  <td>
                    <g:each in="${it.applicableDiscounts.sort{it.id}}" var="applicableDiscount">
                      <p><g:formatNumber number="${applicableDiscount.discount.amount}" type="currency" /></p>
                    </g:each>
                  </td>
                  <td>$ ${it.paymentAmount - it.accumulatedDiscount}</td>                  
                  <td width="70"><span class="label label-info arrowed-in">Pendiente</span></td>
                  <td class="center" width="140">
                    <g:if test="${!flash.ventanilla}">
                      <g:link controller="reciboPago" id="${it.id}" class="btn btn-mini btn-purple">
                        Adjunte Comprobante
                      </g:link>
                    </g:if>
                    <g:elseif test="${flash.ventanilla}">
                      <g:link controller="pagoVentanilla" id="${it.id}" class="btn btn-minier btn-success">
                        Pagar
                      </g:link>
                    </g:elseif>
                  </td>
                  <td></td>                  
                </tr>
              </g:each>
              <g:each in="${pagosProcesados}">
                <tr>
                  <td>${it.paymentConcept}</td>
                  <td>${it.dueDate.format('dd-MMM-yyyy')}</td>
                  <td>$ ${it.paymentAmount}</td>
                  <td>
                    <g:each in="${it.applicableDiscounts.sort{it.id}}" var="applicableDiscount">
                      <p><g:formatDate format="dd-MMM-yyyy" date="${applicableDiscount.expirationDate}"/></p>
                    </g:each>
                  </td>
                  <td>
                    <g:each in="${it.applicableDiscounts.sort{it.id}}" var="applicableDiscount">
                      <p><g:formatNumber number="${applicableDiscount.discount.amount}" type="currency" /></p>
                    </g:each>
                  </td>                  
                  <td>$ ${it.paymentAmount - it.accumulatedDiscount}</td>                                    
                  <td width="70"><span class="label label-warning arrowed-in">Revision</span></td>
                  <td class="center" width="140"></td>
                  <td></td>
                </tr>
              </g:each>
              <g:each in="${pagoCorrectos}">
                <tr>
                  <td>${it.paymentConcept}</td>   
                  <td>${it.dueDate.format('dd-MMM-yyyy')}</td>
                  <td>$ ${it.paymentAmount}</td>
                  <td>
                    <g:each in="${it.applicableDiscounts.sort{it.id}}" var="applicableDiscount">
                      <p><g:formatDate format="dd-MMM-yyyy" date="${applicableDiscount.expirationDate}"/></p>
                    </g:each>
                  </td>
                  <td>
                    <g:each in="${it.applicableDiscounts.sort{it.id}}" var="applicableDiscount">
                      <p><g:formatNumber number="${applicableDiscount.discount.amount}" type="currency" /></p>
                    </g:each>
                  </td>                  
                  <td>$ ${it.paymentAmount - it.accumulatedDiscount}</td>                  
                  <td width="70"><span class="label label-success arrowed-in">Pagado</span></td>
                  <td class="center" width="140">
                  <g:if test="${it.proofOfPayment}">
                    <g:link controller="comprobante" action="descargarComprobante" params="[pagoId:it.id]" class="btn btn-mini btn-info">
                      Descargar
                    </g:link>
                  </g:if>
                  </td> 
                  <td class="center" width="140">
                    <g:link controller="pago" action="generarComprobante" params="[pagoId:it.id]" class="btn btn-mini btn-info">
                      Descargar 
                    </g:link>
                  </td>
                </tr>
              </g:each>
            </tbody>  
          </table>
        </div>
      </div>
    </div>
  </div><!--/span-->
</div>
