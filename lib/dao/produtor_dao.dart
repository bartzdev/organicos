import 'package:organicos/dao/conexao.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/endereco.dart';
import 'package:organicos/modelo/estado.dart';
import 'package:organicos/modelo/ponto_venda.dart';
import 'package:organicos/modelo/produtor.dart';

import 'dao.dart';

class ProdutorDAO extends DAO<Produtor> {
  @override
  Future<void> gravar(Produtor produtor) async {
    // var operacoesSQL = (transacao) async {
    //   var resultadoInsert = await transacao
    //       .prepared('insert into tabela (campo1, campo2, campo3) values (?, ?, ?)', [campo1, campo2, campo3]);
    //   var id = resultadoInsert.insertId;
    // };
    // await conexao.transaction(operacoesSQL);

    var conexao = await Conexao.getConexao();

    await conexao.transaction((transacao) async {
      if (produtor.id == null || produtor.id == 0) {
        var resultadoInsert = await transacao.prepared('''insert into produtor (
          certificadora_id, grupoprodutores_id, nome, nome_propriedade, cpf_cnpj, 
          endereco, numero, bairro, cidade_id, telefone, latitude, longitude,
          certificacao_organicos, venda_consumidorfinal, registro_ativo)
          values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)''', [
          produtor.certificadora!.id,
          produtor.grupo!.id,
          produtor.nome,
          produtor.nomePropriedade,
          produtor.cpfCnpj,
          produtor.endereco!.logradouro,
          produtor.endereco!.numero,
          produtor.endereco!.bairro,
          produtor.endereco!.cidade!.id,
          produtor.telefone,
          produtor.latitude,
          produtor.longitude,
          produtor.certificacaoOrganicos,
          produtor.vendaConsumidorFinal,
          produtor.ativo
        ]);
        produtor.id = resultadoInsert.insertId;
      } else {
        await transacao.prepared(
            '''update produtor set certificadora_id = ?, grupoprodutores_id = ?,
        nome = ?, nome_propriedade = ?, cpf_cnpj = ?, endereco = ?, numero = ?, bairro = ?,
        cidade_id = ?, telefone = ?, latitude = ?, longitude = ?, certificacao_organicos = ?,
        venda_consumidorfinal = ?, registro_ativo = ? where id = ?''',
            [
              produtor.certificadora!.id,
              produtor.grupo!.id,
              produtor.nome,
              produtor.nomePropriedade,
              produtor.cpfCnpj,
              produtor.endereco!.logradouro,
              produtor.endereco!.numero,
              produtor.endereco!.bairro,
              produtor.endereco!.cidade!.id,
              produtor.telefone,
              produtor.latitude,
              produtor.longitude,
              produtor.certificacaoOrganicos,
              produtor.vendaConsumidorFinal,
              produtor.ativo,
              produtor.id
            ]);
      }
    });
  }

  @override
  Future<void> excluir(Produtor produtor) async {
    produtor.ativo = false;
    await gravar(produtor);
  }

  @override
  Future<Produtor> carregarDados(Produtor produtor,
      {Map<String, dynamic>? filtros}) async {
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    p.id, p.nome, p.endereco, p.numero, p.bairro, p.registro_ativo, p.cidade_id, 
    c.nome, e.id, e.nome
    from pontovenda p
    join cidade c on c.id = p.cidade_id
    join estado e on e.id = c.estado_id
    where p.id = ?''', [produtor.id]);
    await resultadoConsulta.forEach((linhaConsulta) {
      produtor.id = linhaConsulta[0];
      produtor.nome = linhaConsulta[1];
      produtor.endereco = Endereco()..logradouro = linhaConsulta[2];
      produtor.endereco?.numero = linhaConsulta[3];
      produtor.endereco?.bairro = linhaConsulta[4];
      produtor.ativo = linhaConsulta[5] == 1;
      produtor.endereco?.cidade = Cidade()..id = linhaConsulta[6];
      produtor.endereco?.cidade?.nome = linhaConsulta[7];
      produtor.endereco?.cidade?.estado = Estado()..id = linhaConsulta[8];
      produtor.endereco?.cidade?.estado?.nome = linhaConsulta[9];
    });
    return produtor;
  }

  @override
  Future<List<Produtor>> listar({Map<String, dynamic>? filtros}) async {
    List<Produtor> pontos = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    p.id, p.nome from pontovenda p where p.registro_ativo = 1
    order by lower(p.nome)''', []);
    await resultadoConsulta.forEach((linhaConsulta) {
      var produtor = Produtor();
      produtor.id = linhaConsulta[0];
      produtor.nome = linhaConsulta[1];
      pontos.add(produtor);
    });
    return pontos;
  }

  @override
  Future<List<Produtor>> pesquisar({Map<String, dynamic>? filtros}) async {
    String filtro = filtros != null && filtros.containsKey('filtro')
        ? filtros['filtro']
        : '';

    List<Produtor> pontos = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    p.id, p.nome from produtor p where p.registro_ativo = 1 and lower(p.nome) like ?
    order by lower(p.nome)''', ['%${filtro.toLowerCase()}%']);
    await resultadoConsulta.forEach((linhaConsulta) {
      var produtor = Produtor();
      produtor.id = linhaConsulta[0];
      produtor.nome = linhaConsulta[1];
      pontos.add(produtor);
    });
    return pontos;
  }
}
