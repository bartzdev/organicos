import 'package:organicos/modelo/tipo_produto.dart';
import 'package:organicos/modelo/unidade.dart';

class Produto {
  int? id;
  TipoProduto? tipo;
  String? nome;
  String? descricao;
  double? preco;
  Unidade? unidade;
  bool ativo = true;
  @override
  bool operator ==(other) {
    return (other is Produto && other.id == this.id);
  }

  @override
  int get hashCode => super.hashCode;
}
