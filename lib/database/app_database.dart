import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dao/contato_dao.dart';
import 'dao/transferencia_dao.dart';

Future<Database> createDatabase() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(path, onCreate: (db, version) {
    db.execute(ContatoDao.tableContatosSql);
    db.execute(TransferenciaDao.tableTransferenciasSql);
  }, version: 1);
}
