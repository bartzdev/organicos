import 'package:organicos/modelo/permissoes.dart';

class GrupoUsuario {
  int? id;
  String? nome;
  bool ativo = true;

  List<PermissaoGrupo> permissoes = List.empty(growable: true);

  bool operator ==(other) {
    return (other is GrupoUsuario && other.id == this.id);
  }

  @override
  int get hashCode => super.hashCode;
}
