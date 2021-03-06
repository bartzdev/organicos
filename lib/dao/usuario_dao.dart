import 'package:organicos/dao/conexao.dart';
import 'package:organicos/dao/dao.dart';
import 'package:organicos/modelo/grupo_usuario.dart';
import 'package:organicos/modelo/permissoes.dart';
import 'package:organicos/modelo/usuario.dart';
import 'package:organicos/modelo/utilitarios.dart';

class UsuarioDAO extends DAO<Usuario> {
  @override
  Future<void> gravar(Usuario usuario) async {
    var conexao = await Conexao.getConexao();

    await conexao.transaction((transacao) async {
      if (usuario.id == null || usuario.id == 0) {
        var resultadoInsert = await transacao.prepared('''insert into usuario 
          (id, grupousuario_id, nome,email, login, senha, registro_ativo) 
          values 
          (?, ?, ?, ?, ?, ?, ?)''', [usuario.id, usuario.grupo?.id, usuario.nome, usuario.email, usuario.login, encript(usuario.senha), usuario.ativo]);
        usuario.id = resultadoInsert.insertId;
      } else {
        await transacao.prepared('''update usuario set
          grupousuario_id = ?, nome = ?, login = ?, email = ?, senha = ?, registro_ativo = ? where id = ?''',
            [usuario.grupo?.id, usuario.nome, usuario.login, usuario.email, encript(usuario.senha), usuario.ativo, usuario.id]);
      }
      for (PermissaoUsuario permissaoUsuario in usuario.permissoes) {
        var resultadoInsert = await transacao.prepared(
            '''replace into permissao_usuario (permissao_id, usuario_id, permitido) values (?, ?, ?)''', [permissaoUsuario.permissao?.id, usuario.id, permissaoUsuario.permitido]);
      }
    });
  }

  @override
  Future<Usuario> carregarDados(Usuario usuario, {Map<String, dynamic>? filtros}) async {
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    usuario.id, usuario.grupousuario_id, usuario.nome, usuario.login, usuario.senha, usuario.registro_ativo, usuario.email
    from usuario 
    left join grupousuario on grupousuario.id = usuario.grupousuario_id 
    where usuario.id = ?''', [usuario.id]);
    await resultadoConsulta.forEach((linhaConsulta) {
      usuario.id = linhaConsulta[0];

      if (linhaConsulta[1] != null) {
        usuario.grupo = GrupoUsuario()..id = linhaConsulta[1];
      } else {
        usuario.grupo = null;
      }
      usuario.nome = linhaConsulta[2];
      usuario.login = linhaConsulta[3];
      usuario.senha = decript(linhaConsulta[4]);
      usuario.ativo = linhaConsulta[5] == 1;
      usuario.email = linhaConsulta[6];
    });

    var resultadoPermissaoUsuario = await conexao.prepared(
        '''select 
	pu.permissao_id, per.nome, pu.permitido
    from 
		permissao_usuario as pu
        inner join permissao as per
        on per.id = pu.permissao_id
	where 
		pu.usuario_id =  ?'''
            .toLowerCase(),
        [usuario.id]);
    await resultadoPermissaoUsuario.forEach((linhaConsulta) {
      PermissaoUsuario permissaoUsuario = PermissaoUsuario();
      permissaoUsuario.permissao = new Permissao();
      permissaoUsuario.permissao?.id = linhaConsulta[0];
      permissaoUsuario.permissao?.nome = linhaConsulta[1];
      permissaoUsuario.permitido = linhaConsulta[2] == null ? null : linhaConsulta[2] == 1;
      usuario.permissoes.add(permissaoUsuario);
    });

    if (usuario.grupo != null) {
      var resultadoPermissaoGrupo = await conexao.prepared('''select 
	pu.permissao_id, per.nome, pu.permitido, gu.id, gu.nome
    from 
		permissao_grupousuario as pu
        inner join permissao as per
        on per.id = pu.permissao_id
        inner join grupousuario as gu
        on gu.id = pu.grupousuario_id
	where 
		pu.grupousuario_id =  ?''', [usuario.grupo?.id]);
      await resultadoPermissaoGrupo.forEach((linhaConsulta) {
        usuario.grupo?.nome = linhaConsulta[4];
        PermissaoGrupo permissaoGrupo = PermissaoGrupo();
        permissaoGrupo.permissao = new Permissao();

        permissaoGrupo.permissao?.id = linhaConsulta[0];
        permissaoGrupo.permissao?.nome = linhaConsulta[1];
        permissaoGrupo.permitido = linhaConsulta[2] == null ? false : linhaConsulta[2] == 1;

        usuario.grupo?..permissoes.add(permissaoGrupo);
      });
    }

    return usuario;
  }

  @override
  Future<void> excluir(Usuario usuario) async {
    usuario.ativo = false;
    await gravar(usuario);
  }

  @override
  Future<List<Usuario>> listar({Map<String, dynamic>? filtros}) async {
    List<Usuario> usuarios = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    id, grupousuario_id, nome, login, senha
    from usuario 
    where usuario.registro_ativo = 1
    order by lower(nome)''', []);
    await resultadoConsulta.forEach((linhaConsulta) {
      var usuario = Usuario();
      usuario.id = linhaConsulta[0];
      if (linhaConsulta[1] != null) {
        usuario.grupo = GrupoUsuario()..id = linhaConsulta[1];
      } else {
        usuario.grupo = null;
      }
      usuario.nome = linhaConsulta[2];
      usuario.login = linhaConsulta[3];
      usuario.senha = decript(linhaConsulta[4]);
      usuarios.add(usuario);
    });
    return usuarios;
  }

  @override
  Future<List<Usuario>> pesquisar({Map<String, dynamic>? filtros}) async {
    String filtro = filtros != null && filtros.containsKey('filtro') ? filtros['filtro'] : '';
    String? filtroLogin = filtros != null && filtros.containsKey('login') ? filtros['login'] : null;
    String? filtroSenha = filtros != null && filtros.containsKey('senha') ? encript(filtros['senha']) : null;
    List<Usuario> usuarios = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    id, grupousuario_id, nome, login, senha 
    from usuario 
    where usuario.registro_ativo = 1 and
      case when ? is not null then usuario.login = ? and usuario.senha = ? else  
     lower(nome) like ? end
    order by lower(nome)''', [filtroLogin, filtroLogin, filtroSenha, '%${filtro.toLowerCase()}%']);
    await resultadoConsulta.forEach((linhaConsulta) {
      var usuario = Usuario();
      usuario.id = linhaConsulta[0];
      if (linhaConsulta[1] != null) {
        usuario.grupo = GrupoUsuario()..id = linhaConsulta[1];
      } else {
        usuario.grupo = null;
      }
      usuario.nome = linhaConsulta[2];
      usuario.login = linhaConsulta[3];
      usuario.senha = decript(linhaConsulta[4]);
      usuarios.add(usuario);
    });
    return usuarios;
  }
}
