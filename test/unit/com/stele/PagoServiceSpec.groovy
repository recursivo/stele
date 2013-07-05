package com.stele

import grails.test.mixin.*
import spock.lang.Specification
import com.stele.seguridad.Usuario

/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(PagoService)
@Mock([HistorialAcademico,Dependiente,DistribucionInstitucional,Institucion,Usuario,Perfil,Pago])
class PagoServiceSpec extends Specification {
	def "Obtener todos los pagos ligados a un usuario existente"() {
    given: "Se crean dos pagos asociados a un determinado usuario con un dependiente asosiado"
      def institucion = new Institucion()
      institucion.nombre = "Kinder Peques"
      def distribucionInstitucional = new DistribucionInstitucional()
      distribucionInstitucional.grado = 2
      distribucionInstitucional.grupo = "B+"
      distribucionInstitucional.nivelDeEstudio = NivelDeEstudio.SECUNDARIA
      distribucionInstitucional.turno = Turno.VESPERTINO
      institucion.addToDistribucionesInstitucionales(distribucionInstitucional)
      institucion.save(flush:true)
      Usuario.metaClass.isDirty = { true } 
      Usuario.metaClass.encodePassword = { "password" } 
      def usuarioExistente = new Usuario()
      def perfilExistente = new Perfil()
      usuarioExistente.id = 1001
      usuarioExistente.username = "pepito@gmail.com"
      usuarioExistente.password = UUID.randomUUID().toString().replaceAll('-', '').substring(0,10)
      usuarioExistente.enabled = true
      perfilExistente.nombre = "Pepito"
      perfilExistente.apellidoPaterno = "Juarez"
      perfilExistente.apellidoMaterno = "Juarez"
      perfilExistente.save()
      usuarioExistente.perfil = perfilExistente
      usuarioExistente.save(flush:true)
      def dependiente = new Dependiente()
      dependiente.matricula = "M0987654"
      dependiente.camada = "1234567898"
      dependiente.perfil = perfilExistente
      dependiente.usuario = usuarioExistente
      dependiente.save()
      HistorialAcademico historialAcademico = new HistorialAcademico()
      historialAcademico.distribucionInstitucional = distribucionInstitucional
      historialAcademico.dependiente = dependiente
      historialAcademico.save(flush:true)
      Pago pagoUno = new Pago()
      Pago pagoDos = new Pago()
      pagoUno.conceptoDePago = "Pago 1"
      pagoDos.conceptoDePago = "Pago 2"
      pagoUno.cantidadDePago = 12345678
      pagoDos.cantidadDePago = 87654321
      pagoUno.fechaDePago = new Date()
      pagoDos.fechaDePago = new Date()
      pagoUno.historialAcademico = historialAcademico
      pagoDos.historialAcademico = historialAcademico
      dependiente.addToPagos(pagoUno)
      dependiente.addToPagos(pagoDos)
      dependiente.save(flush:true)
    when: "Se hace la llamada al metodo obtenerPagosDeUsuario"    
      def pagosDeUusario = service.obtenerPagosDeUsuario(usuarioExistente)
    then: "La cantidad de pagos debe ser igual a 2"
      assert pagosDeUusario.size() > 0
	}
}