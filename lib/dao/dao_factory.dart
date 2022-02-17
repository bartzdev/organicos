import 'package:organicos/dao/certificadora_dao.dart';
import 'package:organicos/dao/cidade_dao.dart';
import 'package:organicos/dao/dao.dart';
import 'package:organicos/dao/estado_dao.dart';
import 'package:organicos/dao/permissao_dao.dart';
import 'package:organicos/dao/permissao_grupousuario.dart';
import 'package:organicos/dao/permissao_usuario.dart';
import 'package:organicos/dao/grupoprodutor_dao.dart';
import 'package:organicos/dao/grupousuario_dao.dart';
import 'package:organicos/dao/pontovenda_dao.dart';
import 'package:organicos/dao/produto_dao.dart';
import 'package:organicos/dao/produtor_dao.dart';
import 'package:organicos/dao/tipoProdutos_dao.dart';
import 'package:organicos/dao/unidade_dao.dart';
import 'package:organicos/dao/usuario_dao.dart';
import 'package:organicos/modelo/certificadora.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/estado.dart';
import 'package:organicos/modelo/grupo_usuario.dart';
import 'package:organicos/modelo/permissoes.dart';
import 'package:organicos/modelo/grupo_produtor.dart';
import 'package:organicos/modelo/ponto_venda.dart';
import 'package:organicos/modelo/produto.dart';
import 'package:organicos/modelo/produtor.dart';
import 'package:organicos/modelo/tipo_produto.dart';
import 'package:organicos/modelo/unidade.dart';
import 'package:organicos/modelo/usuario.dart';

class DAOFactory<T> {
  DAO<T>? createDAO(T objectInstance) {
    if (objectInstance is PontoVenda) return PontoVendaDAO() as DAO<T>;
    if (objectInstance is Estado) return EstadoDAO() as DAO<T>;
    if (objectInstance is Cidade) return CidadeDAO() as DAO<T>;
    if (objectInstance is Permissao) return PermissaoDAO() as DAO<T>;
    if (objectInstance is PermissaoUsuario) return PermissaoUsuarioDAO() as DAO<T>;
    if (objectInstance is PermissaoGrupo) return PermissaoGrupoDAO() as DAO<T>;
    if (objectInstance is GrupoProdutor) return GrupoProdutorDAO() as DAO<T>;
    if (objectInstance is Usuario) return UsuarioDAO() as DAO<T>;
    if (objectInstance is GrupoProdutor) return GrupoProdutorDAO() as DAO<T>;
    if (objectInstance is GrupoUsuario) return GrupoUsuarioDAO() as DAO<T>;
    if (objectInstance is Certificadora) return CertificadoraDAO() as DAO<T>;
    if (objectInstance is Produto) return ProdutoDAO() as DAO<T>;
    if (objectInstance is TipoProduto) return TipoProdutoDAO() as DAO<T>;
    if (objectInstance is Unidade) return UnidadeDAO() as DAO<T>;
    if (objectInstance is Produtor) return ProdutorDAO() as DAO<T>;

    return null;
  }
}
