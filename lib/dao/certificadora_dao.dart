import 'package:organicos/dao/conexao.dart';
import 'package:organicos/dao/dao.dart';
import 'package:organicos/modelo/certificadora.dart';

class CertificadoraDAO extends DAO<Certificadora>{
  @override
  Future<void> gravar(Certificadora certificadora) async {
    // TODO: implement gravar
    var conexao = await Conexao.getConexao();
    await conexao.transaction((transaction) async{
      if(certificadora.id == null || certificadora.id == 0){
        var resultInsert = await transaction.prepared(
          '''insert into certificadora (nome, registro_ativo) values (?, ?)''',
          [
              certificadora.nome,
              certificadora.ativo
          ]);
      } else {
        await transaction.prepared('''update certificadora set nome = ?, registro_ativo = ? where id = ?''',
        [
          certificadora.nome,
          certificadora.ativo,
          certificadora.id
        ]);
      }
    });
  }

  @override
  Future<void> excluir(Certificadora certificadora)async {
    // TODO: implement excluir
    certificadora.ativo = false;
    await gravar(certificadora);
  }

  @override
  Future<Certificadora> carregarDados(Certificadora certificadora, {Map<String, dynamic>? filtros}) async {
    // TODO: implement carregarDados 
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared(
      '''select id, nome, registro_ativo from certificadora where id = ?''', [certificadora.id]);
      await resultadoConsulta.forEach((linhaConsulta) {
        certificadora.id = linhaConsulta[0];
        certificadora.nome = linhaConsulta[1];
        certificadora.ativo = linhaConsulta[2] == 1;
      });
      return certificadora;
  }

  @override
  Future<List<Certificadora>> pesquisar({Map<String, dynamic>? filtros}) async{
    // TODO: implement pesquisar
    String filtro = filtros != null && filtros.containsKey('filtro') ? filtros['filtro'] : '';
    List<Certificadora> lista = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared(
      'select id, nome from certificadora where registro_ativo = 1 and lower(nome) like ? order by lower(nome)',
      ['%${filtro.toLowerCase()}%']);
      await resultadoConsulta.forEach((linhaConsulta) { 
        var certificadora = Certificadora();
        certificadora.id = linhaConsulta[0];
        certificadora.nome = linhaConsulta[1];
        lista.add(certificadora);
      });
      return lista;
  }

  @override
  Future<List<Certificadora>> listar({Map<String, dynamic>? filtros}) async{
    // TODO: implement listar
    List<Certificadora> lista = [];
    var conexao = await Conexao.getConexao();
    var restuladoConsulta = await conexao.prepared(
      'select id, nome from certificadora where registro_ativo = 1 order by lower(nome)', []);
    await restuladoConsulta.forEach((linhaConsulta) { 
      var certificadora = Certificadora();
      certificadora.id = linhaConsulta[0];
      certificadora.nome = linhaConsulta[1];
      lista.add(certificadora);
    });
    return lista;
  }
}