import 'package:organicos/dao/conexao.dart';
import 'package:organicos/dao/dao.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/endereco.dart';
import 'package:organicos/modelo/estado.dart';
import 'package:organicos/modelo/grupo_produtor.dart';

class GrupoProdutorDao extends DAO<GrupoProdutor> {
  @override
  Future<void> gravar(GrupoProdutor grupo) async {
    // TODO: implement gravar
    var conexao = await Conexao.getConexao();
    await conexao.transaction((transaction) async {
      if (grupo.id == null || grupo.id == 0) {
        var resultInsert = await transaction.prepared(
            '''insert into grupoprodutores (nome, endereco, numero, bairro, cidade_id, cnpj, inscricao_estadual, distribuidor_produtos, registro_ativo)
        values (?,?,?,?,?,?,?,?,?)''',
            [
              grupo.nome,
              grupo.endereco?.logradouro,
              grupo.endereco?.numero,
              grupo.endereco?.bairro,
              grupo.endereco?.cidade?.id,
              grupo.cnpj,
              grupo.inscricaoEstadual,
              grupo.distribuidor,
              grupo.ativo
            ]);
        grupo.id = resultInsert.insertId;
      } else {
        await transaction.prepared('''update grupoprodutores set
      nome = ?, endereco = ?, numero = ?, bairro = ?, cidade_id = ?, cnpj = ?, inscricao_estadual = ?, distribuidor_produtos = ?, registro_ativo = ?
      where id = ?
      ''', [
          grupo.nome,
          grupo.endereco?.logradouro,
          grupo.endereco?.numero,
          grupo.endereco?.bairro,
          grupo.endereco?.cidade?.id,
          grupo.cnpj,
          grupo.inscricaoEstadual,
          grupo.distribuidor,
          grupo.ativo,
          grupo.id
        ]);
      }
    });
  }

  @override
  Future<void> excluir(GrupoProdutor grupo) async {
    // TODO: implement excluir
    grupo.ativo = false;
    await gravar(grupo);
  }
  @override
  Future<GrupoProdutor> carregarDados(GrupoProdutor grupo, {Map<String, dynamic>? filtros}) async {
    // TODO: implement carregarDados
    var conexao = await Conexao.getConexao();
     var resultadoConsulta = await conexao.prepared('''select 
    p.id, p.nome, p.cnpj, p.inscricao_estadual, p.distribuidor_produtos, p.endereco, p.numero, p.bairro, p.registro_ativo, p.cidade_id, 
    c.nome, e.id, e.nome
    from grupoprodutores p
    join cidade c on c.id = p.cidade_id
    join estado e on e.id = c.estado_id
    where p.id = ?''', [grupo.id]);
    await resultadoConsulta.forEach((linhaConsulta) {
      grupo.id = linhaConsulta[0];
      grupo.nome = linhaConsulta[1];
      grupo.cnpj = linhaConsulta[2];
      grupo.inscricaoEstadual = linhaConsulta[3];
      grupo.distribuidor= linhaConsulta[4];
      grupo.endereco = Endereco()..logradouro = linhaConsulta[5];
      grupo.endereco?.numero = linhaConsulta[6];
      grupo.endereco?.bairro = linhaConsulta[7];
      grupo.ativo = linhaConsulta[8] == 1;
      grupo.endereco?.cidade = Cidade()..id = linhaConsulta[9];
      grupo.endereco?.cidade?.nome = linhaConsulta[10];
      grupo.endereco?.cidade?.estado = Estado()..id = linhaConsulta[11];
      grupo.endereco?.cidade?.estado?.nome = linhaConsulta[12];
    });
    return grupo;
  }

  @override
  Future<List<GrupoProdutor>> listar({Map<String, dynamic>? filtros}) async{
    // TODO: implement listar
    List<GrupoProdutor> grupos = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    p.id, p.nome from pontovenda p where p.registro_ativo = 1
    order by lower(p.nome)''', []);
    await resultadoConsulta.forEach((linhaConsulta) {
      var grupo = GrupoProdutor();
      grupo.id = linhaConsulta[0];
      grupo.nome = linhaConsulta[1];
      grupos.add(grupo);
    });
    return grupos;
  }

  @override
  Future<List<GrupoProdutor>> pesquisar({Map<String, dynamic>? filtros}) async {
    // TODO: implement pesquisar
    String filtro = filtros != null && filtros.containsKey('filtro') ? filtros['filtro'] : '';
    List<GrupoProdutor> grupos = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    p.id, p.nome from pontovenda p where p.registro_ativo = 1 and lower(p.nome) like ?
    order by lower(p.nome)''', ['%${filtro.toLowerCase()}%']);
    await resultadoConsulta.forEach((linhaConsulta) {
      var grupo = GrupoProdutor();
      grupo.id = linhaConsulta[0];
      grupo.nome = linhaConsulta[1];
      grupos.add(grupo);
    });
    return grupos;
  }
  }

