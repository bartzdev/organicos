import 'package:organicos/dao/conexao.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/endereco.dart';
import 'package:organicos/modelo/estado.dart';
import 'package:organicos/modelo/ponto_venda.dart';

import 'dao.dart';

class PontoVendaDAO extends DAO<PontoVenda> {
  @override
  Future<void> gravar(PontoVenda pontoVenda) async {
    // var operacoesSQL = (transacao) async {
    //   var resultadoInsert = await transacao
    //       .prepared('insert into tabela (campo1, campo2, campo3) values (?, ?, ?)', [campo1, campo2, campo3]);
    //   var id = resultadoInsert.insertId;
    // };
    // await conexao.transaction(operacoesSQL);

    var conexao = await Conexao.getConexao();

    await conexao.transaction((transacao) async {
      if (pontoVenda.id == null || pontoVenda.id == 0) {
        var resultadoInsert = await transacao.prepared('''insert into pontovenda 
          (nome, endereco, numero, bairro, cidade_id, registro_ativo, latitude, longitude) 
          values 
          (?, ?, ?, ?, ?, ?, ?, ?)''', [
          pontoVenda.nome,
          pontoVenda.endereco?.logradouro,
          pontoVenda.endereco?.numero,
          pontoVenda.endereco?.bairro,
          pontoVenda.endereco?.cidade?.id,
          pontoVenda.ativo,
          pontoVenda.latitude,
          pontoVenda.longitude,
        ]);
        pontoVenda.id = resultadoInsert.insertId;
      } else {
        await transacao.prepared('''update pontovenda set
          nome = ?, endereco = ?, numero = ?, bairro = ?, cidade_id = ?, 
          registro_ativo = ?, latitude = ?, longitude = ? where id = ?''', [
          pontoVenda.nome,
          pontoVenda.endereco?.logradouro,
          pontoVenda.endereco?.numero,
          pontoVenda.endereco?.bairro,
          pontoVenda.endereco?.cidade?.id,
          pontoVenda.ativo,
          pontoVenda.id
        ]);
      }
    });
  }

  @override
  Future<void> excluir(PontoVenda pontoVenda) async {
    pontoVenda.ativo = false;
    await gravar(pontoVenda);
  }

  @override
  Future<PontoVenda> carregarDados(PontoVenda pontoVenda, {Map<String, dynamic>? filtros}) async {
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    p.id, p.nome, p.endereco, p.numero, p.bairro, p.registro_ativo, p.cidade_id, 
    c.nome, e.id, e.nome
    from pontovenda p
    join cidade c on c.id = p.cidade_id
    join estado e on e.id = c.estado_id
    where p.id = ?''', [pontoVenda.id]);
    await resultadoConsulta.forEach((linhaConsulta) {
      pontoVenda.id = linhaConsulta[0];
      pontoVenda.nome = linhaConsulta[1];
      pontoVenda.endereco = Endereco()..logradouro = linhaConsulta[2];
      pontoVenda.endereco?.numero = linhaConsulta[3];
      pontoVenda.endereco?.bairro = linhaConsulta[4];
      pontoVenda.ativo = linhaConsulta[5] == 1;
      pontoVenda.endereco?.cidade = Cidade()..id = linhaConsulta[6];
      pontoVenda.endereco?.cidade?.nome = linhaConsulta[7];
      pontoVenda.endereco?.cidade?.estado = Estado()..id = linhaConsulta[8];
      pontoVenda.endereco?.cidade?.estado?.nome = linhaConsulta[9];
    });
    return pontoVenda;
  }

  @override
  Future<List<PontoVenda>> listar({Map<String, dynamic>? filtros}) async {
    List<PontoVenda> pontos = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    p.id, p.nome from pontovenda p where p.registro_ativo = 1
    order by lower(p.nome)''', []);
    await resultadoConsulta.forEach((linhaConsulta) {
      var pontoVenda = PontoVenda();
      pontoVenda.id = linhaConsulta[0];
      pontoVenda.nome = linhaConsulta[1];
      pontos.add(pontoVenda);
    });
    return pontos;
  }

  @override
  Future<List<PontoVenda>> pesquisar({Map<String, dynamic>? filtros}) async {
    String filtro = filtros != null && filtros.containsKey('filtro') ? filtros['filtro'] : '';

    List<PontoVenda> pontos = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    p.id, p.nome from pontovenda p where p.registro_ativo = 1 and lower(p.nome) like ?
    order by lower(p.nome)''', ['%${filtro.toLowerCase()}%']);
    await resultadoConsulta.forEach((linhaConsulta) {
      var pontoVenda = PontoVenda();
      pontoVenda.id = linhaConsulta[0];
      pontoVenda.nome = linhaConsulta[1];
      pontos.add(pontoVenda);
    });
    return pontos;
  }
}
