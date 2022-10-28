import 'dart:developer' as developer;

import 'package:flutter/material.dart';

class SimpleOverlay {
  final String tag;
  final BuildContext context;
  final Widget overlay;
  final bool hideOnTapOutside;

  final void Function()? onShow;
  final void Function()? onHide;
  final void Function()? onTapOutside;

  late final OverlayState _overlayState;
  late final OverlayEntry _overlayEntry;

  bool _isVisible = false;
  bool get isVisible => _isVisible;

  SimpleOverlay({
    bool startShowing = false,
    required this.tag,
    required this.context,
    required this.overlay,
    this.hideOnTapOutside = true,
    this.onShow,
    this.onHide,
    this.onTapOutside,
    double? top,
    double? left,
    double? bottom,
    double? right,
  }) {
    _overlayState = Overlay.of(context)!;
    _overlayEntry = OverlayEntry(builder: (contextBuilder) {
      //final renderBox = context.findRenderObject() as RenderBox;
      return Stack(
        children: [
          GestureDetector(
            onTap: hideOnTapOutside ? () => hide() : null,
          ),
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
    if (startShowing) show();
  }

  void show() {
    try {
      _isVisible = true;
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
      _isVisible = false;
      _overlayEntry.remove();
      onHide?.call();
    } catch (e) {
      developer.log(
        "Error on hide overlay $tag",
        name: "simple_overlay",
      );
    }
  }
}
