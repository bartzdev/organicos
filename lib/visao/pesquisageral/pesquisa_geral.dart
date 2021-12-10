import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/ponto_venda.dart';
import 'package:organicos/modelo/produto.dart';
import 'package:organicos/modelo/tipo_produto.dart';
import 'package:organicos/visao/styles/styles.dart';

class TelaPesquisaGeral extends StatefulWidget {
  TelaPesquisaGeral({Key? key}) : super(key: key);

  @override
  _TelaPesquisaGeralState createState() => _TelaPesquisaGeralState();
}

class _TelaPesquisaGeralState extends State<TelaPesquisaGeral> {
  ControleCadastros<TipoProduto> controleTipoProduto =
      ControleCadastros(TipoProduto());

  ControleCadastros<PontoVenda> controlePontoVenda =
      ControleCadastros(PontoVenda());

  TipoProduto? tipoSelecionado;
  PontoVenda? pontoVendaSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          'Pesquisa de produtos\ne produtores',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              espacoEntreCampos,
              FutureBuilder(
                  future: controleTipoProduto.listar(),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
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
                              borderSide: BorderSide(color: Colors.teal)),
                          filled: true,
                          isDense: true,
                          hintText: labelCampo,
                          labelText: labelCampo),
                      isExpanded: true,
                      items: controleTipoProduto.listaObjetosPesquisados == null
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
                      value: tipoSelecionado,
                      validator: (value) {
                        if (value == null) {
                          return "Campo Obrigatório!";
                        }
                        return null;
                      },
                      onChanged: (TipoProduto? value) {
                        setState(() {
                          tipoSelecionado = value;
                        });
                      },
                    );
                  }),

              espacoEntreCampos,
              // ponto de venda

              FutureBuilder(
                  future: controlePontoVenda.listar(),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    String labelCampo = "Tipo";
                    if (!snapshot.hasData) {
                      labelCampo = "Carregando tipo do produto...";
                    } else {
                      controlePontoVenda.listaObjetosPesquisados =
                          snapshot.data as List<PontoVenda>;
                    }

                    return DropdownButtonFormField<PontoVenda>(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal)),
                          filled: true,
                          isDense: true,
                          hintText: labelCampo,
                          labelText: labelCampo),
                      isExpanded: true,
                      items: controlePontoVenda.listaObjetosPesquisados == null
                          ? []
                          : controlePontoVenda.listaObjetosPesquisados!
                              .map<DropdownMenuItem<PontoVenda>>(
                                  (PontoVenda pontoVenda) {
                              return DropdownMenuItem<PontoVenda>(
                                value: pontoVenda,
                                child: Text(pontoVenda.nome!,
                                    textAlign: TextAlign.center),
                              );
                            }).toList(),
                      value: pontoVendaSelecionado,
                      validator: (value) {
                        if (value == null) {
                          return "Campo Obrigatório!";
                        }
                        return null;
                      },
                      onChanged: (PontoVenda? value) {
                        setState(() {
                          pontoVendaSelecionado = value;
                        });
                      },
                    );
                  }),
            ],
          )),
    );
  }
}
