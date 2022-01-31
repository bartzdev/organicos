import 'package:flutter/material.dart';

mensagemConexao(context) {
  showDialog(
      context: context,
      builder: (BuildContext builder) {
        return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: const Text('ALERTA'),
            content: const Text('Verifique sua conexão e tente novamente',
                textAlign: TextAlign.center),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    //Ação do botão NÃO
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK")),
              const SizedBox(
                width: 20,
                height: 20,
              )
            ]);
      });
}

mensagemAutenticacao(context, String messagem, String acao) {
  showDialog(
      context: context,
      builder: (BuildContext builder) {
        return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text(acao),
            content: Text(messagem, textAlign: TextAlign.center),
            actionsAlignment: MainAxisAlignment.center,
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    //Ação do botão NÃO
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK")),
              const SizedBox(
                width: 20,
                height: 20,
              )
            ]);
      });
}
