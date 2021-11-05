import 'package:organicos/dao/conexao.dart';
import 'package:organicos/dao/dao.dart';
import 'package:organicos/modelo/permissoes.dart';

class PermissaoGrupoDAO extends DAO<PermissaoGrupo>{
  @override
  Future<PermissaoGrupo> carregarDados(PermissaoGrupo object, {Map<String, dynamic>? filtros}) {
    // TODO: implement carregarDados
    throw UnimplementedError();
  }

  @override
  Future<void> excluir(PermissaoGrupo permissaoGrupoUsuario) async {
    // TODO: implement excluir
    var conexao = await Conexao.getConexao();
     await conexao.transaction((transacao) async {
        var resultadoInsert = await transacao.prepared('''delete from permissao_grupousuario where permissao_id =? and grupousuario_id=?''', [
          permissaoGrupoUsuario.permissao?.id,
          permissaoGrupoUsuario.grupo?.id
              
        ]); 
         
          
    });
  }

  @override
  Future<void> gravar(PermissaoGrupo permissaoGrupoUsuario) async {
    // TODO: implement gravar
    var conexao = await Conexao.getConexao();
     await conexao.transaction((transacao) async {
        var resultadoInsert = await transacao.prepared('''REPLACE into permissao_grupousuario(permissao_id, grupousuario_id, permitido) values (?,?,?)''', [
          permissaoGrupoUsuario.permissao?.id,
          permissaoGrupoUsuario.grupo?.id,
          permissaoGrupoUsuario.permitido          
        ]); 
         
          
    });
    

  }

  @override
  Future<List<PermissaoGrupo>> listar({Map<String, dynamic>? filtros}) {
    // TODO: implement listar
    throw UnimplementedError();
  }

  @override
  Future<List<PermissaoGrupo>> pesquisar({Map<String, dynamic>? filtros}) {
    // TODO: implement pesquisar
    throw UnimplementedError();
  }


}