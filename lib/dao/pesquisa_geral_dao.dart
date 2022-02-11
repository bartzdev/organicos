import 'package:organicos/dao/conexao.dart';
import 'package:organicos/modelo/item_pesquisa_geral.dart';
import 'package:organicos/modelo/ponto_venda.dart';
import 'package:organicos/modelo/produto.dart';
import 'package:organicos/modelo/produtor.dart';

class PesquisaGeralDAO {
/*
select 
prod.id, prod.nome,
p.id, p.nome, p.telefone, p.latitude, p.longitude,
pv.id, pv.nome, pv.latitude, pv.longitude
from produto prod
join produtor_produto pp on pp.produto_id = prod.id 
join produtor p on pp.produtor_id = p.id
left join  pontovenda pv on pv.id = pp.pontovenda_id
where 
  prod.registro_ativo = 1 and p.registro_ativo = 1 and pp.pausado = 0 and 
  lower(concat(trim(concat(trim(coalesce(prod.nome, '')), trim(coalesce(p.nome, '')), trim(coalesce(pv.nome, '')))))) like '%%'
  order by lower(prod.nome), prod.id, lower(p.nome), p.id, lower(pv.nome), pv.id 
*/

  Future<List<ItemPesquisaGeral>> pesquisar(
      {Map<String, dynamic>? filtros}) async {
    List<ItemPesquisaGeral> itens = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
prod.id, prod.nome,
p.id, p.nome, p.telefone, p.latitude, p.longitude,
pv.id, pv.nome, pv.latitude, pv.longitude
from produto prod
join produtor_produto pp on pp.produto_id = prod.id 
join produtor p on pp.produtor_id = p.id
left join  pontovenda pv on pv.id = pp.pontovenda_id
where 
  prod.registro_ativo = 1 and p.registro_ativo = 1 and pp.pausado = 0 and 
  lower(concat(trim(concat(trim(coalesce(prod.nome, '')), trim(coalesce(p.nome, '')), trim(coalesce(pv.nome, '')))))) like ?
  order by lower(prod.nome), prod.id, lower(p.nome), p.id, lower(pv.nome), pv.id 
    ''', [
      '%' + filtros?['filtro'] + '%',
    ]);
    late ItemPesquisaGeral item;
    int ultimoIdProduto = 0;
    int ultimoIdProdutor = 0;
    await resultadoConsulta.forEach((linhaConsulta) {
      if (ultimoIdProduto != linhaConsulta[0] ||
          ultimoIdProdutor != linhaConsulta[2]) {
        ultimoIdProduto = linhaConsulta[0];
        ultimoIdProdutor = linhaConsulta[2];
        item = ItemPesquisaGeral(); 
        item.produto = Produto();
        item.produto!.id = linhaConsulta[0];
        item.produto!.nome = linhaConsulta[1];

        item.produtor = Produtor();
        item.produtor!.id = linhaConsulta[2];
        item.produtor!.nome = linhaConsulta[3];
        item.produtor!.telefone = linhaConsulta[4];
        item.produtor!.latitude = linhaConsulta[5].toString();
        item.produtor!.longitude = linhaConsulta[6].toString();
        item.pontosVenda = [];
        itens.add(item);
      }
      if (linhaConsulta[7] != null) {
        PontoVenda ponto = PontoVenda();
        ponto.id = linhaConsulta[7];
        ponto.nome = linhaConsulta[8];
        ponto.latitude = linhaConsulta[9].toString();
        ponto.longitude = linhaConsulta[10].toString();
        item.pontosVenda.add(ponto);
      }
    });

    return itens;
  }
}
