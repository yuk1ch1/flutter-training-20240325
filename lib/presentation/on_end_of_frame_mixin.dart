import 'dart:async';

import 'package:flutter/material.dart';

mixin OnEndOfFrameMixin<T extends StatefulWidget> on State<T> {
  @override
  void initState() {
    super.initState();
    unawaited(executeOnEndOfFrame());
  }

  Future<void> executeOnEndOfFrame() async {
    await WidgetsBinding.instance.endOfFrame;

    unawaited(actionOnEndOfFrame());
  }

  Future<void> actionOnEndOfFrame();
}
