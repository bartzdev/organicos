import 'package:flutter/material.dart';
import 'package:organicos/visao/login/login.dart';
import 'package:organicos/visao/pesquisageral/pesquisa_geral.dart';
import 'package:organicos/visao/produtoprodutor/tela_cadastro_produtoprodutor.dart';
import 'package:organicos/visao/styles/styles.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Orgânicos',
      theme: temaGeralAppClaro,
      home: TelaCadastroProdutoProdutor(),
    );
  }
}
