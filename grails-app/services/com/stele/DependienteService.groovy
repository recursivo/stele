package com.stele

import com.stele.seguridad.Usuario
import com.makingdevs.*

class DependienteService {

  def perfilService

  def obtenerDependienteDesdeCommand(FilaExcelCommand filaExcelCommand) {
    def perfil = new Perfil()
    perfil.nombre = filaExcelCommand.dependienteNombre
    perfil.apellidoPaterno = filaExcelCommand.dependienteApellidoPaterno
    perfil.apellidoMaterno = filaExcelCommand.dependienteApellidoMaterno
    def dependiente = new Dependiente()
    dependiente.matricula = filaExcelCommand.matricula
    dependiente.perfil = perfil
    dependiente
  }

  def obtenerDependienteDesdeCommand(InscripcionCommand incs) {
    def perfil = new Perfil()
    def dependiente = new Dependiente()
    perfil.nombre = incs.nombreAlumno
    perfil.apellidoPaterno = incs.apellidoPaternoAlumno
    perfil.apellidoMaterno = incs.apellidoMaternoAlumno
    dependiente.matricula = incs.matricula
    dependiente.perfil = perfil
    dependiente
  }

  Dependiente registrar(Dependiente dependiente, Long usuarioId){
    Usuario usuario = Usuario.get(usuarioId)
    if(usuario){
      def dependienteExistente = Dependiente.findByMatricula(dependiente.matricula)
      if(dependienteExistente){
        return dependienteExistente
      }else{
        dependiente.perfil = perfilService.registrar(dependiente.perfil)
        usuario.addToDependientes(dependiente)
        usuario.save()
        println dependiente.id
        return dependiente
      }
    }else{
      throw RuntimeException("Se intentó persistir un dependiente con un usuario inválido...")
    }
  }

}
