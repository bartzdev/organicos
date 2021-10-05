import 'package:organicos/modelo/grupo_usuario.dart';
import 'package:organicos/modelo/permissoes.dart';

class Usuario {
  int? id;
  GrupoUsuario? grupo;
  String? nome;
  String? login;
  String? senha;
  bool ativo = true;

  List<PermissaoUsuario> permissoes = List.empty(growable: true);

  bool operator ==(other) {
    return (other is Usuario && other.id == this.id);
  }

  @override
  int get hashCode => super.hashCode;
}
