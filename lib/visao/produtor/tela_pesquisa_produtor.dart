import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/ponto_venda.dart';
import 'package:organicos/modelo/produtor.dart';
import 'package:organicos/visao/pontosvenda/tela_cadastro_pontovenda.dart';
import 'package:organicos/visao/produtor/tela_cadastro_produtor.dart';

class TelaPesquisaProdutor extends StatefulWidget {
  @override
  _TelaPesquisProdutor createState() => _TelaPesquisProdutor();
}

class _TelaPesquisProdutor extends State<TelaPesquisaProdutor> {
  ControleCadastros<Produtor> _controle =
      ControleCadastros<Produtor>(Produtor());
  bool _pesquisaAtiva = false;
  late IconButton _botaoPesquisar;
  late IconButton _botaoCancelarPesquisa;
  TextEditingController _controladorCampoPesquisa = TextEditingController();

  @override
  void initState() {
    super.initState();
    _botaoPesquisar = IconButton(
        onPressed: () {
          setState(() {
            _pesquisaAtiva = true;
          });
        },
        icon: Icon(Icons.search));
    _botaoCancelarPesquisa = IconButton(
        onPressed: () {
          setState(() {
            _pesquisaAtiva = false;
            //Ação de cancelamento de pesquisa aqui
            _controladorCampoPesquisa.text = '';
            _controle.atualizarPesquisa();
          });
        },
        icon: Icon(Icons.close));
    _controle.atualizarPesquisa();
  }

  PreferredSizeWidget _montarCabecalho() {
    return AppBar(
      centerTitle: true,
      title: _pesquisaAtiva
          ? TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (text) {
                setState(() {
                  //Ação de pesquisa aqui
                  _controle.atualizarPesquisa(filtros: {'filtro': text});
                });
              },
              controller: _controladorCampoPesquisa,
              style: new TextStyle(
                color: Colors.white,
              ),
              decoration: new InputDecoration(
                  prefixIcon: new Icon(Icons.search, color: Colors.white),
                  hintText: "Pesquisar...",
                  hintStyle: new TextStyle(color: Colors.white)),
              autofocus: true)
          : Text('Produtores'),
      actions: [_pesquisaAtiva ? _botaoCancelarPesquisa : _botaoPesquisar],
    );
  }

  Widget _linhaListaZebrada(Produtor produtor, int indice) {
    return Container(
        decoration: BoxDecoration(
            // border: Border(
            //     bottom: BorderSide(
            //   color: Colors.grey,
            //   width: 0.8,
            // )),
            color: indice % 2 == 0 ? Colors.grey.shade300 : Colors.white),
        child: ListTile(
            title: Row(children: [
          Expanded(
              child: Text(produtor.nome == null ? '' : produtor.nome!,
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                  textAlign: TextAlign.left)),
          IconButton(
              onPressed: () async {
                //Ação do botão Editar
                //_controle.objetoCadastroEmEdicao = await _controle.carregarDados(pontoVenda);
                _controle.carregarDados(produtor).then((value) {
                  _controle.objetoCadastroEmEdicao = value;
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              TelaCadastroProdutor(_controle, onSaved: () {
                                setState(() {
                                  _controle.atualizarPesquisa(filtros: {
                                    'filtro': _controladorCampoPesquisa.text
                                  });
                                });
                              })));
                });
              },
              icon: const Icon(Icons.edit),
              color: Colors.orange.shade600),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext builder) {
                      return AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        title: const Text('ATENÇÃO'),
                        content: const Text(
                            'Deseja realmente excluir este registro?',
                            textAlign: TextAlign.center),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: <Widget>[
                          TextButton(
                              onPressed: () {
                                //Ação do botão SIM
                                _controle
                                    .carregarDados(produtor)
                                    .then((value) {
                                  _controle.objetoCadastroEmEdicao = value;
                                  _controle
                                      .excluirObjetoCadastroEmEdicao()
                                      .then((_) {
                                    Navigator.of(context).pop();
                                    setState(() {
                                      _controle.listaObjetosPesquisados
                                          ?.remove(produtor);
                                    });
                                  });
                                });
                              },
                              child: const Text("SIM")),
                          const SizedBox(
                            width: 20,
                            height: 20,
                          ),
                          TextButton(
                              onPressed: () {
                                //Ação do botão NÃO
                                Navigator.of(context).pop();
                              },
                              child: const Text("NÃO"))
                        ],
                      );
                    });
              },
              icon: const Icon(Icons.delete),
              color: Colors.red),
        ])));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _montarCabecalho(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          onPressed: () {
            _controle.objetoCadastroEmEdicao = Produtor();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TelaCadastroProdutor(_controle, onSaved: () {
                          setState(() {
                            print('Entrou aqui');
                            _controle.atualizarPesquisa(filtros: {
                              'filtro': _controladorCampoPesquisa.text
                            });
                          });
                        })));
          },
          label: const Text('Adicionar')),
      body: FutureBuilder(
          future: _controle.futuraListaObjetosPesquisados,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                  child: const Text(
                "A consulta não retornou dados!",
                style: const TextStyle(fontSize: 20),
              ));
            }

            _controle.listaObjetosPesquisados = snapshot.data as List<
                Produtor>; //Carrega os dados retornados em uma lista (não futura) para ser mostrada na listview

            return ListView.builder(
              itemCount: _controle.listaObjetosPesquisados!.length,
              itemBuilder: (BuildContext context, int index) {
                return _linhaListaZebrada(
                    _controle.listaObjetosPesquisados![index], index);
              },
            );
          }),
    );
  }
}
