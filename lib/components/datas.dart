import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:intl/intl.dart';

class Dates extends StatelessWidget {
  const Dates({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 16.0, 0),
          child: Text(
            DateFormat("EEEE", "pt_BR").format(DateTime.now()).toString().capitalize(),
            style: const TextStyle(fontSize: 36),
          ),
        ),
        Text(
          DateFormat("dd/MM/yyyy", "pt_BR").format(DateTime.now()).toString(),
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
