import 'package:flutter/material.dart';
import 'package:simple_overlay/controllers/simple_overlay_controller.dart';

import '../models/simple_overlay_position.dart';

class SimpleOverlayWidget extends StatefulWidget {
  final BuildContext context;
  final SimpleOverlayController controller;
  final Widget child;
  final SimpleOverlayPosition position;
  final Widget overlayWidget;
  final bool hideOnTapOutside;

  const SimpleOverlayWidget({
    super.key,
    required this.context,
    required this.controller,
    required this.child,
    required this.position,
    required this.overlayWidget,
    this.hideOnTapOutside = false,
  });

  @override
  State<SimpleOverlayWidget> createState() => _SimpleOverlayWidgetState();
}

class _SimpleOverlayWidgetState extends State<SimpleOverlayWidget> {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OverlayState state = _buildOverlayState(context);
      OverlayEntry entry = _buildOverlayEntry(
        context: context,
        overlayWidget: widget.overlayWidget,
        hideOnTapOutside: widget.hideOnTapOutside,
      );

      widget.controller.state.addListener(() {
        if (widget.controller.state.value) {
          _showOverlay(state, entry);
        } else {
          _hideOverlay(entry);
        }
      });
    });

    return widget.child;
  }

  void _showOverlay(OverlayState state, OverlayEntry entry) {
    state.insert(entry);
  }

  void _hideOverlay(OverlayEntry entry) {
    entry.remove();
  }

  OverlayState _buildOverlayState(BuildContext context) {
    return Overlay.of(context)!;
  }

  OverlayEntry _buildOverlayEntry({
    required BuildContext context,
    required Widget overlayWidget,
    required bool hideOnTapOutside,
  }) {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    assert(renderBox != null);

    final Size size = renderBox!.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(builder: (contextBuilder) {
      return Stack(
        children: [
          GestureDetector(
            onTap: hideOnTapOutside ? widget.controller.hide : null,
          ),
          Positioned(
            top: widget.position.bottom != null
                ? (offset.dy + size.height) - (widget.position.bottom!)
                : null,
            left: widget.position.right != null
                ? (offset.dx + size.width) - (widget.position.right!)
                : null,
            bottom: widget.position.top != null
                ? (offset.dy - size.height) - (widget.position.top!)
                : null,
            right: widget.position.left != null
                ? (offset.dx + size.width) - (widget.position.left!)
                : null,
            child: overlayWidget,
          ),
        ],
      );
    });
  }

  @override
  void dispose() {
    widget.controller.state.dispose();
    super.dispose();
  }
}
