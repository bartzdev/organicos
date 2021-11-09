import 'package:organicos/modelo/produto.dart';
import 'package:galileo_sqljocky5/sqljocky.dart';
import 'package:organicos/modelo/tipo_produto.dart';
import 'package:organicos/modelo/unidade.dart';
import 'conexao.dart';
import 'dao.dart';

class ProdutoDAO extends DAO<Produto> {
  @override
  Future<void> gravar(Produto produto) async {
    var conexao = await Conexao.getConexao();

    await conexao.transaction((transacao) async {
      if (produto.id == null || produto.id == 0) {
        var resultadoInsert = await transacao.prepared(
            '''insert into produto (tipoproduto_id, nome, descricao, preco_unitario, unidade_id) values (?, ?, ?, ?, ?)''',
            [
              produto.tipo?.id,
              produto.nome,
              produto.descricao,
              produto.preco,
              produto.unidade?.id
            ]);
        produto.id = resultadoInsert.insertId;
      } else {
        await transacao.prepared(
            ''' update produto set nome = ?, preco_unitario = ?, unidade = ?, registro_ativo = ? where id = ?''',
            [
              produto.nome,
              produto.descricao,
              produto.preco,
              produto.unidade?.id,
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
        'select id, nome, descricao, preco_unitario, unidade_id from produto where registro_ativo = 1  order by lower(nome)',
        []);

    await resultadoConsulta.forEach((linhaConsulta) {
      Produto produto = new Produto();
      produto.id = linhaConsulta[0];
      produto.nome = linhaConsulta[1];
      produto.descricao = linhaConsulta[2];
      produto.preco = linhaConsulta[3];
      if (linhaConsulta[4] != null) {
        produto.unidade = new Unidade()..id = linhaConsulta[4];
      }

      produtos.add(produto);
    });
    return produtos;
  }

  @override
  Future<List<Produto>> pesquisar({Map<String, dynamic>? filtros}) {
    return listar(filtros: filtros);
  }
}
