import 'package:flutter/material.dart';
import 'package:organicos/visao/pontosvenda/tela_cadastro_produto.dart';
import 'package:organicos/visao/pontosvenda/tela_pesquisa_pontovenda.dart';
import 'package:organicos/visao/tela_principal.dart';

import 'dao/produto_dao.dart';
import 'modelo/produto.dart';
import 'modelo/tipo_produto.dart';

void main() {
  runApp(MyApp());
  Produto produto = new Produto();
  produto.tipo = new TipoProduto();
  produto.tipo?.id = 2;
  produto.nome = 'Alface';
  produto.descricao = 'Alface organico';
  produto.preco = 3.00;
  produto.unidade = '1';
  ProdutoDAO prodDAO = new ProdutoDAO();
  prodDAO.gravar(produto);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TelaCadastroProduto(),
    );
  }
}
