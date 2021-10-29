import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/certificadora.dart';

class TelaCadastroCertificadora extends StatefulWidget{
   ControleCadastros<Certificadora> controle;
  Function()? onSaved;

  TelaCadastroCertificadora(this.controle, {Key? key, this.onSaved})
      : super(key: key);
  _TelaCadastroCertificadoraState createState() => _TelaCadastroCertificadoraState();
}

class _TelaCadastroCertificadoraState extends State<TelaCadastroCertificadora>{
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Cadastro Certificadora'),
      centerTitle: true,
    ),
  );
}
}