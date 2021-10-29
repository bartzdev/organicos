import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/endereco.dart';
import 'package:organicos/modelo/grupo_produtor.dart';
import 'package:organicos/visao/grupoprodutor/tela_pesquisa_grupoprodutos.dart';
import 'package:organicos/visao/pontosvenda/tela_cadastro_produto.dart';
import 'package:organicos/visao/pontosvenda/tela_pesquisa_pontovenda.dart';
import 'package:organicos/visao/tela_principal.dart';

import 'dao/produto_dao.dart';
import 'modelo/produto.dart';
import 'modelo/tipo_produto.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TelaPesquisaGrupoProdutor(),
    );
  }
}
