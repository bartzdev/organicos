import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/estado.dart';
import 'package:galileo_sqljocky5/sqljocky.dart';
import 'conexao.dart';
import 'dao.dart';

class CidadeDAO extends DAO<Cidade> {
  @override
  Future<void> gravar(Cidade cidade) async {}

  @override
  Future<void> excluir(Cidade cidade) async {}

  @override
  Future<Cidade> carregarDados(Cidade cidade, {Map<String, dynamic>? filtros}) async {
    return cidade;
  }

  @override
  Future<List<Cidade>> listar({Map<String, dynamic>? filtros}) async {
    Estado? estado = filtros != null && filtros.containsKey('estado') ? filtros['estado'] : null;
    List<Cidade> cidades = [];
    MySqlConnection conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared(
        'select id, nome from cidade where estado_id = ? order by lower(nome)', [estado != null ? estado.id : 0]);
    await resultadoConsulta.forEach((linhaConsulta) {
      Cidade cidade = Cidade();
      cidade.id = linhaConsulta[0];
      cidade.nome = linhaConsulta[1];
      cidades.add(cidade);
    });
    return cidades;
  }

  @override
  Future<List<Cidade>> pesquisar({Map<String, dynamic>? filtros}) async {
    List<Cidade> cidades = [];
    MySqlConnection conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select c.id, c.nome, e.id, e.nome, e.sigla from cidade c
           join estado e on e.id = estado_id
           where lower(c.nome) like ? 
           order by lower(c.nome)
           limit 100''', [filtros != null && filtros.containsKey('filtro') ? '%${filtros['filtro']}%' : '%%']);
    await resultadoConsulta.forEach((linhaConsulta) {
      Cidade cidade = Cidade();
      cidade.id = linhaConsulta[0];
      cidade.nome = linhaConsulta[1];
      cidade.estado = Estado()..id = linhaConsulta[2];
      cidade.estado?.nome = linhaConsulta[3];
      cidade.estado?.sigla = linhaConsulta[4];
      cidades.add(cidade);
    });
    return cidades;
  }
}
