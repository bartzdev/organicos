import 'package:organicos/modelo/tipo_produto.dart';

class Produto {
  int? id;
  TipoProduto? tipo;
  String? nome;
  String? descricao;
  double? preco;
  String? unidade;
  bool ativo = true;

  bool operator ==(other) {
    return (other is Produto && other.id == this.id);
  }

  @override
  int get hashCode => super.hashCode;
}
