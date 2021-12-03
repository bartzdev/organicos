import 'package:flutter/material.dart';
import 'package:organicos/visao/pontosvenda/tela_pesquisa_pontovenda.dart';
import 'package:organicos/visao/produto/tela_pesquisa_produto.dart';
import 'package:organicos/visao/styles/styles.dart';
import 'package:organicos/visao/tela_selecao_mapa.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:organicos/visao/usuario/tela_pesquisa_usuario.dart';

class TelaPrincipal extends StatefulWidget {
  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {

  Widget botaoMenu(String textoBotao, Function()? onButtonClick) {
    return InkWell(
        onTap: onButtonClick,
        child: Neumorphic(
            style: NeumorphicStyle(
              shape: NeumorphicShape.convex,
              border: NeumorphicBorder(
                color: Color(0x10000000),
                width: 0.1,
              ),
              boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
              depth: -8,
              intensity: 0.8,
              lightSource: LightSource.bottomRight,
              color: Colors.green[50],
            ),
            child: Container(
              width: 100,
              height: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text(textoBotao)],
              ),
            )));
  }

  Widget abaCadastros() {
    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            spacing: 30.0,
            runSpacing: 30.0,
            children: [
              botaoMenu('Produtores', () {
                //    Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //        //   builder: (context) => TelaPesquisaProdutor()));
              }),
              botaoMenu('Clientes', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TelaPesquisaUsuario()));
              }),
              botaoMenu('Pontos\nVendas', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TelaPesquisaPontoVenda()));
              }),
              botaoMenu('Produtos', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TelaPesquisaProduto()));
              }),
              botaoMenu('Cadastro de \nUnidades', () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => TelaPesquisaUnidade()));
              }),
            ],
          )),
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
      theme: temaGeralApp,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.logout)),
            ],
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.search)),
                Tab(icon: Icon(Icons.engineering))
              ],
            ),
            title: Text('Tela Inicial' //, style: GoogleFonts.openSans()
                ),
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
