import 'package:daily_workout/components/app_bar_component.dart';
import 'package:daily_workout/screens/workout/criar_exercicio.dart';
import 'package:flutter/material.dart';
import '../../components/datas.dart';
import '../../database/dao/exercicio_dao.dart';
import '../../models/Exercicio.dart';
import '../../models/Treino.dart';
import '../../services/Editor.dart';
import 'card_item_exercicio.dart';
import '../../database/dao/treino_dao.dart';

// ignore: must_be_immutable
class EditarTreino extends StatefulWidget {
  static const _tituloAppBar = 'Editar treino';
  static const _rotuloTitulo = 'Título do treino';
  static const _botaoAdd = 'Exercício';
  static const _botaoSave = 'Salvar';
  late List<Exercicio> _exercicios = <Exercicio>[];
  late List<Exercicio> _exerciciosCriados = <Exercicio>[];
  Treino? _treino;
  late List<int> ids = [];
  Function callbackEdit;

  EditarTreino(this._treino, this.callbackEdit);

  @override
  State<EditarTreino> createState() => _EditarTreinoState();
}

class _EditarTreinoState extends State<EditarTreino> {
  final TextEditingController _controllerCampoTituloTreino = TextEditingController();
  final TreinoDao _daoTreino = TreinoDao();
  final ExercicioDao _daoExercicio = ExercicioDao();

  @override
  void initState() {
    super.initState();
    _controllerCampoTituloTreino.text = widget._treino?.titulo ?? '';
    _daoExercicio.findAllByTreinoId(widget._treino?.treino_id ?? 0).then((value) => {
          setState(() {
            widget._exercicios = value;
          })
        });
  }

  void callbackRemoveExercicio(int index) {
    setState(() {
      widget.ids.add(widget._exercicios[index].exercicio_id);
      widget._exerciciosCriados.remove(widget._exercicios[index]);
      widget._exercicios.removeAt(index);
    });
  }

  void callbackEditaExercicio(int index, Exercicio exercicio) {
    setState(() {
      widget._exercicios[index] = exercicio;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if((_controllerCampoTituloTreino.text != widget._treino?.titulo) || (widget._exerciciosCriados.isNotEmpty) || (widget.ids.isNotEmpty)){
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
        }else{
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          return false;
        }
      },
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarComponent(title: EditarTreino._tituloAppBar, color: 0xFF22272b, barHeight: 56, fontSizes: 30),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Dates(),
                  Editor(controller: _controllerCampoTituloTreino, rotulo: EditarTreino._rotuloTitulo, tipoKeyboard: true),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget._exercicios.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, indice) {
                      return (ItemExercicio(widget._exercicios[indice], callbackRemoveExercicio, indice, callbackEditaExercicio));
                    },
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Stack(
            children: [
              Container(
                height: 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                      child: SizedBox(
                        width: 156,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return CriarExercicio();
                            })).then((exercicioRecebido) => _atualiza(exercicioRecebido));
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color(0xFFFBCA2C)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: const [
                              Icon(Icons.add, color: Colors.black),
                              Text(
                                EditarTreino._botaoAdd,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16, top: 16, bottom: 16),
                      child: SizedBox(
                        width: 156,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_controllerCampoTituloTreino.text == '') {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Não tem nenhum título cadastrado.',
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
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    'voltar',
                                                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 20),
                                                  ),
                                                ),
                                              ],
                                              mainAxisAlignment: MainAxisAlignment.center,
                                            ),
                                          ),
                                        ],
                                      ));
                            } else if (widget._exercicios.isEmpty) {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                'Não tem nenhum exercício cadastrado.',
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
                                          Row(
                                            children: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text(
                                                    'voltar',
                                                    style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 20),
                                                  )),
                                            ],
                                            mainAxisAlignment: MainAxisAlignment.center,
                                          ),
                                        ],
                                      ));
                            } else {
                              _editaTreino(context);
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color(0xFF2D343C)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          ),
                          child: Text(
                            EditarTreino._botaoSave,
                            style: TextStyle(
                              color: Colors.white,
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
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _editaTreino(BuildContext context) async {
    final String tituloTreino = _controllerCampoTituloTreino.text;
    final Treino? treinoCriado = widget._treino;
    treinoCriado?.titulo = tituloTreino;

    for (int i = 0; i < widget.ids.length; i++) {
      _daoExercicio.delete(widget.ids[i]);
    }
    for (int i = 0; i < widget._exerciciosCriados.length; i++) {
      _daoExercicio.save(widget._exerciciosCriados[i], widget._treino!);
    }

    for (int i = 0; i < widget._exercicios.length; i++) {
      _daoExercicio.update(widget._exercicios[i], widget._treino!);
    }

    widget.callbackEdit(_daoTreino, treinoCriado);

    Navigator.pop(context);
  }

  void _atualiza(Exercicio exercicioRecebido) {
    setState(() {
      widget._exercicios.add(exercicioRecebido);
      widget._exerciciosCriados.add(exercicioRecebido);
    });
  }
}
