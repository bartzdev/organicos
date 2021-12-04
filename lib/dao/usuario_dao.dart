import 'dart:convert';

import 'package:flutter/semantics.dart';
import 'package:organicos/controle/controle_sistema.dart';
import 'package:organicos/dao/conexao.dart';
import 'package:organicos/dao/dao.dart';
import 'package:organicos/modelo/grupo_usuario.dart';
import 'package:organicos/modelo/permissoes.dart';
import 'package:organicos/modelo/usuario.dart';
import 'package:crypto/crypto.dart';

class UsuarioDAO extends DAO<Usuario> {
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
          usuario.grupo?.id,
          usuario.nome,
          usuario.login,
          generateSignature(usuario.senha),
          usuario.ativo
        ]);
        usuario.id = resultadoInsert.insertId;
      } else {
        await transacao.prepared(
            '''update usuario set
          grupousuario_id = ?, nome = ?, login = ?, senha = ?, registro_ativo = ? where id = ?''',
            [
              usuario.id,
              usuario.grupo?.id,
              usuario.nome,
              usuario.login,
              usuario.senha,
              usuario.ativo
            ]);
      }
    });
  }

  @override
  Future<Usuario> carregarDados(Usuario usuario,
      {Map<String, dynamic>? filtros}) async {
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    usuario.id, usuario.grupousuario_id, usuario.nome, usuario.login, usuario.senha, usuario.registro_ativo 
    from usuario 
    join grupousuario on grupousuario.id = usuario.grupousuario_id 
    where usuario.id = ?''', [usuario.id]);
    await resultadoConsulta.forEach((linhaConsulta) {
      usuario.id = linhaConsulta[0];

      usuario.grupo?.id = linhaConsulta[1];
      usuario.nome = linhaConsulta[2];
      usuario.login = linhaConsulta[3];
      usuario.senha = linhaConsulta[4];
      usuario.ativo = linhaConsulta[5] == 1;
    });

    var resultadoPermissaoUsuario = await conexao.prepared('''select 
	PU.Permissao_id, PER.nome, PU.Permitido
    from 
		Permissao_Usuario as PU
        inner join Permissao as PER
        on PER.id = PU.Permissao_id
	where 
		PU.Usuario_id =  ?''', [usuario.id]);
    await resultadoPermissaoUsuario.forEach((linhaConsulta) {
      PermissaoUsuario permissaoUsuario = PermissaoUsuario();
      permissaoUsuario.permissao = new Permissao();
      permissaoUsuario.permissao?.id = linhaConsulta[0];
      permissaoUsuario.permissao?.nome = linhaConsulta[1];
      permissaoUsuario.permitido =
          linhaConsulta[2] == null ? null : linhaConsulta[2] == 1;
      usuario.permissoes.add(permissaoUsuario);
    });
    GrupoUsuario grupoUsuario = GrupoUsuario();
    var resultadoPermissaoGrupo = await conexao.prepared('''select 
	PU.Permissao_id, PER.nome, PU.Permitido, GU.ID, GU.nome
    from 
		Permissao_GrupoUsuario as PU
        inner join Permissao as PER
        on PER.id = PU.Permissao_id
        inner join GrupoUsuario as GU
        on GU.id = PU.grupousuario_id
	where 
		PU.grupousuario_id =  ?''', [usuario.id]);
    await resultadoPermissaoGrupo.forEach((linhaConsulta) {
      grupoUsuario.id = linhaConsulta[3];
      grupoUsuario.nome = linhaConsulta[4];
      PermissaoGrupo permissaoGrupo = PermissaoGrupo();
      permissaoGrupo.permissao = new Permissao();

      permissaoGrupo.permissao?.id = linhaConsulta[0];
      permissaoGrupo.permissao?.nome = linhaConsulta[1];
      permissaoGrupo.permitido =
          linhaConsulta[2] == null ? false : linhaConsulta[2] == 1;

      grupoUsuario.permissoes.add(permissaoGrupo);
    });
    usuario.grupo = grupoUsuario;

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
      usuario.grupo = linhaConsulta[1];
      usuario.nome = linhaConsulta[2];
      usuario.login = linhaConsulta[3];
      usuario.senha = linhaConsulta[4];
      usuarios.add(usuario);
    });
    return usuarios;
  }

  @override
  Future<List<Usuario>> pesquisar({Map<String, dynamic>? filtros}) async {
    String filtro = filtros != null && filtros.containsKey('filtro')
        ? filtros['filtro']
        : '';
    String? filtroLogin = filtros != null && filtros.containsKey('login')
        ? filtros['login']
        : null;
    String? filtroSenha = filtros != null && filtros.containsKey('senha')
        ? filtros['senha']
        : null;
    List<Usuario> usuarios = [];
    var conexao = await Conexao.getConexao();
    var resultadoConsulta = await conexao.prepared('''select 
    id, grupousuario_id, nome, login, senha 
    from usuario 
    where usuario.registro_ativo = 1 and
      case when ? is not null then usuario.login = ? and usuario.senha = ? else  
     lower(nome) like ? end
    order by lower(nome)''',
        [filtroLogin, filtroLogin, filtroSenha, '%${filtro.toLowerCase()}%']);
    await resultadoConsulta.forEach((linhaConsulta) {
      var usuario = Usuario();
      usuario.id = linhaConsulta[0];
      usuario.grupo?.id = linhaConsulta[1];
      usuario.nome = linhaConsulta[2];
      usuario.login = linhaConsulta[3];
      usuario.senha = linhaConsulta[4];
      usuarios.add(usuario);
    });
    return usuarios;
  }

  String? generateSignature(String? senha) {
    if (senha != null) {
      var encodedKey = utf8.encode(ControleSistema().chaveCrypto);
      var hmacSha512 = new Hmac(sha512, encodedKey);
      var bytesDataIn = utf8.encode(senha);
      var digest = sha512.convert(bytesDataIn);
      String singedValue = digest.toString();
      return singedValue;
    } else {
      return null;
    }
  }
}
