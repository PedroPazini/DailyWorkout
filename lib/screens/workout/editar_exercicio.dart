import 'package:daily_workout/components/app_bar_component.dart';
import 'package:daily_workout/models/Exercicio.dart';
import 'package:flutter/material.dart';
import '../../services/Editor.dart';

// ignore: must_be_immutable
class EditarExercicio extends StatefulWidget {
  final Exercicio exercicio;
  Function callbackEdit;
  final int index;

  EditarExercicio(this.exercicio, this.callbackEdit, this.index);

  static const _botaoConfirmar = 'Confirmar';

  @override
  State<EditarExercicio> createState() => _EditarExercicioState();
}

class _EditarExercicioState extends State<EditarExercicio> {
  late TextEditingController _controllerCampoNome = TextEditingController();

  late TextEditingController _controllerCampoQtdSerie = TextEditingController();

  late TextEditingController _controllerCampoQtdPeso = TextEditingController();

  late TextEditingController _controllerCampoRepeticoes = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controllerCampoNome.text = widget.exercicio.nome;
    _controllerCampoQtdSerie.text = widget.exercicio.qtdSeries.toString();
    _controllerCampoQtdPeso.text = widget.exercicio.qtdPeso.toString();
    _controllerCampoRepeticoes.text = widget.exercicio.repeticoes.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBarComponent(title: "Editar exercício", color: 0xFF22272B, barHeight: 70, fontSizes: 30),
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
              onPressed: () => _editarExercicio(context),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(const Color(0xFF37C05D)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              ),
              child: Text(
                EditarExercicio._botaoConfirmar,
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

  void _editarExercicio(BuildContext context) {
    final String nomeExercicio = _controllerCampoNome.text;
    final int? qtdSerie = int.tryParse(_controllerCampoQtdSerie.text);
    final int? qtdPeso = int.tryParse(_controllerCampoQtdPeso.text);
    final int? rep = int.tryParse(_controllerCampoRepeticoes.text);

    if (qtdSerie != null && qtdPeso != null && rep != null) {
      widget.exercicio.nome = nomeExercicio;
      widget.exercicio.qtdSeries = qtdSerie;
      widget.exercicio.qtdPeso = qtdPeso;
      widget.exercicio.repeticoes = rep;
      widget.callbackEdit(widget.index, widget.exercicio);

      Navigator.pop(context);
    }
  }
}
