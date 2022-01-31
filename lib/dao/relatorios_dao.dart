import 'package:organicos/dao/conexao.dart';
import 'package:organicos/modelo/certificadora.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/endereco.dart';
import 'package:organicos/modelo/estado.dart';
import 'package:organicos/modelo/produtor.dart';
import 'package:organicos/modelo/tipo_produto.dart';

class RelatorioDAO {
  Future<List<Produtor>> pesquisarProdutoCidade(
      {Map<String, dynamic>? filtros}) async {
        List<Produtor> produtores = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    p.id, p.nome, p.telefone, p.cidade_id, 
    c.nome, e.id, e.nome, e.sigla, ce.id, ce.nome
    from produtor p
    join cidade c on c.id = p.cidade_id
    join estado e on e.id = c.estado_id
    left join certificadora ce on ce.id = p.certificadora_id
    left join produtor_produto pp on pp.produtor_id = p.id
    left join produto prod on prod.id = pp.produto_id

    where p.registro_ativo = 1 and

    case when ? > 0 then c.id = ?
    else true end and

    case when ? = "c" then
    p.certificadora_id > 0
    when ? = "s" then 
    p.certificadora_id is null
    else true end and
    
    case when ? > 0 then prod.tipoproduto_id = ?
    else true end
    ''', [
      filtros?['Cidade'] == null ? 0 : filtros?['Cidade'],
      filtros?['Cidade'] == null ? 0 : filtros?['Cidade'],
      filtros?['Certificado'],
      filtros?['Certificado'],
      filtros?['Tipo'] != null && filtros?['Tipo'] is TipoProduto ? filtros!['Tipo'].id : 0,
      filtros?['Tipo'] != null && filtros?['Tipo'] is TipoProduto ? filtros!['Tipo'].id : 0,
    ]);
    await resultadoConsulta.forEach((linhaConsulta) {
      Produtor produtor = Produtor();
      produtor.id = linhaConsulta[0];
      produtor.nome = linhaConsulta[1];
      produtor.endereco = Endereco();
      produtor.telefone = linhaConsulta[2];
      produtor.endereco?.cidade = Cidade()..id = linhaConsulta[3];
      produtor.endereco?.cidade?.nome = linhaConsulta[4];
      produtor.endereco?.cidade?.estado = Estado()..id = linhaConsulta[5];
      produtor.endereco?.cidade?.estado?.nome = linhaConsulta[6];
      produtor.endereco?.cidade?.estado?.sigla = linhaConsulta[7];
      if(linhaConsulta[8] != null){
      produtor.certificadora = Certificadora()..id = linhaConsulta[8];
      produtor.certificadora?.nome = linhaConsulta[9];
      }
      produtores.add(produtor);
    });
    return produtores;
  }
}