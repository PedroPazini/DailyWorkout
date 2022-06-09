import 'package:daily_workout/database/dao/exercicio_finalizado_dao.dart';
import 'package:daily_workout/screens/calendar/treino_finalizado_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:intl/intl.dart';

import '../../database/dao/treino_finalizado_dao.dart';
import '../../enum/menu_items.dart';
import '../../models/Exercicio_finalizado.dart';
import '../../models/Treino_finalizado.dart';

// ignore: must_be_immutable
class ItemTreinoFinalizado extends StatefulWidget {
  static const String _buttonName = "Visualizar";
  TreinoFinalizado? _treino;
  late List<ExercicioFinalizado> _exerciciosFinalizados = [];
  Function callback;

  ItemTreinoFinalizado(this._treino, this.callback);

  @override
  State<ItemTreinoFinalizado> createState() => _ItemTreinoFinalizadoState();
}

class _ItemTreinoFinalizadoState extends State<ItemTreinoFinalizado> {
  final ExercicioFinalizadoDao _exercicioFinalizadoDao = ExercicioFinalizadoDao();
  final TreinoFinalizadoDao _treinoFinalizadoDao = TreinoFinalizadoDao();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
          height: 132,
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
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Text(
                          widget._treino?.titulo ?? '',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
                        ),
                        Spacer(),
                        PopupMenuButton<MenuConfig>(
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
                              height: 16,
                              padding: EdgeInsets.all(8),
                              value: MenuConfig.excluir,
                              child: Row(
                                children: [
                                  Icon(Icons.remove, color: Colors.red, size: 20),
                                  Text(
                                    'Remover',
                                    style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ],
                          onSelected: (value) {
                            switch (value) {
                              case MenuConfig.excluir:
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Center(
                                          child: Text(
                                            'Deseja remover?',
                                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                                          )),
                                      elevation: 3,
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                                      actions: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 24, right: 24),
                                          child: Row(
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    widget.callback(_exercicioFinalizadoDao, _treinoFinalizadoDao, widget._treino?.treino_id);
                                                    Navigator.pushNamedAndRemoveUntil(context, '/calendar', (route) => false);
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
                                break;
                              case MenuConfig.editar:
                                break;
                            }
                          },
                          child: Image.asset("images/tres_pontos_20.png"),
                        )
                      ],
                    ),
                  ),
                  Text('Treino realizado: ' + DateFormat("MMMEd", "pt_BR").format(DateTime.now()).toString().capitalize(),
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: Colors.black.withOpacity(0.5))),
                  Padding(
                    padding: const EdgeInsets.only(top: 18),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () async {
                          final List<ExercicioFinalizado> _listExercicios =
                              await _exercicioFinalizadoDao.findAllByTreinoId(widget._treino?.treino_id ?? 0);
                          setState(() {
                            widget._exerciciosFinalizados = _listExercicios;
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return TreinoFinalizadoPage(widget._treino, widget._exerciciosFinalizados);
                          }));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(const Color(0xFFFFBE00)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                        ),
                        child: Text(
                          ItemTreinoFinalizado._buttonName,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
