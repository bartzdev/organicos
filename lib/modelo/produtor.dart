import 'dart:ffi';

import 'package:organicos/modelo/produtor_produto.dart';

import 'endereco.dart';
import 'certificadora.dart';
import 'grupo_produtor.dart';

class Produtor {
  int? id;
  Certificadora? certificadora;
  GrupoProdutor? grupo;
  Endereco? endereco = Endereco();
  String? nome;
  String? nomePropriedade;
  String? cpfCnpj;
  String? telefone;
  double? latitude;
  double? longitude;
  String? certificacaoOrganicos;
  bool vendaConsumidorFinal = true;
  bool ativo = true;

  List<ProdutorProduto> produtosAVenda = List.empty(growable: true);

  bool operator ==(other) {
    return (other is Produtor && other.id == this.id);
  }

  @override
  int get hashCode => super.hashCode;
}
