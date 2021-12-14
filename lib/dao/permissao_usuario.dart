import 'package:organicos/dao/dao.dart';
import 'package:organicos/modelo/permissoes.dart';
import 'package:organicos/dao/conexao.dart';

class PermissaoUsuarioDAO extends DAO<PermissaoUsuario>{
  @override
  Future<PermissaoUsuario> carregarDados(PermissaoUsuario object, {Map<String, dynamic>? filtros}) {
    // TODO: implement carregarDados
    throw UnimplementedError();
  }

  @override
  Future<void> excluir(PermissaoUsuario permissaoUsuario) async {
    // TODO: implement excluir
    var conexao = await Conexao.getConexao();
     await conexao.transaction((transacao) async {
        var resultadoInsert = await transacao.prepared('''delete from Permissao_usuario where permissao_id =? and Usuario_id =?''', [
          permissaoUsuario.permissao?.id,
          permissaoUsuario.usuario?.id,
              
        ]); 
         
          
    });
  }

  @override
  Future<void> gravar(PermissaoUsuario permissaoUsuario) async {
    // TODO: implement gravar
    var conexao = await Conexao.getConexao();
     await conexao.transaction((transacao) async {
        var resultadoInsert = await transacao.prepared('''replace into Permissao_usuario (permissao_id,usuario_id, permitido) values (?, ?,?)''', [
          permissaoUsuario.permissao?.id,
          permissaoUsuario.usuario?.id,
          permissaoUsuario.permitido          
        ]); 
    });
 }

  @override
  Future<List<PermissaoUsuario>> listar({Map<String, dynamic>? filtros}) {
    // TODO: implement listar
    throw UnimplementedError();
  }

  @override
  Future<List<PermissaoUsuario>> pesquisar({Map<String, dynamic>? filtros}) {
    // TODO: implement pesquisar
    throw UnimplementedError();
  }


}