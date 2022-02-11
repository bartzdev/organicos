import 'dart:async';

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
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? gMapController;
  Set<Marker> markers = Set<Marker>();
  List<ItemPesquisaGeral> resultadoPesquisa = [];
  Future<List<ItemPesquisaGeral>>? futureItensPesquisa;

  @override
  void initState() {
    super.initState();
    _atualizarpesquisa();
  }

  _atualizarpesquisa(){

      futureItensPesquisa = PesquisaGeralDAO()
                        .pesquisar(filtros: {"filtro": ''});
  }
  _atualizarMarcadores(){
    int tam = resultadoPesquisa.length;
      ItemPesquisaGeral item;
      List<PontoVenda>? pontos;
      Produtor? produtor;
        Future <void> _addMarkerLongPressed(LatLng latlang) async {
        final MarkerId markerId = MarkerId(generateUniqueID());
        Marker marker = Marker(
          markerId: markerId,
          draggable: true,
          position: latlang,
          icon: BitmapDescriptor.defaultMarker,
        );
        markers.add(marker);
      
      }

      markers.clear();
      for(int i = 0; i < tam; i++){
        item = resultadoPesquisa[i];
        pontos = item.pontosVenda;
        produtor = item.produtor;
      
      if(pontos.isEmpty){
        double lat = double.parse(produtor!.latitude!);
        double long = double.parse(produtor.longitude!);
        LatLng latlong = new LatLng(lat, long);
        _addMarkerLongPressed(latlong);
      } else {
        int tam = pontos.length;
        for(int i = 0; i < tam; i++){
          PontoVenda ponto = pontos[i];
          double lat = double.parse(ponto.latitude!);
          double long = double.parse(ponto.longitude!);
          LatLng latlong = new LatLng(lat, long);

          if(markers.contains(latlong)){

          } else {
            _addMarkerLongPressed(latlong);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Produto alface = Produto()..nome = "Alface Crespa Orgânica";
    Produto rucula = Produto()..nome = "Rucula da boa";

    Produtor joao = Produtor()..nome = "João de Paula";
    joao.telefone = '44998762665';
    Produtor manuel = Produtor()..nome = "Manuel de Souza Andrade";
    manuel.telefone = '44998762665';
    PontoVenda p1 = PontoVenda();
    p1.latitude = "-24.4030653";
    p1.longitude = "-53.5073557";
    p1.nome = "Feira principal";
    PontoVenda p2 = PontoVenda();
    p2.nome = "Feira da praça";
    p2.latitude = "-24.409763";
    p2.longitude = "-53.528315";
    PontoVenda p3 = PontoVenda();
    p3.nome = "Casa do produtor";
    p3.latitude = "-24.4151515";
    p3.longitude = "-53.5193555";

    List<PontoVenda> pontos = [p1, p2, p3];

    List<PontoVenda> pontos2 = [PontoVenda()..nome = "Feira principal"];

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
        ..produto = alface
        ..produtor = manuel
        ..pontosVenda = pontos2
    ];

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
                      itemPesquisaGeral.produtor?.telefone == null
                          ? SizedBox()
                          : IconButton(
                              iconSize: 35,
                              icon: Image.asset(
                                'assets/imagens/WhatsAppIcon48.png',
                              ),
                              onPressed: () {
                                geraLinkURL(
                                    itemPesquisaGeral.produtor!.telefone!, '');
                              },
                            )
                    ],
                  )),
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
                                  IconButton(
                                    iconSize: 8,
                                    icon: Image.asset(
                                      'assets/imagens/alfinete.png',
                                    ),
                                    onPressed: () {
                                      geraLinkURL(
                                          itemPesquisaGeral
                                              .pontosVenda[indice].latitude!,
                                          itemPesquisaGeral
                                              .pontosVenda[indice].longitude!);
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
                    future: futureItensPesquisa,
                    builder:
                        (BuildContext context, AsyncSnapshot<List> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                            child: const Text(
                          "A consulta não retornou dados!",
                          style: const TextStyle(fontSize: 20),
                        ));
                      }

                      resultadoPesquisa = snapshot.data
                          as List<
                              ItemPesquisaGeral>;
                              _atualizarMarcadores(); //Carrega os dados retornados em uma lista (não futura) para ser mostrada na listview
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

    Future<CameraPosition> getCurrentLocationCameraPosition() async {
      var locationData = await getCurrentLocation();
      
      return CameraPosition(
          bearing: 0,
          target: LatLng(locationData!.latitude!, locationData.longitude!),
          // tilt: 59.440717697143555,
          tilt: 90,
          zoom: 19.151926040649414);
    }

    Widget abaMapa() {
      
      return FutureBuilder<CameraPosition>(
          future: getCurrentLocationCameraPosition(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              CameraPosition _myLocation = snapshot.data;
              return GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: _myLocation,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  gMapController = controller;
                },
                rotateGesturesEnabled: true,
                scrollGesturesEnabled: true,
                tiltGesturesEnabled: true,
                zoomGesturesEnabled: true,
                mapToolbarEnabled: true,
                compassEnabled: true,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                onLongPress: (latlang) {},
                markers: markers,
                // circles: circles,
              );
            }
            return SizedBox();
          });
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
