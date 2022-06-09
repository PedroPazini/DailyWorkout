import 'package:sqflite/sqflite.dart';
import '../../models/Treino_finalizado.dart';
import '../app_database.dart';

class TreinoFinalizadoDao {
  static const String tableSqlTreino = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_titulo TEXT, '
      '$_dataFinalizado TEXT)';

  static const String _tableName = 'treinos_finalizados';

  static const String _id = 'treino_id';
  static const String _titulo = 'titulo';
  static const String _dataFinalizado = 'data_finalizado';

  String getTableTreinoFinalizado () {
    return tableSqlTreino;
  }

  Future<int> save(TreinoFinalizado treino) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> treinoMap = {};
    treinoMap[_titulo] = treino.titulo;
    treinoMap[_dataFinalizado] = treino.dataFinalizado;
    return db.insert(_tableName, treinoMap);
  }

  Future<List<TreinoFinalizado>> findAllBydata(String data) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName, where: 'data_finalizado = ?', whereArgs: [data]);
    final List<TreinoFinalizado> treinos = [];
    for (Map<String, dynamic> row in result) {
      final TreinoFinalizado treino = TreinoFinalizado(
        row[_id],
        row[_titulo],
        row[_dataFinalizado],
      );
      treinos.add(treino);
    }
    return treinos;
  }
  Future<TreinoFinalizado> findLast() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    late TreinoFinalizado ultimoTreino;
    for (Map<String, dynamic> row in result) {
      final TreinoFinalizado treino = TreinoFinalizado(
        row[_id],
        row[_titulo],
        row[_dataFinalizado]
      );
      ultimoTreino = treino;
    }
    return ultimoTreino;
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
