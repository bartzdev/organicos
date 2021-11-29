import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/endereco.dart';
import 'package:organicos/modelo/grupo_produtor.dart';
import 'package:organicos/visao/certificadora/tela_pesquisa_certificadora.dart';
import 'package:organicos/visao/grupoprodutor/tela_pesquisa_grupoprodutos.dart';
import 'package:organicos/visao/pontosvenda/tela_pesquisa_pontovenda.dart';
import 'package:organicos/visao/relatorios/tela_relatorio_produtores.dart';
import 'package:organicos/visao/tela_principal.dart';
import 'package:organicos/visao/tipoProdutos/tela_pesquisa_tipoProduto.dart';

import 'dao/produto_dao.dart';
import 'modelo/produto.dart';
import 'modelo/tipo_produto.dart';
import 'package:organicos/visao/login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(      
      home: TelaGerarRelatorio(), 
      theme: ThemeData(
        primarySwatch: Colors.green)
    );
  }
}
