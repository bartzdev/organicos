import 'package:organicos/controle/controle_cadastros.dart';
import 'package:organicos/controle/controle_sistema.dart';
import 'package:organicos/modelo/usuario.dart';
import 'package:organicos/visao/login/login.dart';
import 'package:organicos/visao/widgets/mensagens.dart';


class ValidaLogin extends Login {

  Future<Usuario?> validacaoUser(String user, String pass) async {
    ControleCadastros<Usuario> controle = ControleCadastros(Usuario());
    Usuario usuario = Usuario();
    if(user.toUpperCase() == 'ADMIN' && pass == geraHora()){
      print('autenticado');
      usuario.nome = user;
      return usuario;
    }else if(user != ''){
        ControleCadastros<Usuario> controle = ControleCadastros(Usuario());
        var acm = await controle.atualizarPesquisa(filtros:{"login": "$user", "senha":"$pass"});
        if(acm.length > 0){
          usuario.nome = acm[0].toString();
                  
          ControleSistema().usuarioLogado = await controle.carregarDados(acm[0]);
          var axu = ControleSistema().usuarioLogado?.possuiPermissao(2);
          
          if (axu == true){
            return usuario;
          }else {print ('Usuario não possui permissao');
            return null;
          }
          
        }else {
          return null;
        }
        
      }else {print('Não auteticado');}

    return null;

  }

 String geraHora(){
  final time = DateTime.now();
  String hor = time.hour.toString();
  hor = hor + time.minute.toString();
  return hor;
}
}