package com.stele

import com.stele.Dependiente
import com.makingdevs.*
import com.payable.*

class ComprobanteController {

  def pagoService
  def proofOfPaymentService 
  def perfilService
  def dependienteService
  def notificacionService

  def show() {
    def pago = pagoService.obtenerPagoParaValidarComprobante(params.long('id'))
    def dependiente = Payable.withCriteria {
      pagos {
        eq "id", pago.id
      }
    }
    def perfil = perfilService.obtenerPerfilDeUsuario(dependiente.usuario.perfil.first().id)
    [pago: pago, perfil:perfil]
  }

  def validarComprobante() {
    def pago = comprobanteService.aprobarPagoConciliacion(params.transactionId, Date.parse('dd/MM/yyyy',params.fechaDePago), params.tipoDePago, params.folioBanco)
    def dependiente = dependienteService.obtenerDependientesPorPagos([pago])
    notificacionService.notificarPagoAprovado(dependiente)
    flash.success = "El comprobante fue aprobado"
    redirect (controller: "Pago", action: "mostrarPagosAsociadosALaInstitucionEnBaseAHistorialesAcademicos")
  }

  def rechazarPago() {
    def pago = comprobanteService.rechazarPago(params.transactionId)
    def dependiente = dependienteService.findDependienteFromPaymentId([pago])
    notificacionService.notificarPagoRechazado(dependiente)
    redirect (controller: "Pago", action: "mostrarPagosAsociadosALaInstitucionEnBaseAHistorialesAcademicos")
  }

  def detalle() {
    def Payment = pagoService.obtenerPagoParaValidarComprobante(params.long('id'))
    def dependiente = Payable.withCriteria {
      pagos {
        eq "id", pago.id
      }
    }
    def perfil = perfilService.obtenerPerfilDeUsuario(dependiente.usuario.perfil.first().id)
    [pago: pago, perfil:perfil] 
  }

  def comprobantePagoMes(){
    def pago = pagoService.obtenerPagoParaValidarComprobante(params.long('id'))
    def dependiente = Payable.withCriteria {
      pagos {
        eq "id", pago.id
      }
    }
    [pago: pago]
  }

  def descargarComprobante(){
    response.setContentType("application/octet-stream");
    response.setHeader "Content-disposition", "attachment; filename=Comprobante";
    response.outputStream <<  proofOfPaymentService.bytesOfProofOfPayment(params.pagoId)
  }

}
