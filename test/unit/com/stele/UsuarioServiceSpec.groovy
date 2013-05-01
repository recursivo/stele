package com.stele

import static org.junit.Assert.*

import grails.test.mixin.*
import grails.test.mixin.support.*
import org.junit.*
import spock.lang.Specification
import com.stele.seguridad.Usuario

@TestFor(UsuarioService)
@Mock([Usuario, Perfil])
class UsuarioServiceSpec  extends Specification{

    def "Obtener un usuario apartir de un command leeido desde un excel"(){
      given:
        def filaExcelCommand = new FilaExcelCommand(datosBasicos) 
      when:
        def usuario = service.obtenerUsuarioDesdeCommand(filaExcelCommand)
      then:
        assert usuario.username == usernameEsperado
        assert usuario.password == passwordEsperado
        assert usuario.enabled
        assert !usuario.accountExpired
        assert !usuario.accountLocked
        assert !usuario.passwordExpired
        assert usuario.perfil.nombre == nombreEsperado
        assert usuario.perfil.apellidoPaterno == apellidoPaternoEsperado
        assert usuario.perfil.apellidoMaterno == apellidoMaternoEsperado
        assert usuario.perfil.telefonos*.numeroTelefonico.flatten() == [numeroTelefonicoEsperado]
      where:
        datosBasicos << [
          [tutorNombre:"Rodrigo",tutorApellidoPaterno:"Martínez",tutorApellidoMaterno:"García",correoElectronico:"rockdrigo.mtz@gmail.com",telefono:"123456789"],
          [tutorNombre:"Juan",tutorApellidoPaterno:"Perez",tutorApellidoMaterno:"Perez",correoElectronico:"j.perez@gmail.com",telefono:"987654321"]
        ]
        nombreEsperado << [
          "Rodrigo",
          "Juan"
        ]
        apellidoPaternoEsperado << [
          "Martínez",
          "Perez"
        ]
        apellidoMaternoEsperado << [
          "García",
          "Perez"
        ]
        usernameEsperado << [
          "rockdrigo.mtz@gmail.com",
          "j.perez@gmail.com"
        ]
        numeroTelefonicoEsperado << [
          "123456789",
          "987654321"
        ]
        passwordEsperado << [
          "roro6789",
          "juj.4321"
        ]
    }

    def "Registrar un usuario verificando que no exista"(){
      given: "Un usuario con datos"
        def usuario = new Usuario()
        def perfil = new Perfil()
        def telefono = new Telefono()
        usuario.username = "pepito@gmail.com"
        usuario.password = "pepe6789"
        usuario.enabled = true
        perfil.nombre = "Pepito"
        perfil.apellidoPaterno = "Juarez"
        perfil.apellidoMaterno = "Juarez"
        telefono.numeroTelefonico = "123456789"
        perfil.addToTelefonos(telefono)
        usuario.perfil = perfil
      when: "Guardamos el usuario con el servicio"
        usuario = service.registrar(usuario)
      then: "El id debe ser mayor que 0"
        assert usuario.id > 0
    }

    def "No registrar un usuario ya existente"(){
      given: "Un usuario ya existente y "
        Usuario.metaClass.isDirty = { true } 
        Usuario.metaClass.encodePassword = { "password" } 
        def usuarioExistente = new Usuario()
        def perfilExistente = new Perfil()
        def telefono = new Telefono()
        usuarioExistente.id = 1001
        usuarioExistente.username = "pepito@gmail.com"
        usuarioExistente.password = "pepe6789"
        usuarioExistente.enabled = true
        perfilExistente.nombre = "Pepito"
        perfilExistente.apellidoPaterno = "Juarez"
        perfilExistente.apellidoMaterno = "Juarez"
        telefono.numeroTelefonico = "123456789"
        perfilExistente.addToTelefonos(telefono)
        usuarioExistente.perfil = perfilExistente
        service.registrar(usuarioExistente)
        def contador = Usuario.count()
      and: "Un usuario con datos"
        def usuario = new Usuario()
        def perfil = new Perfil()
        usuario.username = "pepito@gmail.com"
        usuario.password = UUID.randomUUID().toString().replaceAll('-', '').substring(0,10)
        usuario.enabled = true
        usuario.password = "pepe6789"
        perfil.nombre = "Pepito"
        perfil.apellidoPaterno = "Juarez"
        perfil.apellidoMaterno = "Juarez"
        telefono.numeroTelefonico = "123456789"
        perfil.addToTelefonos(telefono)
        usuario.perfil = perfil
      when: "Se intenta guardar el usuario"
        usuario = service.registrar(usuario)
      then: "El id debe ser igual a 1001"
        assert usuario.id == 1001
        assert contador == Usuario.count()
    }
    
}
