import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/grupo_usuario.dart';
import 'package:organicos/modelo/permissoes.dart';
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
  bool _obscureText = true;
  ControleCadastros<Permissao> controlePermissao =
      ControleCadastros(Permissao());
  List<Permissao>? listaPermissao = [];
  
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
  Widget checkListaPermissao() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 3),
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      height: 200,
      width: double.infinity,
      child: ListView(
        children: widget.controle.objetoCadastroEmEdicao!.permissoes
            .map((PermissaoGrupo perGrupo) {
          return new CheckboxListTile(
            title: new Text(perGrupo.permissao?.nome == null
                ? ''
                : perGrupo.permissao!.nome!),
            value: perGrupo.permitido,
            activeColor: Colors.green,
            checkColor: Colors.white,
            onChanged: (bool? value) {
              setState(() {
                perGrupo.permitido = value != null && value;
              });
            },
          );
        }).toList(),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Cadastro de Permissão de Grupo'),
        ),
        body: ListView(children: [
          Padding(
              padding: EdgeInsets.all(20),
              child: Form(
                key: _chaveFormulario,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                        decoration: decorationCampoTexto(
                            hintText: "Nome Grupo", labelText: "Nome Grupo"),
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
                    Container(
                      height: 30,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text("PERMISSÕES",
                          style:
                              TextStyle(fontSize: 20, color: Colors.black54)),
                    ),
                    espacoEntreCampos,
                    FutureBuilder<List<Permissao>>(
                        future: controlePermissao.listar(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Permissao>> snapshot) {
                          if (snapshot.hasData) {
                            if (listaPermissao == null ||
                                listaPermissao!.length == 0) {
                              listaPermissao = snapshot.data;
                              for (Permissao permissao in listaPermissao!) {
                                PermissaoGrupo permissaoGrupo =
                                    PermissaoGrupo();
                                permissaoGrupo.permissao = permissao;
                                widget
                                    .controle.objetoCadastroEmEdicao?.permissoes
                                    .add(permissaoGrupo);
                              }
                            }

                            return checkListaPermissao();
                          }

                          return SizedBox();
                        }),
                    espacoEntreCampos,
                    FloatingActionButton.extended(
                        icon: const Icon(Icons.check),
                        onPressed: () {
                          salvar(context);
                        },
                        label: const Text('Salvar')),
                    SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ))
        ]));
  }
}



  /*
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
}*/
