class SimpleOverlayConfiguration {
  final bool startShowing;
  final bool hideOnTapOutside;
  final Duration? autoHideDuration;

  SimpleOverlayConfiguration({
    this.startShowing = false,
    this.hideOnTapOutside = false,
    this.autoHideDuration,
  });
}
