import 'package:flutter/material.dart';
import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/modelo/permissoes.dart';

class CheckboxWidget extends StatefulWidget {
  @override
  CheckboxWidgetState createState() => new CheckboxWidgetState();
}

void lista() {
  ControleCadastros<Permissao> controle = ControleCadastros(Permissao());

  var acm = controle.listar();
}

class CheckboxWidgetState extends State {
  ControleCadastros<Permissao> controle = ControleCadastros(Permissao());
  List<Permissao> listaPermissao = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controle.listar().then((value) {
      listaPermissao = value;
    });
  }

  Map<String, bool?> values = {
    'Laranja': false,
    'Banana': false,
    'Roxo': false,
    'Morango': false,
    'Azul': false,
  };

  var tmpArray = [];

  getCheckboxItems() {
    values.forEach((key, value) {
      if (value == true) {
        tmpArray.add(key);
      }
    });

    // Clear array after use.
    tmpArray.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Expanded(
        child: ListView(
          children: values.keys.map((String key) {
            return new CheckboxListTile(
              tristate: true,
              title: new Text(key),
              value: values[key],
              activeColor: Colors.green,
              checkColor: Colors.white,
              onChanged: (bool? value) {
                setState(() {
                  values[key] = value;
                });
              },
            );
          }).toList(),
        ),
      ),
    ]);
  }
}
