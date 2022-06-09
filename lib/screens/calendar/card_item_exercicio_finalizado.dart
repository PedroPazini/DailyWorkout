import 'package:daily_workout/models/Exercicio_finalizado.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class ItemExercicioFinalizado extends StatelessWidget {
  final ExercicioFinalizado _exercicio;
  List<Color> selecteds;

  ItemExercicioFinalizado(this._exercicio, this.selecteds);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SizedBox(
            height: (90) + (42 * _exercicio.qtdSeries.toDouble()),
            width: MediaQuery.of(context).size.width,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFEEEFEC),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 16),
                      child: Row(
                        children: [
                          Text(
                            _exercicio.nome,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Text(
                              "Séries: ${_exercicio.qtdSeries.toString()}",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Text(
                              "Repetições: ${_exercicio.repeticoes.toString()}",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                          ),
                          Text(
                            "Peso: ${_exercicio.qtdPeso.toString()} kg",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      itemCount: _exercicio.qtdSeries,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, indice) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 34,
                            child: Container(
                              decoration: BoxDecoration(color: selecteds[indice], borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                  child: Text(
                                (indice + 1).toString(),
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                              )),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
