import 'estado.dart';

class Cidade {
  int? id;
  String? nome;
  Estado? estado;

  bool operator ==(other) {
    return (other is Cidade && other.id == this.id);
  }

  @override
  int get hashCode => super.hashCode;
}
