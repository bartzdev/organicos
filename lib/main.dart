import 'package:flutter/material.dart';
import 'package:organicos/visao/pontosvenda/tela_pesquisa_pontovenda.dart';
import 'package:organicos/visao/tela_principal.dart';

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
      home: TelaPesquisaPontoVenda(),
    );
  }
}
