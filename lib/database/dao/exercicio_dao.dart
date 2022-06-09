import 'package:daily_workout/models/Exercicio.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/Treino.dart';
import '../app_database.dart';

class ExercicioDao {
  static const String tableSqlExercicio = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_qtdSeries INTEGER, '
      '$_qtdPeso INTEGER, '
      '$_repeticoes INTEGER, '
      '$_id_treino INTEGER)';

  static const String _tableName = 'exercicios';

  static const String _id = 'exercicio_id';
  static const String _id_treino = 'treino_id';
  static const String _name = 'nome';
  static const String _qtdSeries = 'qtd_series';
  static const String _qtdPeso = 'qtd_peso';
  static const String _repeticoes = 'repeticoes';

  String getTableExercicio () {
    return tableSqlExercicio;
  }
  Future<int> save(Exercicio exercicio, Treino treino) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> exercicioMap = {};
    exercicioMap[_name] = exercicio.nome;
    exercicioMap[_qtdSeries] = exercicio.qtdSeries;
    exercicioMap[_qtdPeso] = exercicio.qtdPeso;
    exercicioMap[_repeticoes] = exercicio.repeticoes;
    exercicioMap[_id_treino] = treino.treino_id;

    return db.insert(_tableName, exercicioMap);
  }

  Future<List<Exercicio>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    final List<Exercicio> exercicios = [];
    for (Map<String, dynamic> row in result) {
      final Exercicio exercicio = Exercicio(
        row[_id],
        row[_name],
        row[_qtdSeries],
        row[_qtdPeso],
        row[_repeticoes],
      );
      exercicios.add(exercicio);
    }
    return exercicios;
  }

  Future<List<Exercicio>> findAllByTreinoId(int id) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName, where: 'treino_id = ?', whereArgs: [id]);
    final List<Exercicio> exercicios = [];
    for (Map<String, dynamic> row in result) {
      final Exercicio exercicio = Exercicio(
        row[_id],
        row[_name],
        row[_qtdSeries],
        row[_qtdPeso],
        row[_repeticoes],
      );
      exercicios.add(exercicio);
    }
    return exercicios;
  }

  Future<int> update(Exercicio exercicio, Treino treino) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> exercicioMap = {};
    exercicioMap[_name] = exercicio.nome;
    exercicioMap[_qtdSeries] = exercicio.qtdSeries;
    exercicioMap[_qtdPeso] = exercicio.qtdPeso;
    exercicioMap[_repeticoes] = exercicio.repeticoes;
    exercicioMap[_id_treino] = treino.treino_id;
    return db.update(
      _tableName,
      exercicioMap,
      where: 'exercicio_id = ?',
      whereArgs: [exercicio.exercicio_id],
    );
  }

  Future<int> delete(int id) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: 'exercicio_id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deletePorTreino(int id) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: 'treino_id = ?',
      whereArgs: [id],
    );
  }
}
