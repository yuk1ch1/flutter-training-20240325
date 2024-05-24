import 'package:flutter/material.dart';

class LoadingIndicatorScreen extends StatelessWidget {
  const LoadingIndicatorScreen({
    super.key,
    Color backgroundColor = const Color.fromRGBO(0, 0, 0, 0.5),
  }) : _backgroundColor = backgroundColor;

  final Color _backgroundColor;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: AbsorbPointer(
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: _backgroundColor,
          ),
          child: const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
