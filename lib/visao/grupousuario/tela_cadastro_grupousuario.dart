import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/grupo_usuario.dart';
import 'package:organicos/visao/styles/styles.dart';
import 'package:organicos/visao/widgets/textformfield.dart';
import 'package:flutter/services.dart';

class TelaCadastroGrupoUsuario extends StatefulWidget {
  ControleCadastros<GrupoUsuario> controle;
  Function()? onSaved;

  TelaCadastroGrupoUsuario(this.controle, {Key? key, this.onSaved})
      : super(key: key);

  @override
  _TelaCadastroGrupoUsuarioState createState() =>
      _TelaCadastroGrupoUsuarioState();
}

class _TelaCadastroGrupoUsuarioState extends State<TelaCadastroGrupoUsuario> {
  var _chaveFormulario = GlobalKey<FormState>();

  Future<void> salvar(BuildContext context) async {
    if (_chaveFormulario.currentState != null &&
        _chaveFormulario.currentState!.validate()) {
      _chaveFormulario.currentState!.save();
      widget.controle.salvarObjetoCadastroEmEdicao().then((value) {
        if (widget.onSaved != null) widget.onSaved!();
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Cadastro de Grupos de Usuários'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            icon: const Icon(Icons.check),
            onPressed: () {
              salvar(context);
            },
            label: const Text('Salvar')),
        body: ListView(children: [
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
                        onSaved: (String? value) {
                          widget.controle.objetoCadastroEmEdicao?.nome = value;
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Este campo é obrigatório!";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ))
        ]));
  }
}
