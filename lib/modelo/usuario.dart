import 'package:organicos/modelo/grupo_usuario.dart';
import 'package:organicos/modelo/permissoes.dart';

class Usuario {
  int? id;
  GrupoUsuario? grupo;
  String? nome;
  String? email;
  String? login;
  String? senha;
  bool ativo = true;

  List<PermissaoUsuario> permissoes = List.empty(growable: true);
  bool operator ==(other) {
    return (other is Usuario && other.id == this.id);
  }

  bool possuiPermissao(int id_per) {
    for (PermissaoUsuario per in permissoes) {
      if (id_per == per.permissao?.id) {
        if (per.permitido == null && grupo != null) {
          for (PermissaoGrupo perGrupo in grupo!.permissoes) {
            if (id_per == perGrupo.permissao?.id) {
              return perGrupo.permitido;
            }
          }
        } else
          return per.permitido!;
      }
    }
    return false;
  }

  @override
  int get hashCode => super.hashCode;
}
