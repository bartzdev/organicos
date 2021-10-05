import 'package:organicos/dao/dao.dart';
import 'package:organicos/dao/dao_factory.dart';

class ControleCadastros<T> {
  late DAO<T>? dao;
  T? objetoCadastroEmEdicao;
  Future<List<T>>? futuraListaObjetosPesquisados;
  List<T>? listaObjetosPesquisados;

  ControleCadastros(T objectInstance) {
    this.dao = DAOFactory<T>().createDAO(objectInstance);
  }

  Future<void> salvarObjetoCadastroEmEdicao() async {
    await dao!.gravar(objetoCadastroEmEdicao!);
  }

  Future<void> excluirObjetoCadastroEmEdicao() async {
    await dao!.excluir(objetoCadastroEmEdicao!);
  }

  Future<List<T>> atualizarPesquisa({Map<String, dynamic>? filtros}) async {
    futuraListaObjetosPesquisados = dao!.pesquisar(filtros: filtros);
    return Future.value(futuraListaObjetosPesquisados);
  }

  Future<List<T>> listar({Map<String, dynamic>? filtros}) async {
    futuraListaObjetosPesquisados = dao!.listar(filtros: filtros);
    return Future.value(futuraListaObjetosPesquisados);
  }
}
