import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/tipo_produto.dart';
import 'package:organicos/modelo/unidade.dart';
import 'package:organicos/visao/widgets/mensagens.dart';
import 'package:organicos/visao/widgets/textformfield.dart';

class TelaCadastroUnidade extends StatefulWidget {
  ControleCadastros<Unidade> _controle;
  Function()? onSaved;

  TelaCadastroUnidade(this._controle, {Key? key, this.onSaved})
      : super(key: key);
  _TelaCadastroUnidadeState createState() => _TelaCadastroUnidadeState();
}

class _TelaCadastroUnidadeState extends State<TelaCadastroUnidade> {
  @override
  Widget build(BuildContext context) {
    var _chaveFormulario = GlobalKey<FormState>();

    Future<void> Salvar(BuildContext context) async {
      if (_chaveFormulario.currentState != null &&
          _chaveFormulario.currentState!.validate()) {
        _chaveFormulario.currentState!.save();
        widget._controle.salvarObjetoCadastroEmEdicao().then((value) {
          if (widget.onSaved != null) widget.onSaved!();
          Navigator.of(context).pop();
        }).catchError((error) {
          mensagemConexao(context);
        });
      }
    }

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('Cadastro de Unidade'),
          centerTitle: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            icon: Icon(Icons.check),
            onPressed: () {
              Salvar(context);
            },
            label: Text('Salvar')),
        body: ListView(children: [
          Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                  key: _chaveFormulario,
                  child: Column(children: <Widget>[
                    TextFormField(
                        decoration: decorationCampoTexto(
                            hintText: "Nome", labelText: "Nome"),
                        keyboardType: TextInputType.text,
                        initialValue:
                            widget._controle.objetoCadastroEmEdicao?.nome,
                        onSaved: (String? value) {
                          widget._controle.objetoCadastroEmEdicao?.nome = value;
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Este campo ?? obrigat??rio!";
                          }
                          return null;
                        }),
                  ])))
        ]));
  }
}
