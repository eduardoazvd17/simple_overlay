import 'package:flutter/material.dart';

class SimpleOverlayConfiguration {
  final bool startShowing;
  final bool hideOnTapOutside;
  final Duration? autoHideDuration;
  final Color shadowColor;
  final double? shadowOpacity;
  final VoidCallback? onShowOverlay;
  final VoidCallback? onHideOverlay;

  SimpleOverlayConfiguration({
    this.startShowing = false,
    this.hideOnTapOutside = false,
    this.autoHideDuration,
    this.shadowColor = Colors.black,
    this.shadowOpacity,
    this.onShowOverlay,
    this.onHideOverlay,
  }) {
    if (shadowOpacity != null) {
      assert(
        shadowOpacity! >= 0.0 && shadowOpacity! <= 1.0,
        'shadowOpacity property needs to be between 0.0 and 1.0',
      );
    }
  }
}
