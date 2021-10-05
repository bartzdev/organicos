import 'package:organicos/dao/dao.dart';
import 'package:organicos/dao/pontovenda_dao.dart';
import 'package:organicos/modelo/ponto_venda.dart';

class DAOFactory<T> {
  DAO<T>? createDAO(T objectInstance) {
    if (objectInstance is PontoVenda) return PontoVendaDAO() as DAO<T>;

    // if (objectInstance is Cidade) return CidadeDAO() as DAO<T>;
    return null;
  }
}
