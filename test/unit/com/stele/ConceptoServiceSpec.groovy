package com.stele

import grails.test.mixin.*
import spock.lang.Specification
import com.stele.seguridad.Usuario
import com.makingdevs.*

@TestFor(ConceptoService)
@Mock([Institucion,Usuario,DistribucionInstitucional,Concepto,Perfil])
class ConceptoServiceSpec extends Specification {

    def "Obtener un listado de los conceptos ligados a una Institucion"() {
  given: "Se crearan 2 conceptos asociados a una Institucion deacuerdo al Usuario"
    def institucion = new Institucion()
    institucion.nombre = "Escuela primaria de Springfild"
    def distribucionInstitucional = new DistribucionInstitucional()
    distribucionInstitucional.grado = 4
    distribucionInstitucional.grupo = "B+"
    distribucionInstitucional.nivelDeEstudio = NivelDeEstudio.SECUNDARIA
    distribucionInstitucional.turno = Turno.VESPERTINO
    institucion.addToDistribucionesInstitucionales(distribucionInstitucional)
    institucion.save(flush:true)
    Usuario.metaClass.isDirty = { true }
    Usuario.metaClass.encodePassword = {"password"}
    def usuario = new Usuario()
    def perfilUsuario = new Perfil()
    def concepto1 = new Concepto()
    def concepto2 = new Concepto()
    usuario.id = 1033
    usuario.username = "sergio@makingdevs.com"
    usuario.password = UUID.randomUUID().toString().replaceAll('-', '').substring(0,10)
    usuario.enabled = true
    perfilUsuario.nombre = "Jose"
    perfilUsuario.apellidoPaterno = "Hernandez"
    perfilUsuario.apellidoMaterno = "Solis"
    perfilUsuario.save(flush:true)
    usuario.perfil = perfilUsuario
    usuario.addToInstituciones(institucion)
    usuario.save(flush:true)
    concepto1.id = 1
    concepto1descripcion = "Colegiatura"
    concepto1.institucion = institucion
    concepto1.save(flush:true)
    concepto2.id = 2
    concepto2descripcion = "Primera colegiatura"
    concepto2.institucion = institucion
    concepto2.save(flush:true)
    def query = "giat"
  when: "Se realiza la llamada al metodo buscarConceptosDeUnaInstitucion"
    def conceptoInstitucion = service.buscarConceptosDeUnaInstitucion(usuario, query)
  then: "la cantidad de conceptos debe de ser igual a 2"
    assert conceptoInstitucion.size() == 2

    }

    def "Al guardar un concepto de pago generado que no existe se debe de crear"(){
  given: "Se verificara que el concepto que se recibe no exista en la base de datos"
    def institucion = new Institucion()
    institucion.nombre = "Escuela primaria de Springfild"
    def distribucionInstitucional = new DistribucionInstitucional()
    distribucionInstitucional.grado = 4
    distribucionInstitucional.grupo = "B+"
    distribucionInstitucional.nivelDeEstudio = NivelDeEstudio.SECUNDARIA
    distribucionInstitucional.turno = Turno.VESPERTINO
    institucion.addToDistribucionesInstitucionales(distribucionInstitucional)
    institucion.save(flush:true)
    Usuario.metaClass.isDirty = { true }
    Usuario.metaClass.encodePassword = {"password"}
    def usuario = new Usuario()
    def perfilUsuario = new Perfil()
    def concepto1 = new Concepto()
    def concepto2 = new Concepto()
    usuario.id = 1033
    usuario.username = "sergio@makingdevs.com"
    usuario.password = UUID.randomUUID().toString().replaceAll('-', '').substring(0,10)
    usuario.enabled = true
    perfilUsuario.nombre = "Jose"
    perfilUsuario.apellidoPaterno = "Hernandez"
    perfilUsuario.apellidoMaterno = "Solis"
    perfilUsuario.save(flush:true)
    usuario.perfil = perfilUsuario
    usuario.addToInstituciones(institucion)
    usuario.save(flush:true)
    String descripcionConcepto = "concepto no existente"
  when: "se Realiza la llamada al servicio que verifica la existencia del concepto"
    def resultadoBusquedaConcepto = service.verificarConceptoPagoExistente(descripcionConcepto)
    def conceptoGuardado = service.guardarConceptoDePagoGenerado(usuario, descripcionConcepto)
  then:
    assert resultadoBusquedaConcepto == false
    assert conceptoGuardado.id == 1
    assert conceptoGuardadodescripcion =="concepto no existente"
    }

    def "Al guardar un concepto de pago generado que ya existe no se debe de crear"(){
  given: "Se creara tanto el usuario como un concepto"
    def institucion = new Institucion()
    institucion.nombre = "Escuela primaria de Springfild"
    def distribucionInstitucional = new DistribucionInstitucional()
    distribucionInstitucional.grado = 4
    distribucionInstitucional.grupo = "B+"
    distribucionInstitucional.nivelDeEstudio = NivelDeEstudio.SECUNDARIA
    distribucionInstitucional.turno = Turno.VESPERTINO
    institucion.addToDistribucionesInstitucionales(distribucionInstitucional)
    institucion.save(flush:true)
    Usuario.metaClass.isDirty = { true }
    Usuario.metaClass.encodePassword = {"password"}
    def usuario = new Usuario()
    def perfilUsuario = new Perfil()
    def concepto1 = new Concepto()
    def concepto2 = new Concepto()
    usuario.id = 1033
    usuario.username = "sergio@makingdevs.com"
    usuario.password = UUID.randomUUID().toString().replaceAll('-', '').substring(0,10)
    usuario.enabled = true
    perfilUsuario.nombre = "Jose"
    perfilUsuario.apellidoPaterno = "Hernandez"
    perfilUsuario.apellidoMaterno = "Solis"
    perfilUsuario.save(flush:true)
    usuario.perfil = perfilUsuario
    usuario.addToInstituciones(institucion)
    usuario.save(flush:true)
    concepto1.id = 1
    concepto1descripcion = "Colegiatura"
    concepto1.institucion = institucion
    concepto1.save(flush:true)    
    String descripcionConcepto = "Colegiatura"    
  when:
    def resultadoBusquedaConcepto = service.verificarConceptoPagoExistente(descripcionConcepto)
  then:
    assert resultadoBusquedaConcepto == true
    }

}