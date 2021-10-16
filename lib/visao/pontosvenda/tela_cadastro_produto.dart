import 'package:flutter/material.dart';

class TelaCadastroProduto extends StatefulWidget {
  TelaCadastroProduto({Key? key}) : super(key: key);

  @override
  _TelaCadastroProdutoState createState() => _TelaCadastroProdutoState();
}

class _TelaCadastroProdutoState extends State<TelaCadastroProduto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      centerTitle: true,
      title: Text('Cadastro de Produto'),
    ));
  }
}
