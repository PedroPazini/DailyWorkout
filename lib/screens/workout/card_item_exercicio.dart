import 'package:daily_workout/models/Exercicio.dart';
import 'package:flutter/material.dart';

import '../../enum/menu_items.dart';
import 'editar_exercicio.dart';

// ignore: must_be_immutable
class ItemExercicio extends StatefulWidget {
  final Exercicio _exercicio;
  Function callbackRemove;
  Function callbackEdit;
  final int index;

  ItemExercicio(this._exercicio, this.callbackRemove, this.index, this.callbackEdit);

  @override
  State<ItemExercicio> createState() => _ItemExercicioState();
}

class _ItemExercicioState extends State<ItemExercicio> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
          height: 89,
          width: MediaQuery.of(context).size.width,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFEEEFEC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
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
                        Spacer(),
                        PopupMenuButton<MenuConfig>(
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem(
                              padding: EdgeInsets.all(8),
                              height: 16,
                              value: MenuConfig.editar,
                              child: Row(
                                children: [
                                  Icon(Icons.edit, size: 20),
                                  Text(
                                    'Editar',
                                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
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
                              case MenuConfig.editar:
                                Navigator.push(context, MaterialPageRoute(builder: (context) {
                                  return EditarExercicio(widget._exercicio, widget.callbackEdit, widget.index);
                                }));
                                break;
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
                                                        this.widget.callbackRemove(widget.index);
                                                        Navigator.of(context).pop();
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
                            }
                          },
                          child: Image.asset("images/tres_pontos_20.png"),
                        )
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
                  )
                ],
              ),
            ),
          )),
    );
  }
}
