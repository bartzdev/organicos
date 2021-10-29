import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/certificadora.dart';
import 'package:organicos/visao/certificadora/tela_cadastro_certificadora.dart';

class TelaPesquisaCertificadora extends StatefulWidget{
  _TelaPesquisaCertificadoraState createState() => _TelaPesquisaCertificadoraState();
}

class _TelaPesquisaCertificadoraState extends State<TelaPesquisaCertificadora>{
  ControleCadastros<Certificadora> _controle =
      ControleCadastros<Certificadora>(Certificadora());
  TextEditingController _controladorCampoPesquisa = TextEditingController();
  bool _pesquisaAtiva = false;
  late IconButton _botaoPesquisar;
  late IconButton _botaoCancelarPesquisa;

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
          : Text('Certificadoras'),
      actions: [_pesquisaAtiva ? _botaoCancelarPesquisa : _botaoPesquisar],
    );
 }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: _montarCabecalho(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
         icon: const Icon(Icons.add),
          onPressed: () {
            _controle.objetoCadastroEmEdicao = Certificadora();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        TelaCadastroCertificadora(_controle, onSaved: () {
                          setState(() {
                            _controle.atualizarPesquisa(filtros: {
                              'filtro': _controladorCampoPesquisa.text
                            });
                          });
                        })));
          },
          label: const Text('Adicionar')),
    );
  }
}