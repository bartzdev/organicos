import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/dao/pesquisa_geral_dao.dart';
import 'package:organicos/modelo/item_pesquisa_geral.dart';
import 'package:organicos/modelo/ponto_venda.dart';
import 'package:organicos/modelo/produto.dart';
import 'package:organicos/modelo/produtor.dart';
import 'package:organicos/modelo/tipo_produto.dart';
import 'package:organicos/modelo/utilitarios.dart';
import 'package:organicos/visao/login/login.dart';
import 'package:organicos/visao/styles/styles.dart';
import 'package:organicos/visao/tela_principal.dart';

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

  double _distanciaKM = 10;

  @override
  Widget build(BuildContext context) {
    Widget _linhaListaPesquisa(
        ItemPesquisaGeral itemPesquisaGeral, int indice) {
      return Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                color: Colors.green,
                width: 1.9,
              )),
              color: indice % 2 == 0 ? Colors.grey.shade300 : Colors.white),
          child: ListTile(
            title:
                //Layout da linha
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Expanded(
                    child: Column(
                      //mainAxisSize: MainAxisSize.max,

                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            itemPesquisaGeral.produto?.nome == null
                                ? ''
                                : itemPesquisaGeral.produto!.nome!,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                            'Produtor: ' +
                                (itemPesquisaGeral.produtor?.nome == null
                                    ? ''
                                    : itemPesquisaGeral.produtor!.nome!),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                                fontWeight: FontWeight.normal),
                            textAlign: TextAlign.left),
                        SizedBox(
                          height: 5,
                        ),
                        itemPesquisaGeral.produtor?.telefone == null
                            ? SizedBox()
                            : GestureDetector(
                                child: Image.asset(
                                  'assets/imagens/WhatsAppIcon32.png',
                                ),
                                onTap: () {
                                  geraLinkURL(
                                      itemPesquisaGeral.produtor!.telefone!,
                                      '');
                                },
                              )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Center(
                      child: Container(
                          width: 170,
                          height: itemPesquisaGeral.pontosVenda.length * 33,
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemCount: itemPesquisaGeral.pontosVenda.length,
                            itemBuilder: (BuildContext context, int indice) {
                              return Row(
                                children: [
                                  Text(
                                    itemPesquisaGeral
                                                .pontosVenda[indice].nome ==
                                            null
                                        ? ''
                                        : itemPesquisaGeral
                                            .pontosVenda[indice].nome!,
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    child: Image.asset(
                                      'assets/imagens/alfinete.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                    onTap: () {
                                      geraLinkURL(
                                          itemPesquisaGeral.produtor!.telefone!,
                                          '');
                                    },
                                  )
                                ],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int indice) {
                              return Divider(
                                thickness: 0,
                              );
                            },
                          )))
                ]),

            ////////////////////////////////////////////////////////
          ));
    }

    Future<void> exibirDialogoFiltros() async {
      StateSetter? dialogStateSetter;
      showDialog(
          context: context,
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              dialogStateSetter = setState;
              return AlertDialog(
                  insetPadding: EdgeInsets.all(10),
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  title: Text('Filtros adicionais'),
                  content: Container(
                      width: MediaQuery.of(context).size.width > 600
                          ? 600
                          : MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height < 220
                          ? MediaQuery.of(context).size.height
                          : 220,
                      child: Column(children: [
                        espacoEntreCampos,
                        FutureBuilder(
                            future: controleTipoProduto.listar(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List> snapshot) {
                              String labelCampo = "Tipo";
                              if (!snapshot.hasData) {
                                labelCampo = "Carregando dados...";
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
                                    : controleTipoProduto
                                        .listaObjetosPesquisados!
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
                                  dialogStateSetter?.call(() {
                                    tipoSelecionado = value;
                                  });
                                },
                              );
                            }),

                        espacoEntreCampos,
                        // ponto de venda

                        FutureBuilder(
                            future: controlePontoVenda.listar(),
                            builder: (BuildContext context,
                                AsyncSnapshot<List> snapshot) {
                              String labelCampo = "Pontos de venda";
                              if (!snapshot.hasData) {
                                labelCampo = "Carregando dados...";
                              } else {
                                controlePontoVenda.listaObjetosPesquisados =
                                    snapshot.data as List<PontoVenda>;
                              }

                              return DropdownButtonFormField<PontoVenda>(
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.teal)),
                                    filled: true,
                                    isDense: true,
                                    hintText: labelCampo,
                                    labelText: labelCampo),
                                isExpanded: true,
                                items: controlePontoVenda
                                            .listaObjetosPesquisados ==
                                        null
                                    ? []
                                    : controlePontoVenda
                                        .listaObjetosPesquisados!
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
                                  dialogStateSetter?.call(() {
                                    pontoVendaSelecionado = value;
                                  });
                                },
                              );
                            }),
                        espacoEntreCampos,
                        Text(
                          'Distância: ${_distanciaKM.round().toString()} km',
                          textAlign: TextAlign.center,
                        ),
                        SliderTheme(
                            data: SliderTheme.of(context).copyWith(
                              valueIndicatorColor: Colors
                                  .blue, // This is what you are asking for
                              inactiveTrackColor:
                                  Color(0xFF61b255), // Custom Gray Color
                              activeTrackColor: Color(0xFF61b255),
                              thumbColor: Color(0xFF61b255),
                              overlayColor: Color(
                                  0xFF61b255), // Custom Thumb overlay Color
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 12.0),
                              overlayShape:
                                  RoundSliderOverlayShape(overlayRadius: 20.0),
                            ),
                            child: Slider(
                              value: _distanciaKM,
                              max: 100,
                              divisions: 20,
                              onChanged: (double value) {
                                dialogStateSetter?.call(() {
                                  _distanciaKM = value;
                                });
                              },
                            )),
                      ])),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          //Ação do botão NÃO
                          Navigator.of(context).pop();
                        },
                        child: const Text("APLICAR"))
                  ]);
            });
          });
    }

    Widget abaPesquisa() {
      return SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (text) {
                  setState(() {
                    //Ação de pesquisa aqui
                    //  _controle.atualizarPesquisa(filtros: {'filtro': text});
                  });
                },
                //   controller: _controladorCampoPesquisa,
                style: new TextStyle(
                  color: Colors.blue,
                ),
                decoration: new InputDecoration(
                  hintText: "Filtro pesquisa...",
                  hintStyle: new TextStyle(color: Colors.grey),
                  prefixIcon: new Icon(Icons.search, color: Colors.grey),
                ),
                autofocus: true),
            espacoEntreCampos,
            Container(
                color: Colors.green.shade400,
                height: 10,
                width: double.infinity),
            Container(
                width: double.infinity,
                height: 800,
                child: FutureBuilder(
                    future: new PesquisaGeralDAO()
                        .pesquisar(filtros: {"filtro": ''}),
                    builder:
                        (BuildContext context, AsyncSnapshot<List> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                            child: const Text(
                          "A consulta não retornou dados!",
                          style: const TextStyle(fontSize: 20),
                        ));
                      }

                      List<ItemPesquisaGeral> resultadoPesquisa = snapshot.data
                          as List<
                              ItemPesquisaGeral>; //Carrega os dados retornados em uma lista (não futura) para ser mostrada na listview
                      return ListView.builder(
                        itemCount: resultadoPesquisa.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _linhaListaPesquisa(
                              resultadoPesquisa[index], index);
                        },
                      );
                    }))
          ],
        ),
      ));
    }

    Widget abaMapa() {
      return SizedBox();
    }

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: new AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    exibirDialogoFiltros();
                  },
                  icon: Icon(Icons.filter_alt_outlined)),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  icon: Icon(Icons.more_horiz))
            ],
            title: Text(
              'Pesquisa de produtos\ne produtores',
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Icon(Icons.search),
                  text: 'Pesquisa',
                ),
                Tab(
                  icon: Icon(Icons.map),
                  text: 'Mapa',
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [abaPesquisa(), abaMapa()],
          ),
        ));
  }
}
