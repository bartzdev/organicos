import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/certificadora.dart';
import 'package:organicos/visao/pontosvenda/tela_cadastro_produto.dart';
import 'package:organicos/visao/widgets/mensagens.dart';
import 'package:organicos/visao/widgets/textformfield.dart';

class TelaCadastroCertificadora extends StatefulWidget{
   ControleCadastros<Certificadora> controle;
  Function()? onSaved;

  TelaCadastroCertificadora(this.controle, {Key? key, this.onSaved})
      : super(key: key);
  _TelaCadastroCertificadoraState createState() => _TelaCadastroCertificadoraState();
}

class _TelaCadastroCertificadoraState extends State<TelaCadastroCertificadora>{
var _chaveFormulario = GlobalKey<FormState>();

Future<void> Salvar(BuildContext context) async{
  if(_chaveFormulario.currentState != null &&
  _chaveFormulario.currentState!.validate()){
    widget.controle.salvarObjetoCadastroEmEdicao().then((value){
      if(widget.onSaved != null) widget.onSaved!();
      Navigator.of(context).pop();
    }).catchError((error){
      mensagemConexao(context);
    });
  }
}
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Cadastro Certificadora'),
      centerTitle: true,
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    floatingActionButton: FloatingActionButton.extended(
      icon: Icon(Icons.check),
      onPressed: (){
        salvar(context);
      }, label: Text('Salvar')),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _chaveFormulario,
              child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: decorationCampoTexto(
                    hintText: "Nome", labelText: "Nome"),
                    keyboardType: TextInputType.text,
                    initialValue: 
                    widget.controle.objetoCadastroEmEdicao?.nome,
                  onSaved: (String? value){
                    widget.controle.objetoCadastroEmEdicao?.nome = value;
                  },
                  validator: (value){
                    if(value == null || value.trim().isEmpty){
                      return "Este campo é obrigatório!";
                    }
                    return null;
                  },
                )
              ],
              ),
            ),)
        ],
      ),
  );
}
}