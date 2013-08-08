package com.stele

import com.stele.seguridad.Usuario;
import com.stele.DistribucionInstitucional;
import com.stele.HistorialAcademico;
import com.stele.Pago
import com.stele.TipoDePago
import com.stele.EstatusDePago
import com.stele.Dependiente

class PagoService {


  def obtenerPagosDeUsuario(Usuario usuario) {
    def criteriaDependiente = Dependiente.createCriteria()
    def pagosDeUsuario = [] as Set 
    List<Dependiente> dependientesDeUsuario = criteriaDependiente.list {
        eq("usuario", usuario)
    }
    dependientesDeUsuario.each{ dependiente ->
      Dependiente dependienteExistente = dependiente.get(dependiente.id)
      pagosDeUsuario.addAll(dependienteExistente.pagos)
    }
    [dependiente: dependientesDeUsuario, pagos: pagosDeUsuario]
  }

  def obtenerPagosDeUnaInstitucion(Usuario usuario) {
    def institucionUsuario = usuario.instituciones
    def distribucionInstitucional = DistribucionInstitucional.withCriteria {
      'in'('institucion', institucionUsuario)
    }
    def historialAcademico = HistorialAcademico.withCriteria {
      'in'('distribucionInstitucional', distribucionInstitucional)
    }
    [dependiente: historialAcademico.dependiente, historial:historialAcademico]
  }

  def obtenerPagoParaValidarComprobante(Long pagoId) {
    def pago = Pago.findById(pagoId,[fetch:['comprobanteDePago':'join']])
    def historialAcademico = HistorialAcademico.findById(pago.historialAcademicoId)
    def dependiente = Dependiente.findById(historialAcademico.dependienteId)
    def perfil = Perfil.findById(dependiente.perfilId)
    [pago:pago, perfil:perfil]
  }


  def estadoDeCuentaUsuario(Usuario usuario) {
    def pagosVencidos = obtenerPagosVencidosDeUsuario(usuario)
    def pagosEnTiempo = obtenerPagosEnTiempoConDescuento(usuario)
    def pagosPorRealizar = obtenerPagosPorRealizar(usuario)
    def pagoMensual = obtenerPagosConciliadosFavorablemente(usuario)
    [pagosVencidos: pagosVencidos,
     pagosEnTiempo: pagosEnTiempo,
     pagosPorRealizar: pagosPorRealizar,
     pagoMensual:pagoMensual]

  }

  private def obtenerPagosVencidosDeUsuario(Usuario usuario) {
    def dependienteHistorial = obtenerDependientesEHistorialAcademicoPorTutor(usuario)

    def pagos = Pago.withCriteria {
      le('fechaDeVencimiento', new Date())
      'in'('historialAcademico', dependienteHistorial.historiales)
       eq('estatusDePago', EstatusDePago.CREADO)

    }
  }

  private def obtenerPagosEnTiempoConDescuento(Usuario usuario) {
    def dependienteHistorial = obtenerDependientesEHistorialAcademicoPorTutor(usuario)

    def pagos = Pago.withCriteria {
      ge('fechaDeVencimiento', new Date())
      'in'('historialAcademico', dependienteHistorial.historiales)
      eq('estatusDePago', EstatusDePago.CREADO)
      isNotEmpty("descuentos")
    } 
  }

  private def obtenerPagosPorRealizar(Usuario usuario) {
    def dependienteHistorial = obtenerDependientesEHistorialAcademicoPorTutor(usuario)

    def pagos = Pago.withCriteria {
      ge('fechaDeVencimiento', new Date())
      'in'('historialAcademico', dependienteHistorial.historiales)
      eq('estatusDePago', EstatusDePago.CREADO)
      isEmpty("descuentos")
    }   
  }

  private def obtenerPagosConciliadosFavorablemente(Usuario usuario) {
    def dependienteHistorial = obtenerDependientesEHistorialAcademicoPorTutor(usuario)

    def pagos = Pago.withCriteria {
      between("lastUpdated",getFirstAndLastDayOfMonth('first'), getFirstAndLastDayOfMonth('last'))
      'in'('historialAcademico', dependienteHistorial.historiales)
      eq('estatusDePago', EstatusDePago.PAGADO)

    }
    pagos
  }

  private def obtenerDependientesEHistorialAcademicoPorTutor(Usuario usuario) {
    def dependientesUsuario = Dependiente.withCriteria {
      'in'('usuario', usuario)
    }

    def historialAcademico = HistorialAcademico.withCriteria {
      'in'('dependiente', dependientesUsuario)
    } 

    [dependientes:dependientesUsuario, historiales: historialAcademico]
  }

  private def getFirstAndLastDayOfMonth(String indicador) {
    Calendar calendar = Calendar.getInstance()
    calendar.setTime(new Date())
    if (indicador.equals('first')) {
      new Date("${calendar.get(Calendar.YEAR)}/${calendar.get(Calendar.MONTH)+1}/01")
    } else {
      new Date("${calendar.get(Calendar.YEAR)}/${calendar.get(Calendar.MONTH)+1}/31")
    }
  }

}
