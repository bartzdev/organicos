import 'package:organicos/modelo/endereco.dart';

class GrupoProdutor {
  int? id;
  String? nome;
  Endereco? endereco = Endereco();
  String? cnpj;
  String? inscricaoEstadual;
  bool distribuidor = false;
  bool ativo = true;

  bool operator ==(other) {
    return (other is GrupoProdutor && other.id == this.id);
  }

  @override
  int get hashCode => super.hashCode;
}
