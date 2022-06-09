import 'package:daily_workout/database/dao/exercicio_dao.dart';
import 'package:daily_workout/database/dao/treino_dao.dart';
import 'package:daily_workout/database/dao/treino_finalizado_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dao/exercicio_finalizado_dao.dart';

final String tableSqlExercicio = ExercicioDao().getTableExercicio();
final String tableSqlTreino = TreinoDao().getTableTreino();
final String tableSqlTreinoFinalizado = TreinoFinalizadoDao().getTableTreinoFinalizado();
final String tableSqlExercicioFinalizado = ExercicioFinalizadoDao().getTableExercicioFinalizado();

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), 'dailyWorkoutFinal.db');
  return await openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(tableSqlTreino);
      await db.execute(tableSqlExercicio);
      await db.execute(tableSqlTreinoFinalizado);
      await db.execute(tableSqlExercicioFinalizado);
    },
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete,
  );
}