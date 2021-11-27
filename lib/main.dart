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
<<<<<<< HEAD

    return MaterialApp(      
      home: Login(), 
      theme: ThemeData(
        primarySwatch: Colors.green),
       
=======
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TelaGerarRelatorio(),
>>>>>>> 04359634de6bcea8512132f458095c8c11a2c00b
    );
  }
}
