import 'package:organicos/dao/conexao.dart';
import 'package:organicos/dao/dao.dart';
import 'package:organicos/modelo/tipo_produto.dart';

class TipoProdutoDAO extends DAO<TipoProduto>{
   @override
  Future<void> gravar(TipoProduto tipo) async {
    // TODO: implement gravar
    var conexao = await Conexao.getConexao();
    await conexao.transaction((transaction) async{
      if(tipo.id == null || tipo.id == 0){
        var resultInsert = await transaction.prepared(
          '''insert into tipoproduto (nome, registro_ativo) values (?, ?)''',
          [
              tipo.nome,
              tipo.ativo
          ]);
      } else {
        await transaction.prepared('''update tipoproduto set nome = ?, registro_ativo = ? where id = ?''',
        [
          tipo.nome,
          tipo.ativo,
          tipo.id
        ]);
      }
    });
  }

  @override
  Future<void> excluir(TipoProduto tipo)async {
    // TODO: implement excluir
    tipo.ativo = false;
    await gravar(tipo);
  }

  @override
  Future<TipoProduto> carregarDados(TipoProduto tipo, {Map<String, dynamic>? filtros}) async {
    // TODO: implement carregarDados 
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared(
      '''select id, nome, registro_ativo from tipoproduto where id = ?''', [tipo.id]);
      await resultadoConsulta.forEach((linhaConsulta) {
        tipo.id = linhaConsulta[0];
        tipo.nome = linhaConsulta[1];
        tipo.ativo = linhaConsulta[2] == 1;
      });
      return tipo;
  }

  @override
  Future<List<TipoProduto>> pesquisar({Map<String, dynamic>? filtros}) async{
    // TODO: implement pesquisar
    String filtro = filtros != null && filtros.containsKey('filtro') ? filtros['filtro'] : '';
    List<TipoProduto> lista = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared(
      'select id, nome from tipoproduto where registro_ativo = 1 and lower(nome) like ? order by lower(nome)',
      ['%${filtro.toLowerCase()}%']);
      await resultadoConsulta.forEach((linhaConsulta) { 
        var tipo = TipoProduto();
        tipo.id = linhaConsulta[0];
        tipo.nome = linhaConsulta[1];
        lista.add(tipo);
      });
      return lista;
  }

  @override
  Future<List<TipoProduto>> listar({Map<String, dynamic>? filtros}) async{
    // TODO: implement listar
    List<TipoProduto> lista = [];
    var conexao = await Conexao.getConexao();
    var restuladoConsulta = await conexao.prepared(
      'select id, nome from tipoproduto where registro_ativo = 1 order by lower(nome)', []);
    await restuladoConsulta.forEach((linhaConsulta) { 
      var tipo = TipoProduto();
      tipo.id = linhaConsulta[0];
      tipo.nome = linhaConsulta[1];
      lista.add(tipo);
    });
    return lista;
  }
}