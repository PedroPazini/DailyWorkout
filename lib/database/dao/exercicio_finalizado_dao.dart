import 'package:daily_workout/models/Exercicio_finalizado.dart';
import 'package:daily_workout/models/Treino_finalizado.dart';
import 'package:sqflite/sqflite.dart';

import '../app_database.dart';

class ExercicioFinalizadoDao {
  static const String tableSqlExercicio = 'CREATE TABLE $_tableName('
      '$_id INTEGER PRIMARY KEY, '
      '$_name TEXT, '
      '$_qtdSeries INTEGER, '
      '$_qtdPeso INTEGER, '
      '$_repeticoes INTEGER, '
      '$_qtdSeriesFinalizados INTEGER, '
      '$_id_treino INTEGER)';

  static const String _tableName = 'exercicios_finalizados';

  static const String _id = 'exercicio_id';
  static const String _id_treino = 'treino_finalizado_id';
  static const String _name = 'nome';
  static const String _qtdSeries = 'qtd_series';
  static const String _qtdPeso = 'qtd_peso';
  static const String _repeticoes = 'repeticoes';
  static const String _qtdSeriesFinalizados = 'qtd_series_finalizados';

  String getTableExercicioFinalizado () {
    return tableSqlExercicio;
  }
  Future<int> save(ExercicioFinalizado exercicio, TreinoFinalizado treino) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> exercicioMap = {};
    exercicioMap[_name] = exercicio.nome;
    exercicioMap[_qtdSeries] = exercicio.qtdSeries;
    exercicioMap[_qtdPeso] = exercicio.qtdPeso;
    exercicioMap[_repeticoes] = exercicio.repeticoes;
    exercicioMap[_qtdSeriesFinalizados] = exercicio.qtdSeriesFeitas;
    exercicioMap[_id_treino] = treino.treino_id;

    return db.insert(_tableName, exercicioMap);
  }

  Future<List<ExercicioFinalizado>> findAllByTreinoId(int id) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName, where: 'treino_finalizado_id = ?', whereArgs: [id]);
    final List<ExercicioFinalizado> exercicios = [];
    for (Map<String, dynamic> row in result) {
      final ExercicioFinalizado exercicio = ExercicioFinalizado(
        row[_id],
        row[_name],
        row[_qtdSeries],
        row[_qtdPeso],
        row[_repeticoes],
        row[_qtdSeriesFinalizados]
      );
      exercicios.add(exercicio);
    }
    return exercicios;
  }

  Future<int> deletePorTreino(int id) async {
    final Database db = await getDatabase();
    return db.delete(
      _tableName,
      where: 'treino_finalizado_id = ?',
      whereArgs: [id],
    );
  }
}
