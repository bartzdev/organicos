import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/certificadora.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/estado.dart';
import 'package:organicos/modelo/grupo_produtor.dart';
import 'package:organicos/modelo/produtor.dart';
import 'package:organicos/visao/cidades/tela_pesquisa_cidades.dart';
import 'package:organicos/visao/produtor/tela_pesquisa_certificadora_aqui.dart';
import 'package:organicos/visao/produtor/tela_pesquisa_grupoprodutor_aqui.dart';
import 'package:organicos/visao/widgets/mensagens.dart';
import 'package:organicos/visao/widgets/textformfield.dart';

class TelaCadastroProdutor extends StatefulWidget {
  ControleCadastros<Produtor> controle;
  Function()? onSaved;

  TelaCadastroProdutor(this.controle, {Key? key, this.onSaved})
      : super(key: key);
  @override
  _TelaCadastroProdutor createState() => _TelaCadastroProdutor();
}

class _TelaCadastroProdutor extends State<TelaCadastroProdutor> {
  BuildContext? _context;
  ControleCadastros<Cidade> controleCidade = ControleCadastros(Cidade());
  var _chaveFormulario1 = GlobalKey<FormState>();
  int grupo = 1;
  bool radio1Selected = true;

  Future<void> salvar(BuildContext context) async {
    if (_chaveFormulario1.currentState != null &&
        _chaveFormulario1.currentState!.validate()) {
      _chaveFormulario1.currentState!.save();
      widget.controle.objetoCadastroEmEdicao!.vendaConsumidorFinal = grupo == 1;
      widget.controle.salvarObjetoCadastroEmEdicao().then((value) {
        if (widget.onSaved != null) widget.onSaved!();
        Navigator.of(context).pop();
      }).catchError((error) {
        print(error);
        mensagemConexao(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    int val = -1;
    TabController _controller;

    _handleRadioValueChange1(int? value) {
      setState(() {
        grupo = value == null ? 0 : value;
      });

      radio1Selected = grupo == 0;
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Cadastro de Produtor'),
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
                key: _chaveFormulario1,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.start,
                    spacing: 30.0,
                    runSpacing: 30.0,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            TextFormField(
                              onChanged: (text) {},
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: 'Nome do produtor',
                                  border: OutlineInputBorder()),
                              initialValue:
                                  widget.controle.objetoCadastroEmEdicao?.nome,
                              onSaved: (String? nome) {
                                widget.controle.objetoCadastroEmEdicao?.nome =
                                    nome;
                              },
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Este campo é obrigatório!";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              onChanged: (text) {},
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: 'CPF/CNPJ',
                                  border: OutlineInputBorder()),
                              initialValue: widget
                                  .controle.objetoCadastroEmEdicao!.cpfCnpj,
                              onSaved: (String? cpfCnpj) {
                                widget.controle.objetoCadastroEmEdicao
                                    ?.cpfCnpj = cpfCnpj;
                              },
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "Este campo é obrigatório!";
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TelaPesquisaCidades(
                                                onItemSelected:
                                                    (Cidade cidade) {
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
                                        key: Key((widget
                                                    .controle
                                                    .objetoCadastroEmEdicao
                                                    ?.endereco
                                                    ?.cidade
                                                    ?.id ==
                                                null
                                            ? ' '
                                            : widget
                                                .controle
                                                .objetoCadastroEmEdicao!
                                                .endereco!
                                                .cidade!
                                                .id
                                                .toString())),
                                        readOnly: true,
                                        decoration: decorationCampoTexto(
                                            hintText: "Cidade",
                                            labelText: "Cidade"),
                                        keyboardType: TextInputType.text,
                                        initialValue: widget
                                            .controle
                                            .objetoCadastroEmEdicao
                                            ?.endereco
                                            ?.cidade
                                            ?.nome,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return "Este campo é obrigatório!";
                                          }
                                          return null;
                                        }))),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                                onChanged: (text) {},
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    labelText: 'Endereço do produtor',
                                    border: OutlineInputBorder()),
                                initialValue: widget.controle
                                            .objetoCadastroEmEdicao!.endereco ==
                                        null
                                    ? ''
                                    : widget.controle.objetoCadastroEmEdicao!
                                        .endereco!.logradouro,
                                onSaved: (String? logradouro) {
                                  widget.controle.objetoCadastroEmEdicao
                                      ?.endereco?.logradouro = logradouro;
                                },
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Este campo é obrigatório!";
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                      onChanged: (text) {},
                                      keyboardType: TextInputType.number,
                                      //maxLength: 6,
                                      decoration: InputDecoration(
                                          labelText: 'Número',
                                          border: OutlineInputBorder()),
                                      initialValue:
                                          '${widget.controle.objetoCadastroEmEdicao?.endereco?.numero == null ? '' : widget.controle.objetoCadastroEmEdicao!.endereco!.numero}',
                                      onSaved: (String? numero) {
                                        widget.controle.objetoCadastroEmEdicao
                                                ?.endereco?.numero =
                                            numero != null && numero.length > 0
                                                ? int.parse(numero)
                                                : null;
                                      },
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return "Este campo é obrigatório!";
                                        }
                                        return null;
                                      }),
                                  // '${widget.controle.objetoCadastroEmEdicao?.endereco?.numero ?? ''}'),
                                  // (widget.controle.objetoCadastroEmEdicao
                                  //             ?.endereco?.numero ??
                                  //         '')
                                  //     .toString()),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Expanded(
                                  child: TextFormField(
                                      onChanged: (text) {},
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          labelText: 'Bairro',
                                          border: OutlineInputBorder()),
                                      initialValue: widget
                                                  .controle
                                                  .objetoCadastroEmEdicao!
                                                  .endereco ==
                                              null
                                          ? ''
                                          : widget
                                              .controle
                                              .objetoCadastroEmEdicao!
                                              .endereco!
                                              .bairro,
                                      onSaved: (String? bairro) {
                                        widget.controle.objetoCadastroEmEdicao
                                            ?.endereco?.bairro = bairro;
                                      },
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return "Este campo é obrigatório!";
                                        }
                                        return null;
                                      }),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                                onChanged: (text) {},
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    labelText: 'Telefone',
                                    border: OutlineInputBorder()),
                                initialValue: widget
                                    .controle.objetoCadastroEmEdicao!.telefone,
                                onSaved: (String? telefone) {
                                  widget.controle.objetoCadastroEmEdicao
                                      ?.telefone = telefone;
                                },
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Este campo é obrigatório!";
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 30,
                                ),
                              ],
                            ),
                            TextFormField(
                                onChanged: (text) {},
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    labelText: 'Nome da propriedade',
                                    border: OutlineInputBorder()),
                                initialValue: widget.controle
                                    .objetoCadastroEmEdicao!.nomePropriedade,
                                onSaved: (String? nomePropriedade) {
                                  widget.controle.objetoCadastroEmEdicao
                                      ?.nomePropriedade = nomePropriedade;
                                },
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Este campo é obrigatório!";
                                  }
                                  return null;
                                }),
                            SizedBox(
                              height: 30,
                            ),
                            Center(
                              child: Text('Selecione abaixo a sua propriedade'),
                            ),
                            Center(
                              child: InkWell(
                                child: Image.asset(
                                  'assets/imagens/google-maps.jpg',
                                  height: 200,
                                ),
                                onTap: () {
                                  print('clicou');
                                },
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                                onChanged: (text) {},
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Latitude',
                                  border: OutlineInputBorder(),
                                  enabled: false,
                                ),
                                initialValue: widget.controle
                                            .objetoCadastroEmEdicao!.latitude ==
                                        null
                                    ? ''
                                    : widget.controle.objetoCadastroEmEdicao!
                                        .latitude
                                        .toString(),
                                onSaved: (String? latitude) {
                                  widget.controle.objetoCadastroEmEdicao
                                          ?.latitude =
                                      latitude != null && latitude.length > 0
                                          ? double.parse(latitude)
                                          : null;
                                }),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                                onChanged: (text) {},
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: 'Longitude',
                                  border: OutlineInputBorder(),
                                  enabled: false,
                                ),
                                initialValue: widget
                                            .controle
                                            .objetoCadastroEmEdicao!
                                            .longitude ==
                                        null
                                    ? ''
                                    : widget.controle.objetoCadastroEmEdicao!
                                        .longitude
                                        .toString(),
                                onSaved: (String? longitude) {
                                  widget.controle.objetoCadastroEmEdicao
                                          ?.longitude =
                                      longitude != null && longitude.length > 0
                                          ? double.parse(longitude)
                                          : null;
                                  ;
                                }),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TelaPesquisaCertificadoraAqui(
                                                onItemSelected: (Certificadora
                                                    certificadora) {
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    widget
                                                            .controle
                                                            .objetoCadastroEmEdicao
                                                            ?.certificadora =
                                                        certificadora;
                                                  });
                                                },
                                              )));
                                },
                                child: AbsorbPointer(
                                    child: TextFormField(
                                        key: Key((widget
                                                    .controle
                                                    .objetoCadastroEmEdicao
                                                    ?.certificadora
                                                    ?.nome ==
                                                null
                                            ? ' '
                                            : widget
                                                .controle
                                                .objetoCadastroEmEdicao!
                                                .certificadora!
                                                .nome!)),
                                        readOnly: true,
                                        decoration: decorationCampoTexto(
                                            hintText: "Certificadoras",
                                            labelText: "Certificadoras"),
                                        keyboardType: TextInputType.text,
                                        initialValue: widget
                                            .controle
                                            .objetoCadastroEmEdicao
                                            ?.certificadora
                                            ?.nome,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return "Este campo é obrigatório!";
                                          }
                                          return null;
                                        }))),
                            // TextFormField(
                            //     onChanged: (text) {},
                            //     keyboardType: TextInputType.emailAddress,
                            //     decoration: InputDecoration(
                            //         labelText: 'Certificadora',
                            //         border: OutlineInputBorder()),
                            //     initialValue: widget.controle.objetoCadastroEmEdicao!
                            //                 .certificadora ==
                            //             null
                            //         ? ''
                            //         : widget.controle.objetoCadastroEmEdicao!
                            //             .certificadora!.nome),
                            SizedBox(
                              height: 30,
                            ),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TelaPesquisaGrupoProdutorAqui(
                                                onItemSelected:
                                                    (GrupoProdutor grupo) {
                                                  Navigator.of(context).pop();
                                                  setState(() {
                                                    widget
                                                        .controle
                                                        .objetoCadastroEmEdicao
                                                        ?.grupo = grupo;
                                                  });
                                                },
                                              )));
                                },
                                child: AbsorbPointer(
                                    child: TextFormField(
                                        key: Key((widget
                                                    .controle
                                                    .objetoCadastroEmEdicao
                                                    ?.grupo
                                                    ?.nome ==
                                                null
                                            ? ' '
                                            : widget
                                                .controle
                                                .objetoCadastroEmEdicao!
                                                .grupo!
                                                .nome!)),
                                        readOnly: true,
                                        decoration: decorationCampoTexto(
                                            hintText: "Grupo de produtores",
                                            labelText: "Grupo de produtores"),
                                        keyboardType: TextInputType.text,
                                        initialValue: widget
                                            .controle
                                            .objetoCadastroEmEdicao
                                            ?.grupo
                                            ?.nome,
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return "Este campo é obrigatório!";
                                          }
                                          return null;
                                        }))),
                            // TextFormField(
                            //     onChanged: (text) {},
                            //     keyboardType: TextInputType.emailAddress,
                            //     decoration: InputDecoration(
                            //         labelText: 'Grupo de produtores',
                            //         border: OutlineInputBorder()),
                            //     initialValue:
                            //         widget.controle.objetoCadastroEmEdicao!.grupo ==
                            //                 null
                            //             ? ''
                            //             : widget.controle.objetoCadastroEmEdicao!.grupo!
                            //                 .nome),
                            SizedBox(
                              height: 30,
                            ),
                            TextFormField(
                              onChanged: (text) {},
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                  labelText: 'Nome da propriedade',
                                  border: OutlineInputBorder()),
                              initialValue: widget.controle
                                  .objetoCadastroEmEdicao!.nomePropriedade,
                              // onSaved: (String? nome) {
                              //   widget.controle.objetoCadastroEmEdicao?.nome = nome;
                              // },
                              // validator: (value) {
                              //   if (value == null || value.trim().isEmpty) {
                              //     return "Este campo é obrigatório!";
                              //   }
                              //   return null;
                              // }
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            // TextFormField(
                            //     onChanged: (text) {},
                            //     keyboardType: TextInputType.emailAddress,
                            //     decoration: InputDecoration(
                            //         labelText: 'Certificação orgânica',
                            //         border: OutlineInputBorder()),
                            //     initialValue: widget.controle.objetoCadastroEmEdicao!
                            //         .certificacaoOrganicos),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Venda consumidor final',
                                  style: TextStyle(fontSize: 16.0),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Radio<int>(
                                      value: widget
                                              .controle
                                              .objetoCadastroEmEdicao!
                                              .vendaConsumidorFinal
                                          ? 1
                                          : 0,
                                      groupValue: grupo,
                                      onChanged: _handleRadioValueChange1,
                                    ),
                                    Text(
                                      'Sim',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Radio<int>(
                                      value: widget
                                              .controle
                                              .objetoCadastroEmEdicao!
                                              .vendaConsumidorFinal
                                          ? 0
                                          : 1,
                                      groupValue: grupo,
                                      onChanged: _handleRadioValueChange1,
                                    ),
                                    Text(
                                      'Não',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ))
        ]));
  }
}
