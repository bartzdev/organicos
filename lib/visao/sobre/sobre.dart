import 'package:flutter/material.dart';

class Sobre extends StatelessWidget {
  const Sobre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sobre'),
          centerTitle: true,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ListView(children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: 300,
              color: Color(0xFF61b255),
              child: Image.asset('assets/imagens/logoOrganico.jpeg')),
          Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                'Este aplicativo foi desenvolvido com o objetivo de aproximar os produtores da agricultura familiar dos seus consumidores. ' +
                    '\n   O projeto foi desenvolvido pelos estudantes a, Gabriel Gaban de Lima, Gabriel Leopoldo Locks, Italo Rodrigues dos Santos, Karollyne de Paulo Marcola, Lucas  Wesolowski Medeiros, Rafael Shono' +
                    ' do Instituto Federal do Paraná campus Assis Chateaubriand, a disciplina de programação para dispositivos móveis ministrada pelo professor doutor Rafael Luis Bartz.' +
                    '\n   Atualmente o aplicativo faz parte de um projeto de extensão coordenado pela professora Sonia Mandotti, que faz o acompanhamento técnico dos produtores de Assis Chateaubriand.',
                textAlign: TextAlign.justify,
                textWidthBasis: TextWidthBasis.longestLine,
              ))
        ]));
  }
}
