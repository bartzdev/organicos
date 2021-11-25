import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/grupo_usuario.dart';
import 'package:organicos/modelo/usuario.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/grupo_usuario.dart';
import 'package:organicos/visao/cidades/tela_pesquisa_cidades.dart';
import 'package:organicos/visao/styles/styles.dart';
import 'package:organicos/visao/widgets/textformfield.dart';
import 'package:flutter/services.dart';

class TelaCadastroUsuario extends StatefulWidget {
  ControleCadastros<Usuario> controle;
  Function()? onSaved;

  TelaCadastroUsuario(this.controle, {Key? key, this.onSaved})
      : super(key: key);

  @override
  _TelaCadastroUsuarioState createState() => _TelaCadastroUsuarioState();
}

class _TelaCadastroUsuarioState extends State<TelaCadastroUsuario> {
  ControleCadastros<GrupoUsuario> controlegrupos =
      ControleCadastros(GrupoUsuario());
  var _chaveFormulario = GlobalKey<FormState>();

  bool _obscureText = true;

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
          title: Text('Cadastro de Usuário'),
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
                    espacoEntreCampos,
                    TextFormField(
                        decoration: decorationCampoTexto(
                            hintText: "Login", labelText: "Login"),
                        keyboardType: TextInputType.text,
                        initialValue:
                            widget.controle.objetoCadastroEmEdicao?.login,
                        onSaved: (String? value) {
                          widget.controle.objetoCadastroEmEdicao?.login = value;
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Este campo é obrigatório!";
                          }
                          return null;
                        }),
                    espacoEntreCampos,
                    TextFormField(
                        decoration: decorationCampoTexto(
                            hintText: "Senha", labelText: "Senha"),
                        keyboardType: TextInputType.text,
                        obscureText: _obscureText,
                        initialValue:
                            widget.controle.objetoCadastroEmEdicao?.senha,
                        onSaved: (String? value) {
                          widget.controle.objetoCadastroEmEdicao?.senha = value;
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Este campo é obrigatório!";
                          }
                          return null;
                        }),
                    espacoEntreCampos,
                    FutureBuilder(
                        future: controlegrupos.listar(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List> snapshot) {
                          String labelCampo = "Grupo";
                          if (!snapshot.hasData) {
                            labelCampo = "Carregando grupos...";
                          } else {
                            controlegrupos.listaObjetosPesquisados =
                                snapshot.data as List<GrupoUsuario>;
                          }

                          return DropdownButtonFormField<GrupoUsuario>(
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.teal)),
                                filled: true,
                                isDense: true,
                                hintText: labelCampo,
                                labelText: labelCampo),
                            isExpanded: true,
                            items:
                                controlegrupos.listaObjetosPesquisados == null
                                    ? []
                                    : controlegrupos.listaObjetosPesquisados!
                                        .map<DropdownMenuItem<GrupoUsuario>>(
                                            (GrupoUsuario grupo) {
                                        return DropdownMenuItem<GrupoUsuario>(
                                          value: grupo,
                                          child: Text(grupo.nome!,
                                              textAlign: TextAlign.center),
                                        );
                                      }).toList(),
                            value:
                                widget.controle.objetoCadastroEmEdicao?.grupo,
                            validator: (value) {
                              if (value == null) {
                                return "Campo Obrigatório!";
                              }
                              return null;
                            },
                            onChanged: (GrupoUsuario? value) {
                              setState(() {
                                widget.controle.objetoCadastroEmEdicao?.grupo =
                                    value;
                              });
                            },
                          );
                        }),
                    espacoEntreCampos,
                    SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ))
        ]));
  }
}
