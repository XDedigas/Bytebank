import 'package:flutter/material.dart';

class TransferenciaAuthDialog extends StatefulWidget {
  final Function(String password) onConfirm;

  // ignore: use_key_in_widget_constructors
  const TransferenciaAuthDialog({required this.onConfirm});

  @override
  State<TransferenciaAuthDialog> createState() =>
      _TransferenciaAuthDialogState();
}

class _TransferenciaAuthDialogState extends State<TransferenciaAuthDialog> {
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: const Text('Autenticação'),
        content: TextField(
          controller: _passwordController,
          obscureText: true,
          maxLength: 4,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 64, letterSpacing: 24),
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              widget.onConfirm(_passwordController.text);
              Navigator.pop(context);
            },
            child: const Text('Confirm'),
          ),
        ]);
  }
}
