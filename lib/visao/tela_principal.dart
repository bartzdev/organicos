import 'package:flutter/material.dart';
import 'package:organicos/visao/pontosvenda/tela_pesquisa_pontovenda.dart';
import 'package:organicos/visao/tela_selecao_mapa.dart';

class TelaPrincipal extends StatefulWidget {
  TelaPrincipal({Key? key}) : super(key: key);

  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  Widget botaoMenu(String textoBotao, Function()? onButtonClick) {
    return InkWell(
        onTap: onButtonClick,
        child: Container(
          width: 100,
          height: 140,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
                topLeft: Radius.circular(10),
                topRight: Radius.circular(50)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Colors.green.shade800, Colors.lightBlue.shade300],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text(textoBotao)],
          ),
        ));
  }

  Widget abaCadastros() {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        spacing: 40.0,
        runSpacing: 40.0,
        children: [
          botaoMenu('produtores', () {}),
          botaoMenu('clientes', () {}),
          botaoMenu('pontos\nvendas', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TelaPesquisaPontoVenda()));
          }),
          botaoMenu('produtos', () {}),
        ],
      ),
    )));
  }

  Widget abaConfiguracoes() {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Wrap(
        direction: Axis.horizontal,
        alignment: WrapAlignment.center,
        spacing: 40.0,
        runSpacing: 40.0,
        children: [
          botaoMenu('Permissões', () {}),
        ],
      ),
    )));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.search)),
                Tab(icon: Icon(Icons.engineering))
              ],
            ),
            title: Text('Tela Incial'),
          ),
          body: TabBarView(
            children: [
              abaCadastros(),
              abaConfiguracoes(),
            ],
          ),
        ),
      ),
    );
  }
}
