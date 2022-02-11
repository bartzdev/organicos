import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/controle/controle_sistema.dart';
import 'package:organicos/modelo/grupo_usuario.dart';
import 'package:organicos/modelo/permissoes.dart';
import 'package:organicos/modelo/usuario.dart';
import 'package:organicos/visao/certificadora/tela_pesquisa_certificadora.dart';
import 'package:organicos/visao/grupoprodutor/tela_pesquisa_grupoprodutos.dart';
import 'package:organicos/visao/grupousuario/tela_pesquisa_grupousuario.dart';
import 'package:organicos/visao/pesquisageral/pesquisa_geral.dart';
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
                    color: Color(0xff44BD5A),
                    width: 0,
                  ),
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
                  depth: 5,
                  intensity: 0,
                  lightSource: LightSource.topLeft,
                  color: Color(0xff9FD195),
                ),
                child: Container(
                  width: 105,
                  height: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(textoBotao, textAlign: TextAlign.center)],
                  ),
                ))
          ]),
          Positioned(
              top: -8,
              left: 28,
              child: SizedBox(
                  height: 130,
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
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
          child: Wrap(
            direction: Axis.horizontal,
            alignment: WrapAlignment.start,
            spacing: 30.0,
            runSpacing: 30.0,
            children: [
              ControleSistema().usuarioLogado!.possuiPermissao(1)
                  ? botaoMenu(
                      "assets/imagens/imgProdutor.png", '\n\nProdutores', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TelaPesquisaProdutor()));
                    })
                  : SizedBox(),
              ControleSistema().usuarioLogado!.possuiPermissao(3)
                  ? botaoMenu("assets/imagens/imgGrupoProdutores.png",
                      '\n\nGrupo\nProdutores', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TelaPesquisaGrupoProdutor()));
                    })
                  : SizedBox(),
              ControleSistema().usuarioLogado!.possuiPermissao(5)
                  ? botaoMenu(
                      "assets/imagens/imgPontoVendas.png", '\n\nPontos\nVendas',
                      () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TelaPesquisaPontoVenda()));
                    })
                  : SizedBox(),
              ControleSistema().usuarioLogado!.possuiPermissao(7)
                  ? botaoMenu("assets/imagens/imgProduto.png", '\nProdutos',
                      () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TelaPesquisaProduto()));
                    })
                  : SizedBox(),
              ControleSistema().usuarioLogado!.possuiPermissao(9)
                  ? botaoMenu(
                      "assets/imagens/imgTipoProduto.png", '\n\nTipo\nProdutos',
                      () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TelaPesquisaTipoProduto()));
                    })
                  : SizedBox(),
              ControleSistema().usuarioLogado!.possuiPermissao(11)
                  ? botaoMenu("assets/imagens/imgUnidades.png", '\n\nUnidades',
                      () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TelaPesquisaUnidade()));
                    })
                  : SizedBox(),
              ControleSistema().usuarioLogado!.possuiPermissao(13)
                  ? botaoMenu("assets/imagens/imgCertificadora.png",
                      '\n\nCertificadoras', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TelaPesquisaCertificadora()));
                    })
                  : SizedBox(),
              ControleSistema().usuarioLogado!.possuiPermissao(15)
                  ? botaoMenu(
                      "assets/imagens/imgRelatorio.png", '\n\nRelatórios', () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TelaGerarRelatorio()));
                    })
                  : SizedBox(),
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
          ControleSistema().usuarioLogado!.possuiPermissao(16)
              ? botaoMenu("assets/imagens/imgUsuarios.png", '\n\nUsuários', () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TelaPesquisaUsuario()));
                })
              : SizedBox(),
          ControleSistema().usuarioLogado!.possuiPermissao(18)
              ? botaoMenu(
                  "assets/imagens/imgGrupoUsuarios.png", '\n\nGrupo\nUsuários',
                  () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TelaPesquisaGrupousuario()));
                })
              : SizedBox(),
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
              height: 250,
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
      theme: temaGeralAppClaro,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                  onPressed: () {
                    //   Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelaPesquisaGeral()));
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
            children: [
              abaCadastros(),
              abaConfiguracoes(),
              abaSobre(),
            ],
          ),
        ),
      ),
    );
  }
}
