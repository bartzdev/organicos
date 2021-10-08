import 'package:organicos/modelo/estado.dart';
import 'package:galileo_sqljocky5/sqljocky.dart';
import 'conexao.dart';
import 'dao.dart';

class EstadoDAO extends DAO<Estado> {
  @override
  Future<void> gravar(Estado estado) async {}

  @override
  Future<void> excluir(Estado estado) async {}

  @override
  Future<Estado> carregarDados(Estado estado, {Map<String, dynamic>? filtros}) async {
    return estado;
  }

  @override
  Future<List<Estado>> listar({Map<String, dynamic>? filtros}) async {
    List<Estado> estados = [];
    MySqlConnection conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('select id, nome, sigla from estado order by lower(nome)', []);
    await resultadoConsulta.forEach((linhaConsulta) {
      Estado estado = Estado();
      estado.id = linhaConsulta[0];
      estado.nome = linhaConsulta[1];
      estado.sigla = linhaConsulta[2];
      estados.add(estado);
    });
    return estados;
  }

  @override
  Future<List<Estado>> pesquisar({Map<String, dynamic>? filtros}) async {
    return listar(filtros: filtros);
  }
}
