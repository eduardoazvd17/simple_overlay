import 'package:flutter/material.dart';
import '../simple_overlay.dart';

class SimpleOverlayWidget extends StatefulWidget {
  final SimpleOverlayController? controller;
  final Widget child;
  final SimpleOverlayPosition position;
  final Widget overlayWidget;
  final SimpleOverlayConfiguration? configuration;

  const SimpleOverlayWidget({
    super.key,
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
  OverlayState? state;
  OverlayEntry? entry;

  final defaultController = SimpleOverlayController();
  SimpleOverlayController get controller {
    return widget.controller ?? defaultController;
  }

  final defaultConfiguration = SimpleOverlayConfiguration();
  SimpleOverlayConfiguration get configuration {
    return widget.configuration ?? defaultConfiguration;
  }

  @override
  void initState() {
    state = Overlay.of(context);
    entry = _buildOverlayEntry(
      overlayWidget: widget.overlayWidget,
    );
    controller.state.addListener(() {
      if (controller.state.value) {
        _showOverlay();
      } else {
        _hideOverlay();
      }
    });

    WidgetsBinding.instance.addObserver(_ResizeObserver(_handleWindowResize));

    super.initState();
  }

  void _handleWindowResize() {
    setState(() {
      entry = _buildOverlayEntry(
        overlayWidget: widget.overlayWidget,
      );
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (configuration.startShowing) {
        controller.show();
        _showOverlay();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  void _showOverlay() {
    _hideOverlay();
    state!.insert(entry!);

    configuration.onShowOverlay?.call();

    if (configuration.autoHideDuration != null) {
      Future.delayed(configuration.autoHideDuration!).then(
        (_) => controller.hide(),
      );
    }
  }

  void _hideOverlay() {
    try {
      entry!.remove();
      configuration.onHideOverlay?.call();
    } catch (_) {}
  }

  OverlayEntry _buildOverlayEntry({required Widget overlayWidget}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox == null) return;

      final double screenHeight = MediaQuery.of(context).size.height;
      final double screenWidth = MediaQuery.of(context).size.width;

      final Size size = renderBox.size;
      final Offset offset = renderBox.localToGlobal(Offset.zero);
      final double y = (offset.dy + (size.height / 2));
      final double x = (offset.dx + (size.width / 2));

      setState(() {
        entry = OverlayEntry(builder: (contextBuilder) {
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
                    ? (screenWidth -
                        x +
                        (size.width / 2) +
                        widget.position.left!)
                    : null,
                bottom: widget.position.top != null
                    ? (screenHeight -
                        y +
                        (size.height / 2) +
                        widget.position.top!)
                    : null,
                child: overlayWidget,
              ),
            ],
          );
        });
      });
    });

    return OverlayEntry(builder: (context) => Container());
  }

  @override
  void dispose() {
    if (entry != null) _hideOverlay();
    controller.state.dispose();
    state!.dispose();
    entry!.dispose();

    WidgetsBinding.instance
        .removeObserver(_ResizeObserver(_handleWindowResize));
    super.dispose();
  }
}

class _ResizeObserver extends WidgetsBindingObserver {
  final VoidCallback callback;

  _ResizeObserver(this.callback);

  @override
  void didChangeMetrics() {
    callback();
  }
}
