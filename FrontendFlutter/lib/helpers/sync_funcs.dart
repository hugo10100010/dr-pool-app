import 'package:proyecto/helpers/casillahorario_db.dart';
import 'package:proyecto/helpers/session_manager.dart';
import 'package:proyecto/helpers/syncmanager.dart';
import 'package:proyecto/models/casillahorario_model.dart';
import 'package:proyecto/models/clase_model.dart';
import 'package:proyecto/models/curso_model.dart';
import 'package:proyecto/models/paquete_model.dart';
import 'package:proyecto/models/usuario_model.dart';
import 'package:proyecto/services/auth_service.dart';
import 'package:proyecto/services/casillahorario_service.dart';
import 'package:proyecto/services/clase_servicio.dart';
import 'package:proyecto/services/curso_service.dart';
import 'package:proyecto/services/paquete_service.dart';
import 'package:proyecto/services/usuario_service.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

Future<int?> getLoggedInUserIdFromToken() async {
  final token = SessionManager().accessToken;

  if (token == null) return null;

  try {
    final decodedToken = JwtDecoder.decode(token);
    final identity = decodedToken['sub'];
    return identity is int ? identity : int.tryParse(identity.toString());
  } catch (e) {
    print('Token decode error: $e');
    return null;
  }
}

Future<void> adminCheckAndSync() async {
  final token = await AuthService.getAccessToken();
  if (token != null) {
    await SyncManager.sync<CasillaHorario>(
      tableName: 'casillahorario',
      fromJson: (json) => CasillaHorario.fromJson(json),
      onUpload: (item) async {
        if (item.id < 0) {
          bool success =
              await CasillahorarioService().agregarCasilla(item.toJson());

          return success;
        } else {
          bool success =
              await CasillahorarioService().modificarCasilla(item.toJson());
          return success;
        }
      },
      onDelete: (id) async {
        bool success = await CasillahorarioService().eliminarCasilla(id);
        {
          await AppDatabase.delete('casillahorario', id);
        }
        return success;
      },
    );
    await SyncManager.sync<Clase>(
      tableName: 'clase',
      fromJson: (json) => Clase.fromJson(json),
      onUpload: (item) async {
        if (item.id < 0) {
          bool success = await ClaseServicio().agregarClase(item.toJson());
          return success;
        } else {
          bool success = await ClaseServicio().modificarClase(item.toJson());
          return success;
        }
      },
      onDelete: (id) async {
        bool success = await ClaseServicio().eliminarClase(id);
        return success;
      },
    );
    await SyncManager.sync<Curso>(
      tableName: 'curso',
      fromJson: (json) => Curso.fromJson(json),
      onUpload: (item) async {
        if (item.id < 0) {
          bool success = await CursoServicio().agregarCurso(item.toJson());
          return success;
        } else {
          bool success = await CursoServicio().modificarCurso(item.toJson());
          return success;
        }
      },
      onDelete: (id) async {
        bool success = await CursoServicio().eliminarCurso(id);
        return success;
      },
    );
    await SyncManager.sync<Paquete>(
      tableName: 'paquete',
      fromJson: (json) => Paquete.fromJson(json),
      onUpload: (item) async {
        if (item.id < 0) {
          bool success = await PaqueteService().agregarPaquete(item.toJson());
          return success;
        } else {
          bool success = await PaqueteService().modificarPaquete(item.toJson());
          return success;
        }
      },
      onDelete: (id) async {
        bool success = await PaqueteService().eliminarPaquete(id);
        return success;
      },
    );
    await SyncManager.sync<Usuario>(
      tableName: 'usuario',
      fromJson: (json) => Usuario.fromJson(json),
      onUpload: (item) async {
        if (item.id < 0) {
          bool success = await UsuarioService().agregarUsuario(item.toJson());
          return success;
        } else {
          bool success = await UsuarioService().modificarUsuario(item.toJson());
          return success;
        }
      },
      onDelete: (id) async {
        bool success = await UsuarioService().eliminarUsuario(id);
        return success;
      },
    );
  }
}

Future<void> clienteCheckAndSync() async {
  final userId = await getLoggedInUserIdFromToken();
  if (userId == null) return;

  await SyncManager.sync<Usuario>(
    tableName: 'usuario',
    fromJson: (json) => Usuario.fromJson(json),
    onUpload: (item) async {
      return item.id < 0
          ? await UsuarioService().agregarUsuario(item.toJson())
          : await UsuarioService().modificarUsuario(item.toJson());
    },
    onDelete: (id) async {
      return await UsuarioService().eliminarUsuario(id);
    },
    filter: (usuario) => usuario.id == userId, // ✅ Only sync current user
  );
}

Future<void> coachCheckAndSync() async {
  final userId = await getLoggedInUserIdFromToken();
  if (userId == null) return;

  await SyncManager.sync<Clase>(
    tableName: 'clase',
    fromJson: (json) => Clase.fromJson(json),
    filter: (clase) => clase.idcoach == userId,
    onUpload: (item) async {
      if (item.id < 0) {
        print("${item.idcasilla} ${item.idcoach} ${item.idcurso}");
        print(item.toJson());
        bool success = await ClaseServicio().agregarClase(item.toJson());
        return success;
      } else {
        bool success = await ClaseServicio().modificarClase(item.toJson());
        return success;
      }
    },
    onDelete: (id) async {
      bool success = await ClaseServicio().eliminarClase(id);
      return success;
    },
  );
}
