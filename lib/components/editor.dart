import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  const Editor({
    required this.controlador,
    required this.rotulo,
    required this.dica,
    this.icone,
  });

  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData? icone;
  //* Quando não se porde ser NULL tem q por a interrogação
  /*
       * *icon: icone != null ? Icon(icone) : null */

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controlador,
        style: TextStyle(fontSize: 24.0),
        decoration: InputDecoration(
            icon: icone != null ? Icon(icone) : null,
            labelText: rotulo,
            hintText: dica),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
