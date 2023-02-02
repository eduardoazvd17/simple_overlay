class SimpleOverlayPosition {
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;

  SimpleOverlayPosition({
    this.top,
    this.left,
    this.right,
    this.bottom,
  });

  factory SimpleOverlayPosition.topLeft({
    double? top,
    double? left,
  }) {
    return SimpleOverlayPosition(
      top: top ?? 0,
      left: left ?? 0,
    );
  }

  factory SimpleOverlayPosition.topRight({
    double? top,
    double? right,
  }) {
    return SimpleOverlayPosition(
      top: top ?? 0,
      right: right ?? 0,
    );
  }

  factory SimpleOverlayPosition.bottomLeft({
    double? bottom,
    double? left,
  }) {
    return SimpleOverlayPosition(
      bottom: bottom ?? 0,
      left: left ?? 0,
    );
  }

  factory SimpleOverlayPosition.bottomRight({
    double? bottom,
    double? right,
  }) {
    return SimpleOverlayPosition(
      bottom: bottom ?? 0,
      right: right ?? 0,
    );
  }

  factory SimpleOverlayPosition.custom({
    double? top,
    double? left,
    double? right,
    double? bottom,
  }) {
    return SimpleOverlayPosition(
      top: top,
      left: left,
      right: right,
      bottom: bottom,
    );
  }
}
