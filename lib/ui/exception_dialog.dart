import 'package:flutter/material.dart';

class ExceptionDialog extends StatelessWidget {
  const ExceptionDialog({required String message, super.key}) : _message = message;
  final String _message;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(_message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
