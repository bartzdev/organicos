class Certificadora {
  int? id;
  String? nome;
  bool ativo = true;

  bool operator ==(other) {
    return (other is Certificadora && other.id == this.id);
  }

  @override
  int get hashCode => super.hashCode;
}
