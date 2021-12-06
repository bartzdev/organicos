import 'package:organicos/modelo/usuario.dart';

class ControleSistema {
  static final ControleSistema _singleton = ControleSistema._internal();

  factory ControleSistema() {
    return _singleton;
  }
  ControleSistema._internal();

  Usuario? usuarioLogado;
  String chaveCrypto = "12345";
  String chaveAPIEmail = "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";
}
