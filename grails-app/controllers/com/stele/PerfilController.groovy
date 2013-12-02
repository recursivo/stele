package com.stele

import com.makingdevs.*
import grails.converters.JSON

class PerfilController {

  def springSecurityService
  def perfilService
  def cuentasBancariasService

  def index() {
    def usuarioActual = springSecurityService.currentUser
    def cuentasBancariasExistentes = cuentasBancariasService.obtenerCuentasExistentesPorInstitucion(springSecurityService.currentUser.instituciones?.first())
    [usuarioActual : usuarioActual,
     electronica : cuentasBancariasExistentes.transferencias,
     cheque : cuentasBancariasExistentes.cheques,
     ficha : cuentasBancariasExistentes.ficha]
  }

  def administrador(){
    def usuarioActual = springSecurityService.currentUser
    def cuentasBancariasExistentes = cuentasBancariasService.obtenerCuentasExistentesPorInstitucion(springSecurityService.currentUser.instituciones?.first())
    [usuarioAdministrador : usuarioActual,
     electronica : cuentasBancariasExistentes.electronica,
     cheque : cuentasBancariasExistentes.cheque,
     ficha : cuentasBancariasExistentes.ficha]
  }

  def actualizarPassword(UpdatePasswordCommand upc) {
    if(upc.hasErrors()) {
      render upc.errors
      return 
    }
    perfilService.actualizarPasswordForUser(upc.nuevaContrasenia, springSecurityService.currentUser)
    def role = springSecurityService.principal.authorities.first()
    if(role.toString() == ("ROLE_DIRECTOR"))
     redirect (controller:'perfil', action:'administrador')
    else
     redirect controller:'perfil'
  }

  def actualizarFechaNacimiento() {
    def perfil = Perfil.get(params.id)
    perfil.fechaDeNacimiento = new Date().parse("dd/MM/yyyy",params.fechaNacimiento)
    perfil.save()
  }

  def uploadImage(){
    def perfil = perfilService.subirImagenPerfil(params.long('id'), params.file)
    render perfil as JSON
  }

}

class UpdatePasswordCommand {

  String nuevaContrasenia
  String confirmaContrasenia

  static constraints = {
    nuevaContrasenia blank:false, nullable : false, minSize:6
    confirmaContrasenia blank:false, nullable : false, minSize:6, validator: { value, obj -> 
      value.size() == obj.nuevaContrasenia.size() && value == obj.nuevaContrasenia
    }
  }
}