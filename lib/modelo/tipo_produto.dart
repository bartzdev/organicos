class TipoProduto {
  int? id;
  String? nome;
  bool ativo = true;

  bool operator ==(other) {
    return (other is TipoProduto && other.id == this.id);
  }

  @override
  int get hashCode => super.hashCode;
}
