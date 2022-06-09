import 'package:daily_workout/components/app_bar_component.dart';
import 'package:flutter/material.dart';

import '../../components/bottom_navigation_home.dart';
import '../../components/datas.dart';
import '../../database/dao/exercicio_dao.dart';
import '../../database/dao/treino_dao.dart';
import '../../models/Treino.dart';
import '../workout/criar_treino.dart';
import 'card_item_treino.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const _appBarTitulo = 'Treinos';
  static const _botaoTitulo = 'Novo treino';
  final TreinoDao _dao = TreinoDao();

  void callback(ExercicioDao _exercicioDao, TreinoDao _treinoDao, int id) {
    setState(() {
      _exercicioDao.deletePorTreino(id);
      _treinoDao.delete(id);
    });
  }

  void callbackEdit(TreinoDao _treinoDao, Treino treino) {
    setState(() {
      _treinoDao.update(treino);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBarComponent(
          title: _appBarTitulo, color: 0xFF22272B, barHeight: 70, fontSizes: 30, image: Image.asset('images/logo_pequena_40')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Dates(),
              FutureBuilder<List<Treino>>(
                initialData: [],
                future: _dao.findAll(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      break;
                    case ConnectionState.waiting:
                      const Text('Carregando arquivos...');
                      break;
                    case ConnectionState.active:
                      break;
                    case ConnectionState.done:
                      final List<Treino> treinos = snapshot.data!;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: treinos.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, indice) {
                          return (ItemTreino(treinos[indice], callback, callbackEdit));
                        },
                      );
                  }
                  return const Text('Unknown error');
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return CriarTreino();
                      })).then((value) => setState(() {}));
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color(0xFFFBCA2C)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Icon(Icons.add, color: Colors.black),
                        Padding(
                          padding: EdgeInsets.only(left: 66, top: 0),
                          child: Text(
                            _botaoTitulo,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationHome(),
    );
  }
}
