import 'dart:developer' as developer;

import 'package:flutter/material.dart';

class SimpleOverlayWidget extends StatelessWidget {
  final String tag;
  final Widget child;
  late final OverlayState _overlayState;
  late final OverlayEntry _overlayEntry;
  final void Function()? onShow;
  final void Function()? onHide;

  SimpleOverlayWidget({
    required this.tag,
    required BuildContext context,
    required Widget overlay,
    required this.child,
    void Function()? onTapOutside,
    this.onShow,
    this.onHide,
    double? top,
    double? left,
    double? bottom,
    double? right,
  }) : super(key: Key(tag)) {
    _overlayState = Overlay.of(context)!;
    _overlayEntry = OverlayEntry(builder: (contextBuilder) {
      //final renderBox = context.findRenderObject() as RenderBox;
      return Stack(
        children: [
          if (onTapOutside != null) GestureDetector(onTap: () => hide()),
          Positioned(
            top: top,
            left: left,
            bottom: bottom,
            right: right,
            child: overlay,
          ),
        ],
      );
    });
    show();
  }

  void show() {
    try {
      Future.delayed(const Duration(milliseconds: 200)).then((value) {
        _overlayState.insert(_overlayEntry);
        onShow?.call();
      });
    } catch (_) {
      developer.log("Error on show overlay $tag", name: "simple_overlay");
    }
  }

  void hide() {
    try {
      _overlayEntry.remove();
      onHide?.call();
    } catch (_) {
      developer.log("Error on hide overlay $tag", name: "simple_overlay");
    }
  }

  @override
  Widget build(BuildContext context) => child;
}
