abstract class CustomMessages {
  late String mensaje;
}

// Mensajes genéricos
class mGenericos extends CustomMessages {
  static const String rExitosa = 'Respuesta Exitosa';
  static const String falloConexion = 'Error Conexion';
  static const String sinRespuestaApi = 'Sin Respuesta de la API. Código: ';
  static const String documentosNoEncontrados =
      'Documentos no encontrados. Código: ';
  static const String verificarCedulas = 'Por favor, verificar cédulas.';
  static const String sinDatos = 'No se encontraron datos.';
  static const String estadoDesconocido = 'Estado desconocido.';
  static const String reintentar = 'Reintentar';
  static const String errorGenerico = 'El tiket cuenta con una Salida';
}

// Mensajes relacionados con permisos
class mPermisos extends CustomMessages {
  static const String sinPermisosCorrectos =
      'Una o ambas cédulas no tienen los permisos correctos.';
  static const String permisosValidados = 'Permisos validados correctamente.';
  static const String ingresarCedulasValidas =
      'Por favor, ingrese cédulas válidas (solo números).';
  static const String errorValidarPermisos = 'Error al validar permisos: ';
  static const String permisoEntregaIncorrecto = 'Permiso de entrega inválido.';
  static const String permisoCambiobdIncorrecto =
      'Sin Autorizacion Para Cambio de Base de Datos';
  static const String permisoRecibeIncorrecto =
      'Permiso de recepción inválido.';
}

// Mensajes relacionados con escaneo
class mEscaneo extends CustomMessages {
  static const String permisoCamaraDenegado = 'Permiso de cámara denegado';
  static const String errorEscaneo = 'Error al escanear: ';
  static const String errorDesconocido = 'Error desconocido: ';
  static const String noSePudoEscanear =
      'No se pudo leer el código de barras. Intenta de nuevo.';
  static const String codigo =
      'El Codigo del Tiket no corresponde al Consecutivo registrado.';
}

// Mensajes específicos para UsuarioController
class mUsuario extends CustomMessages {
  static const String usuarioNoEncontrado = 'Usuario no encontrado o inválido.';
}

// Método utilitario para errores
class UtilidadesMensajes {
  static String mensajeError(dynamic response) {
    if (response == null) {
      return 'Error en la conexión: No se recibió respuesta.';
    } else {
      return 'Error en la solicitud. Código de estado: ${response.statusCode}';
    }
  }
}
