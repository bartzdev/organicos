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
          Padding(padding: EdgeInsets.all(30)),
          Text(
            '''Este aplicativo foi desenvolvido com o objetivo de aproximar os produtores da agricultura familiar dos seus consumidores.
           O projeto foi desenvolvido pelos estudantes a, Gabriel Gaban de Lima, Gabriel Leopoldo Locks, Italo Rodrigues dos Santos, Karollyne de Paulo Marcola, Lucas  Wesolowski Medeiros, Rafael Shono
           do Instituto Federal do Paraná campus Assis Chateaubriand, \na disciplina de programação para dispositivos móveis ministrada pelo professor doutor Rafael Luis Bartz. 
          Atualmente o aplicativo faz parte de um projeto de extensão coordenado pela professora Sonia Mandotti, que faz o acompanhamento técnico dos produtores de Assis Chateaubriand 
''',
            textAlign: TextAlign.justify,
            textWidthBasis: TextWidthBasis.longestLine,
          )
        ]));
  }
}
