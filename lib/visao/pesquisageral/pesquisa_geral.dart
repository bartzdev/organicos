import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/item_pesquisa_geral.dart';
import 'package:organicos/modelo/ponto_venda.dart';
import 'package:organicos/modelo/produto.dart';
import 'package:organicos/modelo/produtor.dart';
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

  double _distanciaKM = 10;

  @override
  Widget build(BuildContext context) {
    Produto alface = Produto()..nome = "Alface";
    Produto rucula = Produto()..nome = "Rucula";

    Produtor joao = Produtor()..nome = "João";
    Produtor manuel = Produtor()..nome = "Manuel";

    List<PontoVenda> pontos = [
      PontoVenda()..nome = "Feira principal",
      PontoVenda()..nome = "Feira da praça",
      PontoVenda()..nome = "Casa do produtor"
    ];

    List<ItemPesquisaGeral> itensPesquisa = [
      ItemPesquisaGeral()
        ..produto = alface
        ..produtor = joao
        ..pontosVenda = pontos,
      ItemPesquisaGeral()
        ..produto = rucula
        ..produtor = manuel
        ..pontosVenda = pontos,
      ItemPesquisaGeral()
        ..produto = rucula
        ..produtor = manuel
        ..pontosVenda = pontos
    ];

    Widget _linhaListaPesquisa(
        ItemPesquisaGeral itemPesquisaGeral, int indice) {
      return Container(
          decoration: BoxDecoration(
              // border: Border(
              //     bottom: BorderSide(
              //   color: Colors.grey,
              //   width: 0.8,
              // )),
              color: indice % 2 == 0 ? Colors.grey.shade300 : Colors.white),
          child: ListTile(
              title:
                  //Layout da linha
                  Row(children: [
            Text('Em construção',
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.left),
          ])
              ////////////////////////////////////////////////////////

              ));
    }

    return Scaffold(
      appBar: new AppBar(
        title: Text(
          'Pesquisa de produtos\ne produtores',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            espacoEntreCampos,
            FutureBuilder(
                future: controleTipoProduto.listar(),
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
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
                builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                  String labelCampo = "Pontos de venda";
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
            espacoEntreCampos,
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
                  hintText: "Produtor...",
                  hintStyle: new TextStyle(color: Colors.grey),
                  prefixIcon: new Icon(Icons.search, color: Colors.grey),
                ),
                autofocus: true),

            espacoEntreCampos,

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
                  hintText: "Produto...",
                  hintStyle: new TextStyle(color: Colors.grey),
                  prefixIcon: new Icon(Icons.search, color: Colors.grey),
                ),
                autofocus: true),
            espacoEntreCampos,
            Text(
              'Distância: ${_distanciaKM.round().toString()} km',
              textAlign: TextAlign.center,
            ),
            SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  valueIndicatorColor:
                      Colors.blue, // This is what you are asking for
                  inactiveTrackColor: Color(0xFF61b255), // Custom Gray Color
                  activeTrackColor: Color(0xFF61b255),
                  thumbColor: Color(0xFF61b255),
                  overlayColor: Color(0xFF61b255), // Custom Thumb overlay Color
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 12.0),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
                ),
                child: Slider(
                  value: _distanciaKM,
                  max: 100,
                  divisions: 20,
                  onChanged: (double value) {
                    setState(() {
                      _distanciaKM = value;
                    });
                  },
                )),

            Container(color: Colors.red, height: 20, width: double.infinity),
            Container(
                width: double.infinity,
                height: 800,
                child: FutureBuilder(
                    future:
                        Future.value(itensPesquisa), //Mudar para pegar do DAO
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
      )),
    );
  }
}
