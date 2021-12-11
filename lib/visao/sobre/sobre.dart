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
                      'O projeto foi desenvolvido pelos estudantes: Gabriel Gaban de Lima, Gabriel Leopoldo Locks, Italo Rodrigues dos Santos, Karollyne de Paulo Marcola, Lucas  Wesolowski Medeiros, Rafael Shono'
                      ' do Instituto Federal do Paraná campus Assis Chateaubriand, para a disciplina de programação para dispositivos móveis ministrada pelo professor doutor Rafael Luis Bartz.',
                      textAlign: TextAlign.justify)
                ],
              ))
        ]));
  }
}
