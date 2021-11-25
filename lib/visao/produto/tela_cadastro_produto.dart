import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/produto.dart';
import 'package:organicos/modelo/tipo_produto.dart';
import 'package:organicos/modelo/unidade.dart';
import 'package:organicos/modelo/utilitarios.dart';
import 'package:organicos/visao/styles/styles.dart';
import 'package:organicos/visao/widgets/textformfield.dart';

class TelaCadastroProduto extends StatefulWidget {
  ControleCadastros<Produto> controle;
  Function()? onSaved;

  TelaCadastroProduto(this.controle, {Key? key, this.onSaved})
      : super(key: key);

  @override
  _TelaCadastroProdutoState createState() => _TelaCadastroProdutoState();
}

Future<void> salvar(BuildContext context) async {
  ControleCadastros<Produto> controleProduto = ControleCadastros(Produto());
}

class _TelaCadastroProdutoState extends State<TelaCadastroProduto> {
  ControleCadastros<Unidade> controleUnidade = ControleCadastros(Unidade());
  ControleCadastros<TipoProduto> controleTipoProduto =
      ControleCadastros(TipoProduto());
  final _formKey = GlobalKey<FormState>();

  Future<void> salvar(BuildContext context) async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.controle.salvarObjetoCadastroEmEdicao().then((value) {
        if (widget.onSaved != null) widget.onSaved!();
        Navigator.of(context).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String _msgPadrao = "Escolha a unidade";
    return Scaffold(
        appBar: AppBar(centerTitle: true, title: Text('Cadastro de Produto')),
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
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                          decoration: decorationCampoTexto(
                              hintText: "Nome", labelText: "Nome"),
                          keyboardType: TextInputType.text,
                          initialValue:
                              widget.controle.objetoCadastroEmEdicao?.nome,
                          onSaved: (String? value) {
                            widget.controle.objetoCadastroEmEdicao?.nome =
                                value;
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Este campo é obrigatório!";
                            }
                            return null;
                          }),
                      espacoEntreCampos,
                      FutureBuilder(
                          future: controleTipoProduto.listar(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List> snapshot) {
                            String labelCampo = "Tipo";
                            if (!snapshot.hasData) {
                              labelCampo = "Carregando tipo do produto...";
                            } else {
                              controleTipoProduto.listaObjetosPesquisados =
                                  snapshot.data as List<TipoProduto>;
                            }

                            return DropdownButtonFormField<TipoProduto>(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal)),
                                  filled: true,
                                  isDense: true,
                                  hintText: labelCampo,
                                  labelText: labelCampo),
                              isExpanded: true,
                              items: controleTipoProduto
                                          .listaObjetosPesquisados ==
                                      null
                                  ? []
                                  : controleTipoProduto.listaObjetosPesquisados!
                                      .map<DropdownMenuItem<TipoProduto>>(
                                          (TipoProduto tipoProduto) {
                                      return DropdownMenuItem<TipoProduto>(
                                        value: tipoProduto,
                                        child: Text(tipoProduto.nome!,
                                            textAlign: TextAlign.center),
                                      );
                                    }).toList(),
                              value:
                                  widget.controle.objetoCadastroEmEdicao?.tipo,
                              validator: (value) {
                                if (value == null) {
                                  return "Campo Obrigatório!";
                                }
                                return null;
                              },
                              onChanged: (TipoProduto? value) {
                                setState(() {
                                  widget.controle.objetoCadastroEmEdicao?.tipo =
                                      value;
                                });
                              },
                            );
                          }),
                      espacoEntreCampos,
                      FutureBuilder(
                          future: controleUnidade.listar(),
                          builder: (BuildContext context,
                              AsyncSnapshot<List> snapshot) {
                            String labelCampo = "Unidade";
                            if (!snapshot.hasData) {
                              labelCampo = "Carregando unidades...";
                            } else {
                              controleUnidade.listaObjetosPesquisados =
                                  snapshot.data as List<Unidade>;
                            }

                            return DropdownButtonFormField<Unidade>(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.teal)),
                                  filled: true,
                                  isDense: true,
                                  hintText: labelCampo,
                                  labelText: labelCampo),
                              isExpanded: true,
                              items: controleUnidade.listaObjetosPesquisados ==
                                      null
                                  ? []
                                  : controleUnidade.listaObjetosPesquisados!
                                      .map<DropdownMenuItem<Unidade>>(
                                          (Unidade unidade) {
                                      return DropdownMenuItem<Unidade>(
                                        value: unidade,
                                        child: Text(unidade.nome!,
                                            textAlign: TextAlign.center),
                                      );
                                    }).toList(),
                              value: widget
                                  .controle.objetoCadastroEmEdicao?.unidade,
                              validator: (value) {
                                if (value == null) {
                                  return "Campo Obrigatório!";
                                }
                                return null;
                              },
                              onChanged: (Unidade? value) {
                                setState(() {
                                  widget.controle.objetoCadastroEmEdicao
                                      ?.unidade = value;
                                });
                              },
                            );
                          }),
                      espacoEntreCampos,
                      TextFormField(
                          maxLines: null,
                          maxLength: 150,
                          decoration: decorationCampoTexto(
                              hintText: "Descrição", labelText: "Descrição"),
                          keyboardType: TextInputType.multiline,
                          initialValue:
                              widget.controle.objetoCadastroEmEdicao?.descricao,
                          onSaved: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              widget.controle.objetoCadastroEmEdicao
                                  ?.descricao = null;
                            } else {
                              widget.controle.objetoCadastroEmEdicao
                                  ?.descricao = value;
                            }
                          },
                          validator: (value) {
                            return null;
                          }),
                      espacoEntreCampos,
                      TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+[\,\.]?\d{0,2}')),
                          ],
                          decoration: decorationCampoTexto(
                              hintText: "Preço", labelText: "Preço"),
                          keyboardType: TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                          initialValue:
                              widget.controle.objetoCadastroEmEdicao?.preco ==
                                      null
                                  ? ""
                                  : formatDouble(widget
                                      .controle.objetoCadastroEmEdicao?.preco),
                          onSaved: (String? value) {
                            if (value != null && value.length > 0) {
                              widget.controle.objetoCadastroEmEdicao?.preco =
                                  double.parse(value.replaceAll(',', '.'));
                            } else {
                              widget.controle.objetoCadastroEmEdicao?.preco =
                                  null;
                            }
                          },
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Este campo é obrigatório!";
                            }
                            return null;
                          }),
                    ],
                  )))
        ]));
  }
}
