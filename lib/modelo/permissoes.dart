import 'package:organicos/modelo/grupo_usuario.dart';
import 'package:organicos/modelo/usuario.dart';

class Permissao {
  int? id;
  String? nome;

  bool operator ==(other) {
    return (other is Permissao && other.id == this.id);
  }

  @override
  int get hashCode => super.hashCode;
}

class PermissaoUsuario {
  Permissao? permissao;
  Usuario? usuario;
  bool permitido = true;

  bool operator ==(other) {
    return (other is PermissaoUsuario && other.permissao == this.permissao);
  }

  @override
  int get hashCode => super.hashCode;
}

class PermissaoGrupo {
  Permissao? permissao;
  GrupoUsuario? grupo;
  bool permitido = true;

  bool operator ==(other) {
    return (other is PermissaoGrupo && other.permissao == this.permissao);
  }

  @override
  int get hashCode => super.hashCode;
}
