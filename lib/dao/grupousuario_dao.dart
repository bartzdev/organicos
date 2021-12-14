import 'package:organicos/dao/conexao.dart';
import 'package:organicos/dao/dao.dart';
import 'package:organicos/modelo/grupo_usuario.dart';
import 'package:organicos/modelo/permissoes.dart';

class GrupoUsuarioDAO extends DAO<GrupoUsuario> {
  @override
  Future<void> gravar(GrupoUsuario grupoUsuario) async {
    var conexao = await Conexao.getConexao();

    await conexao.transaction((transacao) async {
      if (grupoUsuario.id == null || grupoUsuario.id == 0) {
        var resultadoInsert = await transacao.prepared(
            '''insert into grupousuario 
          (id, nome, registro_ativo) 
          values 
          (?, ?, ?)''',
            [grupoUsuario.id, grupoUsuario.nome, grupoUsuario.ativo]);
        grupoUsuario.id = resultadoInsert.insertId;
      } else {
        await transacao.prepared('''update grupousuario set
          nome = ?, registro_ativo = ? where id = ?''',
            [grupoUsuario.id, grupoUsuario.nome, grupoUsuario.ativo]);
      }
      for (PermissaoGrupo permissaoGrupo in grupoUsuario.permissoes) {
        var resultadoInsert = await transacao.prepared(
            '''REPLACE into permissao_grupousuario(permissao_id, grupousuario_id, permitido) values (?, ?, ?)''',
            [
              permissaoGrupo.permissao?.id,
              grupoUsuario.id,
              permissaoGrupo.permitido
            ]);
      }
      
    });
  }

  @override
  Future<GrupoUsuario> carregarDados(GrupoUsuario grupoUsuario,
      {Map<String, dynamic>? filtros}) async {
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    id, nome, registro_ativo
    from grupousuario 
    where grupousuario.id = ?''', [grupoUsuario.id]);
    await resultadoConsulta.forEach((linhaConsulta) {
      grupoUsuario.id = linhaConsulta[0];
      grupoUsuario.nome = linhaConsulta[1];
      grupoUsuario.ativo = linhaConsulta[2];
    });
    return grupoUsuario;
  }

  @override
  Future<void> excluir(GrupoUsuario grupoUsuario) async {
    grupoUsuario.ativo = false;
    await gravar(grupoUsuario);
  }

  @override
  Future<List<GrupoUsuario>> listar({Map<String, dynamic>? filtros}) async {
    List<GrupoUsuario> grupos = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    id, nome
    from grupousuario 
    where grupousuario.registro_ativo = 1
    ''', []);
    await resultadoConsulta.forEach((linhaConsulta) {
      var grupoUsuario = GrupoUsuario();
      grupoUsuario.id = linhaConsulta[0];
      grupoUsuario.nome = linhaConsulta[1];
      grupos.add(grupoUsuario);
    });
    return grupos;
  }

  @override
  Future<List<GrupoUsuario>> pesquisar({Map<String, dynamic>? filtros}) async {
    String filtro = filtros != null && filtros.containsKey('filtro')
        ? filtros['filtro']
        : '';
    List<GrupoUsuario> grupos = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    id, nome
    from grupousuario where grupousuario.registro_ativo = 1 and lower(nome) like ?
    order by lower(nome)''', ['%${filtro.toLowerCase()}%']);
    await resultadoConsulta.forEach((linhaConsulta) {
      var grupoUsuario = GrupoUsuario();
      grupoUsuario.id = linhaConsulta[0];
      grupoUsuario.nome = linhaConsulta[1];
      grupos.add(grupoUsuario);
    });
    return grupos;
  }
}
