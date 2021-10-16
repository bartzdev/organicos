import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/estado.dart';
import 'package:organicos/modelo/ponto_venda.dart';
import 'package:organicos/visao/cidades/tela_pesquisa_cidades.dart';
import 'package:organicos/visao/styles/styles.dart';
import 'package:organicos/visao/widgets/textformfield.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';

class TelaCadastroPontoVenda extends StatefulWidget {
  ControleCadastros<PontoVenda> controle;
  Function()? onSaved;

  TelaCadastroPontoVenda(this.controle, {Key? key, this.onSaved})
      : super(key: key);

  @override
  _TelaCadastroPontoVendaState createState() => _TelaCadastroPontoVendaState();
}

class _TelaCadastroPontoVendaState extends State<TelaCadastroPontoVenda> {
  ControleCadastros<Estado> controleEstados = ControleCadastros(Estado());
  ControleCadastros<Cidade> controleCidade = ControleCadastros(Cidade());
  var _chaveFormulario = GlobalKey<FormState>();
  Estado? _estadoSelecionado;

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
          title: Text('Cadastro de Ponto de Venda'),
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
                        // maxLength: 50,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: decorationCampoTexto(
                            hintText: "Número", labelText: "Número"),
                        keyboardType: TextInputType.number,
                        initialValue: widget
                            .controle.objetoCadastroEmEdicao?.endereco?.numero
                            ?.toString(),
                        onSaved: (String? value) {
                          widget.controle.objetoCadastroEmEdicao?.endereco
                                  ?.numero =
                              value != null && value.length > 0
                                  ? int.parse(value)
                                  : null;
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
                            .controle.objetoCadastroEmEdicao?.endereco?.bairro,
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

                    /*FutureBuilder(
                      future: controleEstados.listar(),
                      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                        String labelCampo = "Estado";
                        if (!snapshot.hasData) {
                          labelCampo = "Carregando estados...";
                        } else {
                          controleEstados.listaObjetosPesquisados = snapshot.data as List<Estado>;
                        }

                        return DropdownButtonFormField<Estado>(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
                              filled: true,
                              isDense: true,
                              hintText: labelCampo,
                              labelText: labelCampo),
                          isExpanded: true,
                          items: controleEstados.listaObjetosPesquisados == null
                              ? []
                              : controleEstados.listaObjetosPesquisados!.map<DropdownMenuItem<Estado>>((Estado estado) {
                                  return DropdownMenuItem<Estado>(
                                    value: estado,
                                    child: Text(estado.nome!, textAlign: TextAlign.center),
                                  );
                                }).toList(),
                          value: _estadoSelecionado,
                          validator: (value) {
                            if (value == null) {
                              return "Campo Obrigatório!";
                            }
                            return null;
                          },
                          onChanged: (Estado? value) {
                            setState(() {
                              _estadoSelecionado = value;
                              widget.controle.objetoCadastroEmEdicao?.endereco?.cidade = null;
                              controleCidade.listaObjetosPesquisados = null;
                            });
                          },
                        );
                      }),
                  espacoEntreCampos,
                  FutureBuilder(
                      future: controleCidade.listar(filtros: {'estado': _estadoSelecionado}),
                      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                        String labelCampo = "Cidade";
                        if (!snapshot.hasData) {
                          labelCampo = "Carregando cidades...";
                        } else {
                          controleCidade.listaObjetosPesquisados = snapshot.data as List<Cidade>;
                        }

                        return DropdownButtonFormField<Cidade>(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.teal)),
                              filled: true,
                              isDense: true,
                              hintText: labelCampo,
                              labelText: labelCampo),
                          isExpanded: true,
                          items: controleCidade.listaObjetosPesquisados == null
                              ? []
                              : controleCidade.listaObjetosPesquisados!.map<DropdownMenuItem<Cidade>>((Cidade cidade) {
                                  return DropdownMenuItem<Cidade>(
                                    value: cidade,
                                    child: Text(cidade.nome!, textAlign: TextAlign.center),
                                  );
                                }).toList(),
                          value: widget.controle.objetoCadastroEmEdicao?.endereco?.cidade,
                          validator: (value) {
                            if (value == null) {
                              return "Campo Obrigatório!";
                            }
                            return null;
                          },
                          onChanged: (Cidade? value) {
                            setState(() {
                              widget.controle.objetoCadastroEmEdicao?.endereco?.cidade = value;
                            });
                          },
                        );
                      })*/
                    SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ))
        ]));
  }
}
