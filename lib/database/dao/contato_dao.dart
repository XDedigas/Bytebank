import 'package:sqflite/sqflite.dart';
import '../../models/contato.dart';
import '../app_database.dart';

class ContatoDao {
  static const String _nomeTabelaContatos = 'contatos';
  static const String _nomeCampoID = 'id';
  static const String _nomeCampoNome = 'nome';
  static const String _nomeCampoNumero = 'numero';
  static const String tableContatosSql =
      'CREATE TABLE $_nomeTabelaContatos($_nomeCampoID INTEGER PRIMARY KEY, $_nomeCampoNome TEXT, $_nomeCampoNumero INTEGER)';

  Future<int> save(Contato contato) async {
    final Database db = await createDatabase();
    final Map<String, dynamic> contatoMap = _toMap(contato);
    return db.insert(_nomeTabelaContatos, contatoMap);
  }

  Map<String, dynamic> _toMap(Contato contato) {
    final Map<String, dynamic> contatoMap = {};
    contatoMap[_nomeCampoNome] = contato.nome;
    contatoMap[_nomeCampoNumero] = contato.numero;
    return contatoMap;
  }

  Future<List<Contato>> findAll() async {
    final Database db = await createDatabase();
    final List<Map<String, dynamic>> results =
        await db.query(_nomeTabelaContatos);
    final List<Contato> contatos = _toList(results);
    return contatos;
  }

  List<Contato> _toList(List<Map<String, dynamic>> results) {
    final List<Contato> contatos = [];
    for (Map<String, dynamic> row in results) {
      final Contato contato =
          Contato(row[_nomeCampoNome], row[_nomeCampoNumero]);
      contatos.add(contato);
    }
    return contatos;
  }

  /* Future<int> update(Contato contato) async {
    final Database db = await createDatabase();
    final Map<String, dynamic> contatoMap = _toMap(contato);
    return db.update(
      _nomeTabelaContatos,
      contatoMap,
      where: '$_nomeCampoID = ?',
      whereArgs: [contato.id],
    );
  }

  Future<int> delete(int id) async {
    final Database db = await createDatabase();
    return db.delete(
      _nomeTabelaContatos,
      where: '$_nomeCampoID = ?',
      whereArgs: [id],
    );
  } */
}
