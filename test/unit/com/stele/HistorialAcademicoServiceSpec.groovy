package com.stele

import grails.test.mixin.*
import spock.lang.Specification
import spock.lang.Ignore
import com.stele.seguridad.Usuario
import com.makingdevs.*
import com.payable.*
/**
 * See the API for {@link grails.test.mixin.services.ServiceUnitTestMixin} for usage instructions
 */
@TestFor(HistorialAcademicoService)
@Mock([HistorialAcademico,Dependiente,DistribucionInstitucional,Institucion,Usuario,Perfil,Pago])
class HistorialAcademicoServiceSpec extends Specification {

  def "Registro de un historial academico con un dependiente y una distribucion institucional previamente registrados"(){
    given:"Dado un dependiente y una distribucion institucional ya existentes"
      def institucion = new Institucion()
      institucion.name = "Kinder Peques"
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
      usuarioExistente.save()
      def dependiente = new Dependiente()
      dependiente.matricula = "M0987654"
      dependiente.camada = "1234567898"
      dependiente.perfil = perfilExistente
      dependiente.usuario = usuarioExistente
      dependiente.save()
    when:"Guardo el historial academico"
      HistorialAcademico historialAcademico = service.preparaHistoricoAcademicoARegistrar(dependiente, distribucionInstitucional)
      historialAcademico = service.registrar(historialAcademico)
    then:"el id del dependiente debe ser mayor que 0"      
      assert historialAcademico.id > 0
  }

  def "Registro de un historial academico con un dependiente no registrado y una distribucion institucional previamente registrada"(){
    given:"Dado un dependiente y una distribucion institucional ya existentes"
      def institucion = new Institucion()
      institucion.name = "Kinder Peques"
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
      usuarioExistente.save()
      def dependiente = new Dependiente()
      dependiente.matricula = "M0987654"
      dependiente.camada = "1234567898"
      dependiente.perfil = perfilExistente
      dependiente.usuario = usuarioExistente
    when:"Preparo el historial academico para registrarlo sin un dependinete válido"
      HistorialAcademico historialAcademico = service.preparaHistoricoAcademicoARegistrar(dependiente, distribucionInstitucional)
    then: "Se intenta persistir el historial academico y la prueba debe fallar"
      shouldFail(RuntimeException) {
        historialAcademico = service.registrar(historialAcademico)
      }
  }

  def "Registro de un historial academico con un dependiente registrado y una distribucion institucional sin registrar"(){
    given:"Dado un dependiente y una distribucion institucional ya existentes"
      def institucion = new Institucion()
      institucion.name = "Kinder Peques"
      def distribucionInstitucional = new DistribucionInstitucional()
      distribucionInstitucional.grado = 2
      distribucionInstitucional.grupo = "B+"
      distribucionInstitucional.nivelDeEstudio = NivelDeEstudio.SECUNDARIA
      distribucionInstitucional.turno = Turno.VESPERTINO
      institucion.addToDistribucionesInstitucionales(distribucionInstitucional)
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
      usuarioExistente.save()
      def dependiente = new Dependiente()
      dependiente.matricula = "M0987654"
      dependiente.camada = "1234567898"
      dependiente.perfil = perfilExistente
      dependiente.usuario = usuarioExistente
      dependiente.save()
    when:"Preparo el historial academico para registrarlo sin una distribución institucional válida"
      HistorialAcademico historialAcademico = service.preparaHistoricoAcademicoARegistrar(dependiente, distribucionInstitucional)
    then: "Se intenta persistir el historial academico y la prueba debe fallar"
      shouldFail(RuntimeException) {
        historialAcademico = service.registrar(historialAcademico)
      }
  }

  def "Validar historial academico duplicados, mismo dependiente y distribución institucional"(){
    setup:"Se hace el registro de un hostorial academico a un dependiente especifico con una distribución institucional especifica"
      def institucion = new Institucion()
      institucion.name = "Kinder Peques"
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
      usuarioExistente.save()
      def dependiente = new Dependiente()
      dependiente.matricula = "M0987654"
      dependiente.camada = "1234567898"
      dependiente.perfil = perfilExistente
      dependiente.usuario = usuarioExistente
      dependiente.save()
      HistorialAcademico historialAcademico = service.preparaHistoricoAcademicoARegistrar(dependiente, distribucionInstitucional)
      HistorialAcademico historialAcademicoDuplicado = service.preparaHistoricoAcademicoARegistrar(dependiente, distribucionInstitucional)
      historialAcademico = service.registrar(historialAcademico)
    when:"Se intenta registrar otro historial academico con el mismo dependiente y la misma distribución institucional"
      historialAcademicoDuplicado = service.registrar(historialAcademicoDuplicado)
    then:"Se debe obtener el historial academico registrado previamente"      
      assert historialAcademico.equals(historialAcademicoDuplicado)
  }

  @Ignore
  def "validar la busqueda de historiales de una institucion"() {
    given: 
      Pago pago = new Pago()
      pago.cantidadDePago = 1000
      pago.save(validate:false)
    and:
      DistribucionInstitucional distribucionInstitucional = new DistribucionInstitucional()
    and:
      Institucion institucion = new Institucion()
      institucion.addToDistribucionesInstitucionales(distribucionInstitucional)
      institucion.save(flush:true)
    and:
      HistorialAcademico historial = new HistorialAcademico()
      historial.distribucionInstitucional = distribucionInstitucional
      historial.save(validate:false)
    and:
      Usuario.metaClass.isDirty = { true }
      Usuario.metaClass.encodePassword = {"password"}
      Usuario user = new Usuario()
      user.username = "s@s.com"
      user.password = "12345678"
      user.addToInstituciones(institucion)
      user.save(validate:false)
    and:
      Dependiente dependiente = new Dependiente()
      dependiente.addToPagos(pago)
      dependiente.addToHistorialAcademico(historial)
      dependiente.usuario = user
      dependiente.save(validate:false)
    when: "Se buscara los historiales academicos asociados a la institucion"
      def historialesYPagos = service.obtenerHistorilesAcademicosDelaInstitucion(user)
    then:
      assert historialesYPagos.first().id > 0
      assert historialesYPagos.first().dependiente.pagos.first().cantidadDePago == 1000
  }

}
