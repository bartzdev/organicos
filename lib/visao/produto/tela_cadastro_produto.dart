import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/produto.dart';
import 'package:organicos/modelo/unidade.dart';
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
                      TextFormField(
                          maxLines: null,
                          maxLength: 150,
                          decoration: decorationCampoTexto(
                              hintText: "Descrição", labelText: "Descrição"),
                          keyboardType: TextInputType.multiline,
                          initialValue:
                              widget.controle.objetoCadastroEmEdicao?.descricao,
                          onSaved: (String? value) {
                            widget.controle.objetoCadastroEmEdicao?.descricao =
                                value;
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
                              hintText: "Preço", labelText: "Preço"),
                          keyboardType: TextInputType.number,
                          initialValue: widget
                                      .controle.objetoCadastroEmEdicao?.preco ==
                                  null
                              ? ""
                              : widget.controle.objetoCadastroEmEdicao?.preco
                                  .toString(),
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
                      espacoEntreCampos,
                    ],
                  )))
        ]));
  }
}
