import 'package:sqflite/sqflite.dart';
import '../../models/transferencia.dart';
import '../app_database.dart';

class TransferenciaDao {
  static const String _nomeTabelaTransferencias = 'transferencias';
  static const String _nomeCampoID = 'id';
  static const String _nomeCampoValor = 'valor';
  static const String _nomeCampoContato = 'contato';
  static const String tableTransferenciasSql =
      'CREATE TABLE $_nomeTabelaTransferencias($_nomeCampoID INTEGER PRIMARY KEY, $_nomeCampoValor DECIMAL, $_nomeCampoContato INTEGER)';

  Future<int> save(Transferencia transf) async {
    final Database db = await createDatabase();
    final Map<String, dynamic> transfMap = _toMap(transf);
    return db.insert(_nomeTabelaTransferencias, transfMap);
  }

  Map<String, dynamic> _toMap(Transferencia transf) {
    final Map<String, dynamic> transfMap = {};
    transfMap[_nomeCampoValor] = transf.valor;
    transfMap[_nomeCampoContato] = transf.contato;
    return transfMap;
  }

  Future<List<Transferencia>> findAll() async {
    final Database db = await createDatabase();
    final List<Map<String, dynamic>> results =
        await db.query(_nomeTabelaTransferencias);
    final List<Transferencia> transferencias = _toList(results);
    return transferencias;
  }

  List<Transferencia> _toList(List<Map<String, dynamic>> results) {
    final List<Transferencia> transferencias = [];
    for (Map<String, dynamic> row in results) {
      final Transferencia transf = Transferencia(
          row[_nomeCampoID], row[_nomeCampoValor], row[_nomeCampoContato]);
      transferencias.add(transf);
    }
    return transferencias;
  }
}
