import 'package:organicos/dao/conexao.dart';
import 'package:organicos/dao/dao.dart';
import 'package:organicos/modelo/usuario.dart';

class Login_Permissao extends DAO<Usuario>{
  @override
  Future<Usuario> carregarDados(Usuario object, {Map<String, dynamic>? filtros}) {
    // TODO: implement carregarDados
    throw UnimplementedError();
  }

  @override
  Future<void> excluir(Usuario object) {
    // TODO: implement excluir
    throw UnimplementedError();
  }

  @override
  Future<void> gravar(Usuario object) {
    // TODO: implement gravar
    throw UnimplementedError();
  }

  @override
  Future<List<Usuario>> listar({Map<String, dynamic>? filtros}) {
    // TODO: implement listar
    throw UnimplementedError();
  }

  @override
  Future<List<Usuario>> pesquisar({Map<String, dynamic>? filtros}) async {
    String filtro = filtros != null && filtros.containsKey('filtro') ? filtros['filtro'] : '';

    List<Usuario> pontos = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    p.id, p.nome from pontovenda p where p.registro_ativo = 1 and lower(p.nome) like ?
    order by lower(p.nome)''', ['%${filtro.toLowerCase()}%']);
    await resultadoConsulta.forEach((linhaConsulta) {
      var linhaUser = Usuario();
      linhaUser.id = linhaConsulta[0];
      linhaUser.permissoes = linhaConsulta[1];
      linhaUser.nome = linhaConsulta[2];
      linhaUser.login = linhaConsulta[3];
      linhaUser.senha = linhaConsulta[4];
      linhaUser.ativo = linhaConsulta[5];
      pontos.add(linhaUser);
    });
    return pontos;
  }

}