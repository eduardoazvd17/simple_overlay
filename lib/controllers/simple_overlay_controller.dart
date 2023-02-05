import 'package:flutter/material.dart';

class SimpleOverlayController {
  final state = ValueNotifier<bool>(false);
  void show() => state.value = true;
  void hide() => state.value = false;
}
