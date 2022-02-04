import 'package:galileo_sqljocky5/sqljocky.dart';

class Conexao {
  static MySqlConnection? _conexao;

  static Future<MySqlConnection> getConexao() async {
    String databaseName = 'organicos_local';
    var _settings = ConnectionSettings(
        useSSL: false,
        host: 'localhost',
        port: 3306,
        user: 'root',
        password: 'mysqlserverabc123*',
        db: databaseName);

    if (_conexao == null) {
      _conexao = await MySqlConnection.connect(_settings);
      await _conexao!.execute('use $databaseName');
    }

    var connectionTestResult;
    try {
      connectionTestResult = await _conexao!.execute('select 0').catchError(
          (error, stackTrace) async {
        return StreamedResults(0, 0, []);
      }, test: (Object error) => true);
    } catch (error) {
      print('A conexão com o banco de dados será reestabelecida!');
    }

    if (connectionTestResult == null ||
        connectionTestResult.fields?.length == 0) {
      _conexao!.close();
      _conexao = await MySqlConnection.connect(_settings);
      await _conexao!.execute('use $databaseName');
    }

    return _conexao!;
  }
}
