import 'package:flutter/material.dart';

class SimpleOverlayConfiguration {
  final bool startShowing;
  final bool hideOnTapOutside;
  final Duration? autoHideDuration;
  final VoidCallback? onShowOverlay;
  final VoidCallback? onHideOverlay;

  SimpleOverlayConfiguration({
    this.startShowing = false,
    this.hideOnTapOutside = false,
    this.autoHideDuration,
    this.onShowOverlay,
    this.onHideOverlay,
  });
}
