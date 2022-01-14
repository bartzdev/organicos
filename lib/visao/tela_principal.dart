import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/grupo_usuario.dart';
import 'package:organicos/modelo/usuario.dart';
import 'package:organicos/visao/certificadora/tela_pesquisa_certificadora.dart';
import 'package:organicos/visao/grupoprodutor/tela_pesquisa_grupoprodutos.dart';
import 'package:organicos/visao/grupousuario/tela_pesquisa_grupousuario.dart';
import 'package:organicos/visao/pontosvenda/tela_pesquisa_pontovenda.dart';
import 'package:organicos/visao/produto/tela_pesquisa_produto.dart';
import 'package:organicos/visao/produtor/tela_cadastro_produtor.dart';
import 'package:organicos/visao/produtor/tela_pesquisa_produtor.dart';
import 'package:organicos/visao/relatorios/tela_relatorio_apres.dart';
import 'package:organicos/visao/relatorios/tela_relatorio_produtores.dart';
import 'package:organicos/visao/styles/styles.dart';
import 'package:organicos/visao/tela_selecao_mapa.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:organicos/visao/tipoProdutos/tela_pesquisa_tipoProduto.dart';
import 'package:organicos/visao/unidade/tela_pesquisa_unidade.dart';
import 'package:organicos/visao/usuario/tela_pesquisa_usuario.dart';

class TelaPrincipal extends StatefulWidget {
  TelaPrincipal({Key? key}) : super(key: key);
  ControleCadastros<Usuario> _controle = ControleCadastros<Usuario>(Usuario());

  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  ControleCadastros<GrupoUsuario> _controle =
      ControleCadastros<GrupoUsuario>(GrupoUsuario());
  Widget botaoMenu(
      String caminhoIcone, String textoBotao, Function()? onButtonClick) {
    return InkWell(
        onTap: onButtonClick,
        child: Stack(children: [
          Column(children: [
            SizedBox(
              height: 20,
            ),
            Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.convex,
                  border: NeumorphicBorder(
                    color: Color(0x10000000),
                    width: 0.1,
                  ),
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                  depth: -8,
                  intensity: 0.8,
                  lightSource: LightSource.bottomRight,
                  color: Colors.green[50],
                ),
                child: Container(
                  width: 100,
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(textoBotao)],
                  ),
                ))
          ]),
          Positioned(
              top: -14,
              left: 5,
              child: SizedBox(
                  height: 85,
                  width: 50,
                  child: Image.asset(
                    caminhoIcone,
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.contain,
                  )))
        ]));
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
              botaoMenu("assets/imagens/imgProdutor.png", 'Produtores', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TelaPesquisaProdutor()));
              }),
              botaoMenu(
                  "assets/imagens/imgGrupoProdutores.png", 'Grupo\nProdutores',
                  () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TelaPesquisaGrupoProdutor()));
              }),
              botaoMenu("assets/imagens/imgPontoVendas.png", 'Pontos\nVendas',
                  () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TelaPesquisaPontoVenda()));
              }),
              botaoMenu("assets/imagens/imgProduto.png", 'Produtos', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TelaPesquisaProduto()));
              }),
              botaoMenu("assets/imagens/imgTipoProduto.png", 'Tipo\nProdutos',
                  () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TelaPesquisaTipoProduto()));
              }),
              botaoMenu("assets/imagens/imgUnidades.png", 'Unidades', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TelaPesquisaUnidade()));
              }),
              botaoMenu("assets/imagens/imgCertificadora.png", 'Certificadoras',
                  () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TelaPesquisaCertificadora()));
              }),
              botaoMenu("assets/imagens/imgRelatorio.png", 'Relatórios', () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TelaGerarRelatorio()));
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
          botaoMenu("assets/imagens/imgUsuarios.png", 'Usuários', () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TelaPesquisaUsuario()));
          }),
          botaoMenu("assets/imagens/imgGrupoUsuarios.png", 'Grupo\nUsuários',
              () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TelaPesquisaGrupousuario()));
          }),
        ],
      ),
    )));
  }

  Widget abaSobre() {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ListView(children: [
          Container(
              decoration: new BoxDecoration(
                  color: Color(0xFF61b255),
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(50),
                    bottomRight: const Radius.circular(50),
                  )),
              width: MediaQuery.of(context).size.width,
              height: 265,
              //color: Color(0xFF61b255),
              child: Image.asset('assets/imagens/logoOrganico.jpeg')),
          Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [
                  Text(
                    'Este aplicativo foi desenvolvido com o objetivo de aproximar os produtores da agricultura familiar de seus consumidores. ',
                    textAlign: TextAlign.justify,
                    textWidthBasis: TextWidthBasis.longestLine,
                  ),
                  SizedBox(height: 20),
                  Text(
                      'Atualmente o aplicativo faz parte de um projeto de extensão coordenado pela professora Sonia Mandotti, que faz o acompanhamento técnico dos produtores de Assis Chateaubriand.',
                      textAlign: TextAlign.justify),
                  SizedBox(height: 20),
                  Text(
                      'O projeto foi desenvolvido pelos estudantes: Gabriel Gaban de Lima, Gabriel Leopoldo Locks, Italo Rodrigues dos Santos, Karollyne de Paulo Marcola, Lucas  Wesolowski Medeiros e Rafael Shono,'
                      ' do Instituto Federal do Paraná campus Assis Chateaubriand, para a disciplina de programação para dispositivos móveis ministrada pelo professor doutor Rafael Luis Bartz.',
                      textAlign: TextAlign.justify)
                ],
              ))
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: temaGeralAppEscuro,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.logout))
            ],
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.search)),
                Tab(icon: Icon(Icons.engineering)),
                Tab(icon: Icon(Icons.info))
              ],
            ),
            title: Text('Tela Inicial'),
          ),
          body: TabBarView(
            children: [abaCadastros(), abaConfiguracoes(), abaSobre()],
          ),
        ),
      ),
    );
  }
}
