import 'package:flutter/material.dart';
import 'package:organicos/visao/tela_selecao_mapa.dart';

class TelaPrincipal extends StatefulWidget {
  TelaPrincipal({Key? key}) : super(key: key);

  @override
  _TelaPrincipalState createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Quitanda Orgânica")),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.map),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TelaSelecaoMapa((double latitude, double longitude) {
                        print("Latitude: $latitude");
                        print("Longitude: $longitude");
                      })));
        },
      ),
    );
  }
}
