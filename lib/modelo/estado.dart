class Estado {
  int? id;
  String? nome;
  String? sigla;

  bool operator ==(other) {
    return (other is Estado && other.id == this.id);
  }

  @override
  int get hashCode => super.hashCode;
}
