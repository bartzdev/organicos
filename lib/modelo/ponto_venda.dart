import 'package:organicos/modelo/endereco.dart';

class PontoVenda {
  int? id;
  String? nome;
  Endereco? endereco = Endereco();
  bool ativo = true;

  bool operator ==(other) {
    return (other is PontoVenda && other.id == this.id);
  }

  @override
  int get hashCode => super.hashCode;
}
