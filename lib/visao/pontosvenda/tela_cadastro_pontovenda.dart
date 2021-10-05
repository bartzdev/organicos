import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/ponto_venda.dart';

class TelaCadastroPontoVenda extends StatefulWidget {
  ControleCadastros<PontoVenda> controle;
  TelaCadastroPontoVenda(this.controle, {Key? key}) : super(key: key);

  @override
  _TelaCadastroPontoVendaState createState() => _TelaCadastroPontoVendaState();
}

class _TelaCadastroPontoVendaState extends State<TelaCadastroPontoVenda> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cadastro de Ponto de Venda'),
      ),
    );
  }
}
