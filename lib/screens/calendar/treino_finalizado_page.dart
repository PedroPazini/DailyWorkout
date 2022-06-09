import 'package:daily_workout/components/app_bar_component.dart';
import 'package:daily_workout/models/Exercicio_finalizado.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import '../../models/Treino_finalizado.dart';
import 'card_item_exercicio_finalizado.dart';

// ignore: must_be_immutable
class TreinoFinalizadoPage extends StatelessWidget {
  TreinoFinalizado? treino;
  List<ExercicioFinalizado> _exercicios;

  TreinoFinalizadoPage(this.treino, this._exercicios);

  @override
  Widget build(BuildContext context) {
    String data = Jiffy(treino?.dataFinalizado ?? '', 'dd/MM/yyyy').format('yyyy-MM-dd') + ' 00:00:00.000';
    DateTime dataCorreta = DateTime.parse(data);

    return Scaffold(
      appBar: AppBarComponent(title: treino?.titulo ?? '', color: 0xFF22272B, fontSizes: 30, barHeight: 70),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 16.0, 0),
                    child: Text(
                      DateFormat("EEEE", "pt_BR").format(dataCorreta).toString().capitalize(),
                      style: const TextStyle(fontSize: 36),
                    ),
                  ),
                  Text(
                    treino?.dataFinalizado ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
              ListView.builder(
                itemCount: _exercicios.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, indice) {
                  List<Color> colors = List.filled(_exercicios[indice].qtdSeries, Color(0xFFC4C4C4));
                  for (int i = 0; i < _exercicios[indice].qtdSeriesFeitas; i++) {
                    colors[i] = Color(0xFFA4FC5E);
                  }
                  return ItemExercicioFinalizado(_exercicios[indice], colors);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
