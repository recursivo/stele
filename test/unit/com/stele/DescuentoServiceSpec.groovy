package com.stele

import grails.test.mixin.*
import spock.lang.Specification
import com.stele.seguridad.Usuario

@TestFor(DescuentoService)
@Mock([Institucion, Usuario, DistribucionInstitucional, Descuento, Perfil])
class DescuentoServiceSpec extends Specification {

    def "Obtener todos los descuentos ligados a una Institucion"() {
  given: "Se crea un una institucion y un usuario asociado a dicha institucion, se creara un descuneto asociado a la institucion"
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
    def descuento = new Descuento()
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
    usuario.save()
    descuento.id = 1
    descuento.nombreDeDescuento = "Pago anticipado"
    descuento.porcentaje = 10
    descuento.cantidad = 100
    descuento.fechaDeVencimiento = new java.util.Date(2013, 9, 15, 8, 15, 23);
    descuento.institucion = institucion
    descuento.save(flush:true)
  when: "Se realiza la llamada al metodo buscarDescuentosDeUnaInstitucion"
    def descuentoInstitucion = service.buscarDescuentosDeUnaInstitucion(usuario)
  then: "La cantidad de descuentos debe ser igual a 1"
    assert descuentoInstitucion.size() == 1

  }

}