import 'package:flutter/material.dart';
import '../simple_overlay.dart';

class SimpleOverlayWidget extends StatefulWidget {
  final BuildContext context;
  final SimpleOverlayController? controller;
  final Widget child;
  final SimpleOverlayPosition position;
  final Widget overlayWidget;
  final SimpleOverlayConfiguration? configuration;

  const SimpleOverlayWidget({
    super.key,
    required this.context,
    this.controller,
    required this.child,
    required this.position,
    required this.overlayWidget,
    this.configuration,
  });

  @override
  State<SimpleOverlayWidget> createState() => _SimpleOverlayWidgetState();
}

class _SimpleOverlayWidgetState extends State<SimpleOverlayWidget> {
  final defaultController = SimpleOverlayController();
  final defaultConfiguration = SimpleOverlayConfiguration();

  OverlayState? state;
  OverlayEntry? entry;

  SimpleOverlayController get controller {
    return widget.controller ?? defaultController;
  }

  SimpleOverlayConfiguration get configuration {
    return widget.configuration ?? defaultConfiguration;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      state = _buildOverlayState(context);
      entry = _buildOverlayEntry(
        context: context,
        overlayWidget: widget.overlayWidget,
      );

      assert(state != null);
      assert(entry != null);

      controller.state.addListener(() {
        if (controller.state.value) {
          _showOverlay(state!, entry!);
        } else {
          _hideOverlay(entry!);
        }
      });

      if (configuration.startShowing) {
        controller.show();
        _showOverlay(state!, entry!);
      }
    });

    return widget.child;
  }

  void _showOverlay(OverlayState state, OverlayEntry entry) {
    _hideOverlay(entry);
    state.insert(entry);

    configuration.onShowOverlay?.call();

    if (configuration.autoHideDuration != null) {
      Future.delayed(configuration.autoHideDuration!).then(
        (_) => controller.hide(),
      );
    }
  }

  void _hideOverlay(OverlayEntry entry) {
    try {
      entry.remove();
      configuration.onHideOverlay?.call();
    } catch (_) {}
  }

  OverlayState _buildOverlayState(BuildContext context) {
    return Overlay.of(context);
  }

  OverlayEntry _buildOverlayEntry({
    required BuildContext context,
    required Widget overlayWidget,
  }) {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    assert(renderBox != null);

    /// Screen size
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    /// Child position (center)
    final Size size = renderBox!.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final double y = (offset.dy + (size.height / 2));
    final double x = (offset.dx + (size.width / 2));

    return OverlayEntry(builder: (contextBuilder) {
      return Stack(
        children: [
          GestureDetector(
            onTap: configuration.hideOnTapOutside ? controller.hide : null,
            child: configuration.shadowOpacity != null
                ? Container(
                    color: configuration.shadowColor.withOpacity(
                      configuration.shadowOpacity!,
                    ),
                  )
                : null,
          ),
          Positioned(
            top: widget.position.bottom != null
                ? (y + (size.height / 2) + widget.position.bottom!)
                : null,
            left: widget.position.right != null
                ? (x + (size.width / 2) + widget.position.right!)
                : null,
            right: widget.position.left != null
                ? (screenWidth - x + (size.width / 2) + widget.position.left!)
                : null,
            bottom: widget.position.top != null
                ? (screenHeight - y + (size.height / 2) + widget.position.top!)
                : null,
            child: overlayWidget,
          ),
        ],
      );
    });
  }

  @override
  void dispose() {
    if (entry != null) _hideOverlay(entry!);
    controller.state.dispose();
    state!.dispose();
    entry!.dispose();
    super.dispose();
  }
}
