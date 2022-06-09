import 'package:sqflite/sqflite.dart';
import '../../models/Treino.dart';
import '../app_database.dart';

class TreinoDao {
  static const String tableSqlTreino = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_titulo TEXT)';

  static const String _tableName = 'treinos';

  static const String _id = 'treino_id';
  static const String _titulo = 'titulo';


  String getTableTreino () {
    return tableSqlTreino;
  }

  Future<int> save(Treino treino) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> treinoMap = {};
    treinoMap[_titulo] = treino.titulo;
    return db.insert(_tableName, treinoMap);
  }

  Future<List<Treino>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    final List<Treino> treinos = [];
    for (Map<String, dynamic> row in result) {
      final Treino treino = Treino(
        row[_id],
        row[_titulo],
      );
      treinos.add(treino);
    }
    return treinos;
  }

  Future<Treino> findLast() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    late Treino ultimoTreino;
    for (Map<String, dynamic> row in result) {
      final Treino treino = Treino(
        row[_id],
        row[_titulo],
      );
      ultimoTreino = treino;
    }
    return ultimoTreino;
  }

  Future<int> update(Treino treino) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> treinoMap = {};
    treinoMap[_titulo] = treino.titulo;
    return db.update(
      _tableName,
      treinoMap,
      where: 'treino_id = ?',
      whereArgs: [treino.treino_id],
    );
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: 'treino_id = ?',
      whereArgs: [id],
    );
  }
}
