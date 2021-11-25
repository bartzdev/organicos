import 'package:organicos/modelo/produto.dart';
import 'package:galileo_sqljocky5/sqljocky.dart';
import 'package:organicos/modelo/tipo_produto.dart';
import 'conexao.dart';
import 'dao.dart';

class Produto_unidade_DAO extends DAO<Produto> {
  @override
  Future<void> gravar(Produto produto) async {
    var conexao = await Conexao.getConexao();

    await conexao.transaction((transacao) async {
      if (produto.id == null || produto.id == 0) {
        var resultadoInsert = await transacao.prepared(
            '''insert into produto (tipoproduto_id, nome) values (?, ?)''',
            [produto.tipo?.id, produto.nome, produto.unidade]);
        produto.id = resultadoInsert.insertId;
      } else {
        await transacao.prepared(
            ''' update produto set nome = ?, registro_ativo = ? where id = ?''',
            [
              produto.nome,
              // produto.registro
              produto.descricao,
              produto.preco,
              produto.unidade,
              produto.id
            ]);
      }
    });
  }

  @override
  Future<void> excluir(Produto produto) async {}

  @override
  Future<Produto> carregarDados(Produto produto,
      {Map<String, dynamic>? filtros}) async {
    return produto;
  }

  @override
  Future<List<Produto>> listar({Map<String, dynamic>? filtros}) async {
    List<Produto> produtos = [];
    MySqlConnection conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared(
        'select id, nome, descricao, preco_unitario, unidade from produto order by lower(nome) where registro_ativo = 1',
        []);

    await resultadoConsulta.forEach((linhaConsulta) {
      Produto produto = new Produto();
      produto.id = linhaConsulta[0];
      produto.nome = linhaConsulta[1];
      produto.descricao = linhaConsulta[2];
      produto.preco = linhaConsulta[3];
      produto.unidade = linhaConsulta[4];
      produtos.add(produto);
    });
    return produtos;
  }

  @override
  Future<List<Produto>> pesquisar({Map<String, dynamic>? filtros}) {
    return listar(filtros: filtros);
  }
}
