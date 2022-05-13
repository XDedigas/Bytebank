import 'package:flutter/material.dart';

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String? rotulo;
  final String? dica;
  final IconData? icone;
  final TextInputType? keybord;

  // ignore: use_key_in_widget_constructors, prefer_const_constructors_in_immutables
  Editor(
      {required this.controlador,
      this.rotulo,
      this.dica,
      this.icone,
      this.keybord});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controlador,
        style: const TextStyle(fontSize: 24),
        decoration: InputDecoration(
          icon: icone != null ? Icon(icone) : null,
          labelText: rotulo,
          hintText: dica,
        ),
        keyboardType: keybord,
      ),
    );
  }
}
