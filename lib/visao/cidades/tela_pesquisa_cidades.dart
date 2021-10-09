import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/cidade.dart';

class TelaPesquisaCidades extends StatefulWidget {
  Function(Cidade cidade)? onItemSelected;
  TelaPesquisaCidades({Key? key, this.onItemSelected}) : super(key: key);

  @override
  _TelaPesquisaCidadesState createState() => _TelaPesquisaCidadesState();
}

class _TelaPesquisaCidadesState extends State<TelaPesquisaCidades> {
  ControleCadastros<Cidade> _controle = ControleCadastros(Cidade());

  bool _pesquisaAtiva = false;
  late IconButton _botaoPesquisar;
  late IconButton _botaoCancelarPesquisa;
  TextEditingController _controladorCampoPesquisa = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controle.atualizarPesquisa();
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
            //Ação de cancelamento de pesquisa
            _controle.atualizarPesquisa();
            _controladorCampoPesquisa.clear();
          });
        },
        icon: Icon(Icons.close));
  }

  PreferredSizeWidget _montarCabecalho() {
    return AppBar(
      centerTitle: true,
      title: _pesquisaAtiva
          ? TextField(
              textInputAction: TextInputAction.search,
              onSubmitted: (text) {
                setState(() {
                  //Ação de pesquisa
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
          : Text('Cidades'),
      actions: [_pesquisaAtiva ? _botaoCancelarPesquisa : _botaoPesquisar],
    );
  }

  Widget _linhaListaZebrada(Cidade cidade, int indice) {
    return Container(
        decoration: BoxDecoration(color: indice % 2 == 0 ? Colors.grey.shade300 : Colors.white),
        child: ListTile(
            onTap: () {
              if (widget.onItemSelected != null) widget.onItemSelected!(cidade);
            },
            title: Row(
              children: [
                Expanded(
                    child: Text(
                        cidade.nome == null
                            ? ''
                            : cidade.nome! + (cidade.estado?.nome == null ? '' : ' - ' + cidade.estado!.nome!),
                        style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.normal),
                        textAlign: TextAlign.left))
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _montarCabecalho(),
      body: FutureBuilder(
          future: _controle.futuraListaObjetosPesquisados,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (!snapshot.hasData)
              return Center(
                  child: new Container(
                      child: Text(
                "A consulta não retornou dados!",
                style: TextStyle(fontSize: 20),
              )));

            _controle.listaObjetosPesquisados = snapshot.data
                as List<Cidade>; //Carrega os dados retornados em uma lista (não futura) para ser mostrada na listview

            return ListView.builder(
              itemCount: _controle.listaObjetosPesquisados!.length,
              itemBuilder: (BuildContext context, int index) {
                return _linhaListaZebrada(_controle.listaObjetosPesquisados![index], index);
              },
            );
          }),
    );
  }
}
