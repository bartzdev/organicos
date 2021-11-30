class Unidade {
  int id = 0;
  String? nome;
  bool ativo = true;

  @override
  bool operator ==(other) {
    return (other is Unidade && other.id == this.id);
  }
}
