import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/grupo_produtor.dart';
import 'package:organicos/visao/cidades/tela_pesquisa_cidades.dart';
import 'package:organicos/visao/styles/styles.dart';
import 'package:organicos/visao/widgets/mensagens.dart';
import 'package:organicos/visao/widgets/textformfield.dart';
import 'package:brasil_fields/brasil_fields.dart';

class TelaProdutor extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw TelaProdutorState();
  }
  
}

class TelaProdutorState extends State<TelaProdutor> {
  var _chaveFormulario = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Produtor'),
        centerTitle: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.check), onPressed: () {}, label: Text('Salvar')),
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
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CnpjInputFormatter()
                        ],
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Este campo é obrigatório!";
                          } else if (UtilBrasilFields.isCNPJValido(value) ==
                              false) {
                            return "Insira um cnpj valido";
                          }
                          return null;
                        }),
                    espacoEntreCampos,
                    TextFormField(
                        decoration: decorationCampoTexto(
                            hintText: "Inscrição Estadual",
                            labelText: "Inscrição Estadual"),
                        keyboardType: TextInputType.text,
                        inputFormatters: [LengthLimitingTextInputFormatter(20)],
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
                        onSaved: (String? value) {
                          print("Aqui");
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
                                            print("Outro state");
                                          });
                                        },
                                      )));
                        },
                        child: AbsorbPointer(
                            child: TextFormField(
                                decoration: decorationCampoTexto(
                                    hintText: "Cidade", labelText: "Cidade"),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Este campo é obrigatório!";
                                  }
                                  return null;
                                }))),
                    CheckboxListTile(
                      value: true,
                      onChanged: (value) {
                        setState(() {
                          print('Mais um');
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
