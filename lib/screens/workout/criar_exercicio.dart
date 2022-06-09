import 'package:daily_workout/components/app_bar_component.dart';
import 'package:daily_workout/models/Exercicio.dart';
import 'package:flutter/material.dart';
import '../../services/Editor.dart';

class CriarExercicio extends StatelessWidget {
  CriarExercicio({Key? key}) : super(key: key);
  final TextEditingController _controllerCampoNome = TextEditingController();
  final TextEditingController _controllerCampoQtdSerie = TextEditingController();
  final TextEditingController _controllerCampoQtdPeso = TextEditingController();
  final TextEditingController _controllerCampoRepeticoes = TextEditingController();
  static const _botaoConfirmar = 'Confirmar';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBarComponent(title: "Novo exercício", color: 0xFF22272B, barHeight: 70, fontSizes: 30),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Editor(controller: _controllerCampoNome, rotulo: "Nome do exercício", tipoKeyboard: true),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Editor(controller: _controllerCampoQtdSerie, rotulo: "Quantidade de séries", tipoKeyboard: false, limite: 2),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Editor(controller: _controllerCampoQtdPeso, rotulo: "Quantidade de peso (kg)", tipoKeyboard: false, limite: 3),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Editor(controller: _controllerCampoRepeticoes, rotulo: "Repetições", tipoKeyboard: false, limite: 2),
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
              onPressed: () => _criaExercicio(context),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFF37C05D)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              ),
              child: Text(
                _botaoConfirmar,
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

  void _criaExercicio(BuildContext context) {
    final String nomeExercicio = _controllerCampoNome.text;
    final int? qtdSerie = int.tryParse(_controllerCampoQtdSerie.text);
    final int? qtdPeso = int.tryParse(_controllerCampoQtdPeso.text);
    final int? rep = int.tryParse(_controllerCampoRepeticoes.text);

    if (qtdSerie != null && qtdPeso != null && rep != null) {
      final Exercicio exercicioCriado = Exercicio(0,nomeExercicio, qtdSerie, qtdPeso, rep);
      Navigator.pop(context, exercicioCriado);
    }
  }
}
