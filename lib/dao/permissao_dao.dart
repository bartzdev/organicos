import 'package:organicos/dao/conexao.dart';
import 'package:organicos/dao/dao.dart';
import 'package:organicos/modelo/permissoes.dart';

class PermissaoDAO<T> extends DAO<Permissao>{
  @override
  Future<Permissao> carregarDados(Permissao object, {Map<String, dynamic>? filtros}) {
    // TODO: implement carregarDados
    throw UnimplementedError();
  }

  @override
  Future<void> excluir(Permissao object) {
    // TODO: implement excluir
    throw UnimplementedError();
  }

  @override
  Future<void> gravar(Permissao object) {
    // TODO: implement gravar
    throw UnimplementedError();
  }

  @override
  Future<List<Permissao>> listar({Map<String, dynamic>? filtros}) async {
    List<Permissao> permissoesList = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    id, nome from permissao''', []);
    await resultadoConsulta.forEach((linhaConsulta) {
      var permissao = Permissao();
      permissao.id = linhaConsulta[0];
      permissao.nome = linhaConsulta[1];
      permissoesList.add(permissao);
    });
    return permissoesList;
  }

  @override
  Future<List<Permissao>> pesquisar({Map<String, dynamic>? filtros}) {
    // TODO: implement pesquisar
    throw UnimplementedError();
  }
 
}
