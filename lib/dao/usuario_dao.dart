import 'package:organicos/dao/conexao.dart';
import 'package:organicos/dao/dao.dart';
import 'package:organicos/modelo/grupo_usuario.dart';
import 'package:organicos/modelo/permissoes.dart';
import 'package:organicos/modelo/usuario.dart';

class UsuarioDAO extends DAO<Usuario>{
  @override
  Future<void> gravar(Usuario usuario) async {
    var conexao = await Conexao.getConexao();

    await conexao.transaction((transacao) async {
      if (usuario.id == null || usuario.id == 0) {
        var resultadoInsert = await transacao.prepared('''insert into usuario 
          (id, grupousuario_id, nome, login, senha, registro_ativo) 
          values 
          (?, ?, ?, ?, ?, ?)''', [
          usuario.id,
          usuario.grupo,
          usuario.nome,
          usuario.login,
          usuario.senha,
          usuario.ativo
        ]);
        usuario.id = resultadoInsert.insertId;
      } else {
        await transacao.prepared('''update usuario set
          grupousuario_id = ?, nome = ?, login = ?, senha = ?, registro_ativo = ? where id = ?''', [
          usuario.id,
          usuario.grupo,
          usuario.nome,
          usuario.login,
          usuario.senha,
          usuario.ativo
        ]);
      }
    });

  }


  @override
  Future<Usuario> carregarDados(Usuario usuario, {Map<String, dynamic>? filtros})async {
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    id, grupousuario_id, nome, login, senha, registro_ativo 
    from usuario 
    join grupousuario on grupousuario.id = usuario.grupousuario_id 
    where usuario.id = ?''', [usuario.id]);
    await resultadoConsulta.forEach((linhaConsulta) {
      usuario.id = linhaConsulta[0];
      usuario.grupo = linhaConsulta[1];
      usuario.nome = linhaConsulta[2];
      usuario.login = linhaConsulta[3];
      usuario.senha = linhaConsulta[4];
      usuario.ativo = linhaConsulta[5];
    });
    var resultadoPermissaoGrupo = await conexao.prepared('''select grupousuario.id, grupousuario.nome, 
permissao_grupousuario.permitido, permissao_grupousuario.permissao_id from usuario 
	inner join grupousuario on grupousuario.id = usuario.grupousuario_id
	inner join permissao_grupousuario 	
		on grupousuario.id = permissao_grupousuario.grupousuario_id  
	
	where usuario.id = ?''', [usuario.id]);
    await resultadoConsulta.forEach((linhaConsulta) {
      usuario.grupo = GrupoUsuario()..id = linhaConsulta[0];
      usuario.grupo?.nome = linhaConsulta[1];
    //  usuario.permissoes = Permissao()..id linhaConsulta[2];
     // usuario.login = linhaConsulta[3];
      //todo voltar aqui!!
    });
    return usuario;

  }

  @override
  Future<void> excluir(Usuario usuario) async{
    usuario.ativo = false;
    await gravar(usuario);
  }

  @override
  Future<List<Usuario>> listar({Map<String, dynamic>? filtros}) async{
    List<Usuario> usuarios = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    id, grupousuario_id, nome, login, senha
    from usuario 
    where usuario.registro_ativo = 1
    order by lower(p.nome)''', []);
    await resultadoConsulta.forEach((linhaConsulta) {
      var usuario = Usuario();
      usuario.id = linhaConsulta[0];
      usuario.grupo = linhaConsulta[1];
      usuario.nome = linhaConsulta[2];
      usuario.login = linhaConsulta[3];
      usuario.senha = linhaConsulta[4];
      usuarios.add(usuario);
    });
    return usuarios;
  }

  @override
  Future<List<Usuario>> pesquisar({Map<String, dynamic>? filtros}) async{
    String filtro = filtros != null && filtros.containsKey('filtro') ? filtros['filtro'] : '';
    List<Usuario> usuarios = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    id, grupousuario_id, nome, login, senha 
    from usuario where usuario.registro_ativo = 1 and lower(p.nome) like ?
    order by lower(p.nome)''', ['%${filtro.toLowerCase()}%']);
    await resultadoConsulta.forEach((linhaConsulta) {
      var usuario = Usuario();
      usuario.id = linhaConsulta[0];
      usuario.grupo = linhaConsulta[1];
      usuario.nome = linhaConsulta[2];
      usuario.login = linhaConsulta[3];
      usuario.senha = linhaConsulta[4];
      usuarios.add(usuario);
    });
    return usuarios;
  }
}