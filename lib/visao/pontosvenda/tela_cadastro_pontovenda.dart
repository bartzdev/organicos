import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/ponto_venda.dart';
import 'package:organicos/visao/styles/styles.dart';
import 'package:organicos/visao/widgets/textformfield.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';

class TelaCadastroPontoVenda extends StatefulWidget {
  ControleCadastros<PontoVenda> controle;
  Function()? onSaved;

  TelaCadastroPontoVenda(this.controle, {Key? key, this.onSaved}) : super(key: key);

  @override
  _TelaCadastroPontoVendaState createState() => _TelaCadastroPontoVendaState();
}

class _TelaCadastroPontoVendaState extends State<TelaCadastroPontoVenda> {
  var _chaveFormulario = GlobalKey<FormState>();

  Future<void> salvar() async {
    if (_chaveFormulario.currentState != null && _chaveFormulario.currentState!.validate()) {
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
          title: Text('Cadastro de Ponto de Venda'),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            icon: const Icon(Icons.check),
            onPressed: () {
              salvar();
            },
            label: const Text('Salvar')),
        body: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _chaveFormulario,
              child: Column(
                children: <Widget>[
                  TextFormField(
                      decoration: decorationCampoTexto(hintText: "Nome", labelText: "Nome"),
                      keyboardType: TextInputType.text,
                      initialValue: widget.controle.objetoCadastroEmEdicao?.nome,
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
                      decoration: decorationCampoTexto(hintText: "Endereço", labelText: "Endereço"),
                      keyboardType: TextInputType.text,
                      initialValue: widget.controle.objetoCadastroEmEdicao?.endereco?.logradouro,
                      onSaved: (String? value) {
                        widget.controle.objetoCadastroEmEdicao?.endereco?.logradouro = value;
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        return null;
                      }),
                  espacoEntreCampos,
                  TextFormField(
                      // maxLength: 50,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: decorationCampoTexto(hintText: "Número", labelText: "Número"),
                      keyboardType: TextInputType.number,
                      initialValue: widget.controle.objetoCadastroEmEdicao?.endereco?.numero?.toString(),
                      onSaved: (String? value) {
                        widget.controle.objetoCadastroEmEdicao?.endereco?.numero =
                            value != null && value.length > 0 ? int.parse(value) : null;
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        return null;
                      }),
                  espacoEntreCampos,
                  TextFormField(
                      decoration: decorationCampoTexto(hintText: "Bairro", labelText: "Bairro"),
                      keyboardType: TextInputType.text,
                      initialValue: widget.controle.objetoCadastroEmEdicao?.endereco?.bairro,
                      onSaved: (String? value) {
                        widget.controle.objetoCadastroEmEdicao?.endereco?.bairro = value;
                      },
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Este campo é obrigatório!";
                        }
                        return null;
                      }),
                ],
              ),
            )));
  }
}
