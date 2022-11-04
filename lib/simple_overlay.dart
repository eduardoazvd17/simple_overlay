import 'dart:developer' as developer;

import 'package:flutter/material.dart';

class SimpleOverlay {
  OverlayState? _overlayState;
  OverlayEntry? _overlayEntry;
  Function()? onHide;

  bool _isVisible = false;
  bool get isVisible => _isVisible;

  void show({
    required Widget overlay,
    required BuildContext context,
    bool hideOnTapOutside = true,
    double? top,
    double? left,
    double? bottom,
    double? right,
    Function()? onShow,
    Function()? onHide,
    Function()? onTapOutside,
    Duration? delay,
  }) {
    this.onHide = onHide;
    try {
      _hideOverlay(log: false);
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

      if (delay != null) {
        Future.delayed(delay).then((_) {
          _showOverlay();
          onShow?.call();
        });
      } else {
        _showOverlay();
        onShow?.call();
      }
    } catch (_) {
      developer.log("Error on show overlay", name: "simple_overlay");
    }
  }

  void hide() {
    _hideOverlay();
    onHide?.call();
  }

  void _showOverlay({bool log = true}) {
    try {
      _isVisible = true;
      if (_overlayState != null && _overlayEntry != null) {
        _overlayState!.insert(_overlayEntry!);
      }

      if (log) developer.log("Showing overlay", name: "simple_overlay");
    } catch (_) {
      if (log) developer.log("Error on show overlay", name: "simple_overlay");
    }
  }

  void _hideOverlay({bool log = true}) {
    try {
      _isVisible = false;
      if (_overlayEntry != null) {
        _overlayEntry!.remove();
      }

      if (log) developer.log("Hiding overlay", name: "simple_overlay");
    } catch (_) {
      if (log) developer.log("Error on hide overlay", name: "simple_overlay");
    }
  }
}
