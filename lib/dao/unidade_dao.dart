import 'package:organicos/modelo/produto.dart';
import 'package:galileo_sqljocky5/sqljocky.dart';
import 'package:organicos/modelo/tipo_produto.dart';
import 'package:organicos/modelo/unidade.dart';
import 'conexao.dart';
import 'dao.dart';

class UnidadeDAO extends DAO<Unidade> {
  @override
  Future<void> gravar(Unidade unidade) async {
    var conexao = await Conexao.getConexao();

    await conexao.transaction((transacao) async {
      if (unidade.id == null || unidade.id == 0) {
        var resultadoInsert = await transacao.prepared(
            '''insert into unidade (nome) values (?)''', [unidade.nome]);
        unidade.id = resultadoInsert.insertId!;
      } else {
        await transacao.prepared(
            ''' update unidade set nome = ?, registro_ativo = ? where id = ?''',
            [unidade.nome, unidade.ativo, unidade.id]);
      }
    });
  }

  @override
  Future<void> excluir(Unidade unidade) async {
    unidade.ativo = false;
    await gravar(unidade);
  }

  @override
  Future<Unidade> carregarDados(Unidade unidade,
      {Map<String, dynamic>? filtros}) async {
    return unidade;
  }

  @override
  Future<List<Unidade>> listar({Map<String, dynamic>? filtros}) async {
    List<Unidade> unidades = [];
    MySqlConnection conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared(
        'select id, nome from unidade where registro_ativo = 1 order by lower(nome)',
        []);

    await resultadoConsulta.forEach((linhaConsulta) {
      Unidade unidade = new Unidade();
      unidade.id = linhaConsulta[0];
      unidade.nome = linhaConsulta[1];
      unidades.add(unidade);
    });
    return unidades;
  }

  @override
  Future<List<Unidade>> pesquisar({Map<String, dynamic>? filtros}) async {
    String filtro = filtros != null && filtros.containsKey('filtro')
        ? filtros['filtro']
        : '';

    List<Unidade> unidades = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    u.id, u.nome from unidade u where u.registro_ativo = 1 and lower(u.nome) like ?
    order by lower(u.nome)''', ['%${filtro.toLowerCase()}%']);
    await resultadoConsulta.forEach((linhaConsulta) {
      var unidade = Unidade();
      unidade.id = linhaConsulta[0];
      unidade.nome = linhaConsulta[1];
      unidades.add(unidade);
    });
    return unidades;
  }
}
