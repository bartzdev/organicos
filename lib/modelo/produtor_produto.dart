import 'package:flutter/material.dart';
import 'package:organicos/modelo/ponto_venda.dart';
import 'package:organicos/modelo/produto.dart';
import 'package:organicos/modelo/produtor.dart';

class ProdutorProduto {
  int? id;
  Produtor? produtor;
  Produto? produto;
  PontoVenda? pontoVenda;
  int? diaSemana;
  TimeOfDay? horario;
  bool anuncioPausado = false;

  bool operator ==(other) {
    return (other is ProdutorProduto && other.id == this.id);
  }

  @override
  int get hashCode => super.hashCode;
}
