abstract class DAO<T> {
  Future<void> gravar(T object);
  Future<void> excluir(T object);
  Future<T> carregarDados(T object, {Map<String, dynamic>? filtros});
  Future<List<T>> pesquisar({Map<String, dynamic>? filtros});
  Future<List<T>> listar({Map<String, dynamic>? filtros});
}
