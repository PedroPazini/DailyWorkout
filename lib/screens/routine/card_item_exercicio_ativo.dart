import 'package:daily_workout/models/Exercicio.dart';
import 'package:flutter/material.dart';

//ignore: must_be_immutable
class ItemExercicioAtivo extends StatefulWidget {
  final Exercicio _exercicio;
  List<Color> selecteds;
  final int indice;
  int cont = 0;

  ItemExercicioAtivo(this._exercicio, this.selecteds, this.indice);

  @override
  State<ItemExercicioAtivo> createState() => _ItemExercicioAtivoState();
}

class _ItemExercicioAtivoState extends State<ItemExercicioAtivo> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SizedBox(
            height: (90) + (42 * widget._exercicio.qtdSeries.toDouble()),
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
                            widget._exercicio.nome,
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
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              "Séries: ${widget._exercicio.qtdSeries.toString()}",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Text(
                              "Repetições: ${widget._exercicio.repeticoes.toString()}",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                            ),
                          ),
                          Text(
                            "Peso: ${widget._exercicio.qtdPeso.toString()} kg",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                      itemCount: widget._exercicio.qtdSeries,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, indice) {
                        return GestureDetector(
                            onTap: () {
                              setState(() {
                                if (widget.selecteds[indice] == Color(0xFFC4C4C4)) {
                                  widget.selecteds[indice] = Color(0xFFA4FC5E);
                                } else {
                                  widget.selecteds[indice] = Color(0xFFC4C4C4);
                                }
                              });
                              widget.cont = widget.selecteds.map((element) => element == Color(0xFFA4FC5E) ? 1 : 0).reduce((value, element) => value + element);
                              debugPrint(widget.cont.toString());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 34,
                                child: Container(
                                  decoration: BoxDecoration(color: widget.selecteds[indice], borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                    (indice + 1).toString(),
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                                  )),
                                ),
                              ),
                            ));
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
