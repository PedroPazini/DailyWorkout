import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//ignore: must_be_immutable
class Editor extends StatelessWidget {
  late TextEditingController? controller;
  late String? rotulo;
  late String? dica;
  late bool? tipoKeyboard;
  int? limite;

  Editor({this.controller, this.rotulo, this.dica, this.tipoKeyboard, this.limite});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: tipoKeyboard == false ? TextInputType.number : TextInputType.text,
        inputFormatters: tipoKeyboard == false ? [LengthLimitingTextInputFormatter(limite)] : [LengthLimitingTextInputFormatter(20)],
      ),
    );
  }
}
