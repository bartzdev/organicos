import 'package:organicos/dao/cidade_dao.dart';
import 'package:organicos/dao/dao.dart';
import 'package:organicos/dao/estado_dao.dart';
import 'package:organicos/dao/grupoprodutor_dao.dart';
import 'package:organicos/dao/grupousuario_dao.dart';
import 'package:organicos/dao/pontovenda_dao.dart';
import 'package:organicos/dao/usuario_dao.dart';
import 'package:organicos/modelo/cidade.dart';
import 'package:organicos/modelo/estado.dart';
import 'package:organicos/modelo/grupo_produtor.dart';
import 'package:organicos/modelo/grupo_usuario.dart';
import 'package:organicos/modelo/ponto_venda.dart';
import 'package:organicos/modelo/usuario.dart';

class DAOFactory<T> {
  DAO<T>? createDAO(T objectInstance) {
    if (objectInstance is PontoVenda) return PontoVendaDAO() as DAO<T>;
    if (objectInstance is Estado) return EstadoDAO() as DAO<T>;
    if (objectInstance is Cidade) return CidadeDAO() as DAO<T>;
    if (objectInstance is GrupoProdutor) return GrupoProdutorDAO() as DAO<T>;
    if (objectInstance is Usuario) return UsuarioDAO() as DAO<T>;
    if (objectInstance is GrupoUsuario) return GrupoUsuarioDAO() as DAO<T>;
    return null;
  }
}
