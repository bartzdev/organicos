import 'package:organicos/dao/conexao.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/endereco.dart';
import 'package:organicos/modelo/estado.dart';
import 'package:organicos/modelo/produtor.dart';

class RelatorioDAO {
  Future<List<Produtor>> pesquisarProdutoCidade(
      {Map<String, dynamic>? filtros}) async {
        List<Produtor> produtores = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    p.id, p.nome, p.telefone, p.cidade_id, 
    c.nome, e.id, e.nome, e.sigla
    from produtor p
    join cidade c on c.id = p.cidade_id
    join estado e on e.id = c.estado_id
    where c.id = ?''', [
      filtros?['Cidade']
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
      produtores.add(produtor);
    });
    return produtores;
  }
}