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
            ''' update produto set nome = ?, descricao = ?, preco_unitario = ?, unidade_id = ?, registro_ativo = ? where id = ?''',
            [
              produto.nome,
              produto.descricao,
              produto.preco,
              produto.unidade?.id,
              produto.ativo,
              produto.id
            ]);
      }
    });
  }

  @override
  Future<void> excluir(Produto produto) async {
    produto.ativo = false;
    await gravar(produto);
  }

  @override
  Future<Produto> carregarDados(Produto produto,
      //realizar o join com a tabela unidade depois
      {Map<String, dynamic>? filtros}) async {
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    produto.id, tipoproduto_id, unidade_id, produto.nome, produto.descricao, produto.preco_unitario, produto.registro_ativo 
    from produto where  produto.id = ? ''', [produto.id]);
    await resultadoConsulta.forEach((linhaConsulta) {
      produto.id = linhaConsulta[0];
      produto.tipo = TipoProduto()..id = linhaConsulta[1];
      produto.unidade = Unidade()..id = linhaConsulta[2];
      produto.nome = linhaConsulta[3];
      produto.descricao = linhaConsulta[4];
      produto.preco = linhaConsulta[5];
      produto.ativo = linhaConsulta[6] == 1;
    });
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
  Future<List<Produto>> pesquisar({Map<String, dynamic>? filtros}) async {
    String filtro = filtros != null && filtros.containsKey('filtro')
        ? filtros['filtro']
        : '';

    List<Produto> pontos = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    p.id, p.nome from produto p where p.registro_ativo = 1 and lower(p.nome) like ?
    order by lower(p.nome)''', ['%${filtro.toLowerCase()}%']);
    await resultadoConsulta.forEach((linhaConsulta) {
      var produto = Produto();
      produto.id = linhaConsulta[0];
      produto.nome = linhaConsulta[1];
      pontos.add(produto);
    });
    return pontos;
  }
}
