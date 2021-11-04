import 'package:organicos/dao/certificadora_dao.dart';
import 'package:organicos/dao/cidade_dao.dart';
import 'package:organicos/dao/dao.dart';
import 'package:organicos/dao/estado_dao.dart';
import 'package:organicos/dao/permissao_grupousuario.dart';
import 'package:organicos/dao/permissao_usuario.dart';
<<<<<<< HEAD
=======
import 'package:organicos/dao/grupoprodutor_dao.dart';
import 'package:organicos/dao/grupousuario_dao.dart';
import 'package:organicos/dao/pontovenda_dao.dart';
import 'package:organicos/dao/tipoProdutos_dao.dart';
import 'package:organicos/dao/usuario_dao.dart';
import 'package:organicos/modelo/certificadora.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/estado.dart';
import 'package:organicos/modelo/grupo_usuario.dart';
import 'package:organicos/modelo/permissoes.dart';
import 'package:organicos/dao/grupoprodutor_dao.dart';
>>>>>>> 226def83985d6b384795535c819f170d58ed6dd9
import 'package:organicos/dao/pontovenda_dao.dart';
import 'package:organicos/dao/usuario_dao.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/estado.dart';
import 'package:organicos/modelo/grupo_produtor.dart';
import 'package:organicos/modelo/grupo_produtor.dart';
import 'package:organicos/modelo/grupo_usuario.dart';
<<<<<<< HEAD
import 'package:organicos/modelo/permissoes.dart';
import 'package:organicos/dao/grupoprodutor_dao.dart';
import 'package:organicos/dao/pontovenda_dao.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/estado.dart';
import 'package:organicos/modelo/grupo_produtor.dart';
import 'package:organicos/modelo/ponto_venda.dart';
=======
import 'package:organicos/modelo/ponto_venda.dart';
import 'package:organicos/modelo/tipo_produto.dart';
>>>>>>> 226def83985d6b384795535c819f170d58ed6dd9
import 'package:organicos/modelo/usuario.dart';

class DAOFactory<T> {
  DAO<T>? createDAO(T objectInstance) {
    if (objectInstance is PontoVenda) return PontoVendaDAO() as DAO<T>;
    if (objectInstance is Estado) return EstadoDAO() as DAO<T>;
    if (objectInstance is Cidade) return CidadeDAO() as DAO<T>;
<<<<<<< HEAD
    if (objectInstance is PermissaoUsuario) return PermissaoUsuarioDAO() as DAO<T>;
    if (objectInstance is PermissaoGrupo) return PermissaoGrupoDAO() as DAO<T>;
    if (objectInstance is GrupoProdutor) return GrupoProdutorDAO() as DAO<T>;
    if (objectInstance is Usuario) return UsuarioDAO() as DAO<T>;
=======
    if (objectInstance is PermissaoUsuario)
      return PermissaoUsuarioDAO() as DAO<T>;
    if (objectInstance is PermissaoGrupo) return PermissaoGrupoDAO() as DAO<T>;
    if (objectInstance is GrupoProdutor) return GrupoProdutorDAO() as DAO<T>;
    if (objectInstance is GrupoProdutor) return GrupoProdutorDAO() as DAO<T>;
    if (objectInstance is Usuario) return UsuarioDAO() as DAO<T>;
    if (objectInstance is GrupoUsuario) return GrupoUsuarioDAO() as DAO<T>;
    if (objectInstance is Certificadora) return CertificadoraDAO() as DAO<T>;
    if (objectInstance is TipoProduto) return TipoProdutoDAO() as DAO<T>;
>>>>>>> 226def83985d6b384795535c819f170d58ed6dd9
    return null;
  }
}
