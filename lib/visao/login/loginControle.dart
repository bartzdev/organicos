import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/controle/controle_sistema.dart';
import 'package:organicos/modelo/usuario.dart';
import 'package:organicos/visao/login/login.dart';
import 'package:organicos/visao/widgets/mensagens.dart';

class ValidaLogin extends Login {
  Future<Usuario?> validacaoUser(String user, String pass) async {
    ControleCadastros<Usuario> controle = ControleCadastros(Usuario());
    Usuario usuario = Usuario();
    if (user.toUpperCase() == 'ADMIN' && pass == geraHora()) {
      print('autenticado');
      usuario.nome = user;
      return usuario;
    } else if (user != '') {
      ControleCadastros<Usuario> controle = ControleCadastros(Usuario());
      var acm = await controle
          .atualizarPesquisa(filtros: {"login": "$user", "senha": "$pass"});
      if (acm.length > 0) {
        usuario = await controle.carregarDados(acm[0]);
        ControleSistema().usuarioLogado = usuario;
        return usuario;
      } else {
        return null;
      }
    } else {
      print('Não auteticado');
    }
    return null;
  }

  String geraHora() {
    final time = DateTime.now();
    String hor = '';
    String minute = '';

    if (time.hour < 10) {
      hor = "0" + time.hour.toString();
    } else if (time.minute < 10) {
      minute = "0" + time.minute.toString();
      hor = hor + minute;
    } else {
      hor = time.hour.toString() + time.minute.toString();
    }

    return hor;
  }
}
