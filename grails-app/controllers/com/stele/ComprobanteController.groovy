package com.stele

class ComprobanteController {

  def pagoService

  def show() {
    log.debug "params : $params"
    def pago = pagoService.obtenerPagoParaValidarComprobante(params.long('id'))
    [pago: pago.pago, perfil:pago.perfil]
  }

  def validarComprobante() {
    log.info "params : $params"
    
    render (view :"/pago/pagosDeUnaInstitucion") 
  }

  def rechazarComprobante() {

  }

}
