import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/grupo_produtor.dart';
import 'package:organicos/visao/cidades/tela_pesquisa_cidades.dart';
import 'package:organicos/visao/styles/styles.dart';
import 'package:organicos/visao/widgets/textformfield.dart';

class TelaCadastroGrupoProdutor extends StatefulWidget {
  ControleCadastros<GrupoProdutor> controle;
  Function()? onSaved;

  TelaCadastroGrupoProdutor(this.controle, {Key? key, this.onSaved})
      : super(key: key);
  _TelaCadastroGrupoProdutorState createState() =>
      _TelaCadastroGrupoProdutorState();
}

class _TelaCadastroGrupoProdutorState extends State<TelaCadastroGrupoProdutor> {
  var _chaveFormulario = GlobalKey<FormState>();

  Future<void> Salvar(BuildContext context) async {
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
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Grupo de Produtores'),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.check),
          onPressed: () {
            Salvar(context);
          },
          label: Text('Salvar')),
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
                            hintText: "Cnpj", labelText: "Cnpj"),
                        keyboardType: TextInputType.text,
                        initialValue:
                            widget.controle.objetoCadastroEmEdicao?.cnpj,
                        onSaved: (String? value) {
                          widget.controle.objetoCadastroEmEdicao?.cnpj = value;
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
                            hintText: "Inscrição Estadual",
                            labelText: "Inscrição Estadual"),
                        keyboardType: TextInputType.text,
                        initialValue: widget
                            .controle.objetoCadastroEmEdicao?.inscricaoEstadual,
                        onSaved: (String? value) {
                          widget.controle.objetoCadastroEmEdicao
                              ?.inscricaoEstadual = value;
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
                            hintText: "Endereço", labelText: "Endereço"),
                        keyboardType: TextInputType.text,
                        initialValue: widget.controle.objetoCadastroEmEdicao
                            ?.endereco?.logradouro,
                        onSaved: (String? value) {
                          widget.controle.objetoCadastroEmEdicao?.endereco
                              ?.logradouro = value;
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
                            hintText: "Numero", labelText: "Numero"),
                        keyboardType: TextInputType.number,
                        initialValue: widget
                            .controle.objetoCadastroEmEdicao?.endereco?.numero
                            .toString(),
                        onSaved: (String? value) {
                          widget.controle.objetoCadastroEmEdicao?.endereco
                                  ?.numero =
                              value != null && value.length > 0
                                  ? int.parse(value)
                                  : null;
                          ;
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
                            hintText: "Bairro", labelText: "Bairro"),
                        keyboardType: TextInputType.text,
                        initialValue: widget
                            .controle.objetoCadastroEmEdicao?.endereco?.bairro
                            .toString(),
                        onSaved: (String? value) {
                          widget.controle.objetoCadastroEmEdicao?.endereco
                              ?.bairro = value;
                        },
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Este campo é obrigatório!";
                          }
                          return null;
                        }),
                    espacoEntreCampos,
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TelaPesquisaCidades(
                                        onItemSelected: (Cidade cidade) {
                                          Navigator.of(context).pop();
                                          setState(() {
                                            widget
                                                .controle
                                                .objetoCadastroEmEdicao
                                                ?.endereco
                                                ?.cidade = cidade;
                                          });
                                        },
                                      )));
                        },
                        child: AbsorbPointer(
                            child: TextFormField(
                                key: Key((widget.controle.objetoCadastroEmEdicao
                                            ?.endereco?.cidade?.nome ==
                                        null
                                    ? ' '
                                    : widget.controle.objetoCadastroEmEdicao!
                                        .endereco!.cidade!.nome!)),
                                readOnly: true,
                                decoration: decorationCampoTexto(
                                    hintText: "Cidade", labelText: "Cidade"),
                                keyboardType: TextInputType.text,
                                initialValue: widget
                                    .controle
                                    .objetoCadastroEmEdicao
                                    ?.endereco
                                    ?.cidade
                                    ?.nome,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Este campo é obrigatório!";
                                  }
                                  return null;
                                }))),
                    CheckboxListTile(
                      value: widget.controle.objetoCadastroEmEdicao?.distribuidor,
                      onChanged: (value){
                        setState(() {
                          widget.controle.objetoCadastroEmEdicao?.distribuidor = widget.controle.objetoCadastroEmEdicao?.distribuidor == null ? false : !widget.controle.objetoCadastroEmEdicao!.distribuidor;
                        });
                      },
                      title: Text('Distribui produtos'),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Colors.blue,
                    ),
                    SizedBox(
                      height: 60,
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
