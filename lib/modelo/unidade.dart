class Unidade {
  int id = 0;
  String? nome;

  @override
  bool operator ==(other) {
    return (other is Unidade && other.id == this.id);
  }
}
