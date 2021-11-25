import 'package:organicos/dao/dao.dart';
import 'package:organicos/dao/dao_factory.dart';
import 'package:async/async.dart';
import 'package:organicos/modelo/ponto_venda.dart';

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

  Future<T> carregarDados(T objeto) async {
    return await dao!.carregarDados(objeto);
  }

  Future<List<T>> atualizarPesquisa({Map<String, dynamic>? filtros}) async {
    futuraListaObjetosPesquisados = dao!.pesquisar(filtros: filtros);
    return Future.value(futuraListaObjetosPesquisados);
  }

  AsyncMemoizer<List<T>> _listMemoizer = AsyncMemoizer<List<T>>();
  Future<List<T>> listar({Map<String, dynamic>? filtros}) async {
    if (listaObjetosPesquisados == null ||
        listaObjetosPesquisados!.length == 0) {
      _listMemoizer = AsyncMemoizer<List<T>>();
    }
    futuraListaObjetosPesquisados = this._listMemoizer.runOnce(() async {
      listaObjetosPesquisados = await dao!.listar(filtros: filtros);
      return listaObjetosPesquisados!;
    });
    return Future.value(futuraListaObjetosPesquisados);
  }
}
