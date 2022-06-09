import 'package:daily_workout/components/app_bar_component.dart';
import 'package:daily_workout/database/dao/treino_finalizado_dao.dart';
import 'package:daily_workout/models/Exercicio_finalizado.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../components/datas.dart';
import '../../database/dao/exercicio_dao.dart';
import '../../database/dao/exercicio_finalizado_dao.dart';
import '../../models/Exercicio.dart';
import '../../models/Treino.dart';
import '../../models/Treino_finalizado.dart';

// ignore: must_be_immutable
class TreinoAtivo extends StatefulWidget {
  Treino? treino;
  late List<Exercicio> _exercicios = <Exercicio>[];
  late List<int> _qtdSeries = <int>[];
  List<List<Color>> _colors = [];
  int cont = 0;

  TreinoAtivo(this.treino);

  static const String _botaoFinalizar = "Finalizar";

  @override
  State<TreinoAtivo> createState() => _TreinoAtivoState();
}

class _TreinoAtivoState extends State<TreinoAtivo> {
  final ExercicioDao _daoExercicio = ExercicioDao();
  final ExercicioFinalizadoDao _daoExercicioFinalizado = ExercicioFinalizadoDao();
  final TreinoFinalizadoDao _daoTreinoFinalizado = TreinoFinalizadoDao();

  @override
  void initState() {
    super.initState();
    _daoExercicio.findAllByTreinoId(widget.treino?.treino_id ?? 0).then((value) => {
          setState(() {
            widget._exercicios = value;
            widget._qtdSeries = List.filled(widget._exercicios.length, 0);
            widget._colors = List.filled(widget._exercicios.length, []);
          })
        });
  }

  void _atualizaContagem(int index, int contador) {
    setState(() {
      widget._qtdSeries[index] = contador;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Deseja sair sem salvar?',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                        ),
                        flex: 5,
                      ),
                    ],
                  ),
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                              },
                              child: Text(
                                'Sim',
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
                              )),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Não',
                                style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
                              )),
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                    ),
                  ],
                ));
      },
      child: Scaffold(
        appBar: AppBarComponent(title: widget.treino?.titulo ?? '', color: 0xFF22272B, fontSizes: 30, barHeight: 70),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Dates(),
                ListView.builder(
                  itemCount: widget._exercicios.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (widget._colors[index].isEmpty) {
                      widget._colors[index] = List.filled(widget._exercicios[index].qtdSeries, Color(0xFFC4C4C4));
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                          height: (90) + (42 * widget._exercicios[index].qtdSeries.toDouble()),
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
                                          widget._exercicios[index].nome,
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
                                            "Séries: ${widget._exercicios[index].qtdSeries.toString()}",
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 12.0),
                                          child: Text(
                                            "Repetições: ${widget._exercicios[index].repeticoes.toString()}",
                                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Text(
                                          "Peso: ${widget._exercicios[index].qtdPeso.toString()} kg",
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ListView.builder(
                                    itemCount: widget._exercicios[index].qtdSeries,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, indice) {
                                      return GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              if (widget._colors[index][indice] == Color(0xFFC4C4C4)) {
                                                widget._colors[index][indice] = Color(0xFFA4FC5E);
                                              } else {
                                                widget._colors[index][indice] = Color(0xFFC4C4C4);
                                              }
                                            });
                                            widget.cont = widget._colors[index]
                                                .map((element) => element == Color(0xFFA4FC5E) ? 1 : 0)
                                                .reduce((value, element) => value + element);
                                            _atualizaContagem(index, widget.cont);
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 8.0),
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width,
                                              height: 34,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: widget._colors[index][indice], borderRadius: BorderRadius.circular(10)),
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
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                bool finalizar = false;
                for (int i = 0; i < widget._qtdSeries.length; i++) {
                  if (widget._qtdSeries[i] != widget._exercicios[i].qtdSeries) {
                    finalizar = true;
                  }
                }
                if(widget._qtdSeries.isEmpty){
                  finalizar = true;
                }
                if (finalizar) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Treino incompleto, deseja finalizar?',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                            ),
                            flex: 5,
                          ),
                        ],
                      ),
                      elevation: 3,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: Row(
                            children: [
                              TextButton(
                                  onPressed: () {
                                    _saveTreinoAndExercicioFinalizado(context);
                                  },
                                  child: Text(
                                    'Sim',
                                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Não',
                                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500, fontSize: 20),
                                  )),
                            ],
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          ),
                        ),
                      ],
                    ),
                  );
                }else{
                  _saveTreinoAndExercicioFinalizado(context);
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFF37C05D)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              ),
              child: Text(
                TreinoAtivo._botaoFinalizar,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveTreinoAndExercicioFinalizado(BuildContext context) async {
    final TreinoFinalizado treinoFinalizado =
        TreinoFinalizado(0, widget.treino?.titulo ?? '', DateFormat('dd/MM/yyyy', 'pt_BR').format(DateTime.now()).toString());
    _daoTreinoFinalizado.save(treinoFinalizado);
    final ultimoTreino = await _daoTreinoFinalizado.findLast();

    for (int i = 0; i < widget._exercicios.length; i++) {
      final ExercicioFinalizado exercicioFinalizado = ExercicioFinalizado(0, widget._exercicios[i].nome, widget._exercicios[i].qtdSeries,
          widget._exercicios[i].qtdPeso, widget._exercicios[i].repeticoes, widget._qtdSeries[i]);
      _daoExercicioFinalizado.save(exercicioFinalizado, ultimoTreino);
    }

    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }
}
