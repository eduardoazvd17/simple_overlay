import 'package:flutter/material.dart';
import 'package:simple_overlay/controllers/simple_overlay_controller.dart';

import '../models/simple_overlay_position.dart';

class SimpleOverlayWidget extends StatelessWidget {
  final BuildContext context;
  final SimpleOverlayController controller;
  final Widget child;
  final SimpleOverlayPosition? position;
  final Widget overlayWidget;
  final bool hideOnTapOutside;

  const SimpleOverlayWidget({
    super.key,
    required this.context,
    required this.controller,
    required this.child,
    this.position,
    required this.overlayWidget,
    this.hideOnTapOutside = false,
  });

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      OverlayState? state = _buildOverlayState(context);
      OverlayEntry? entry = _buildOverlayEntry(
        context: context,
        overlayWidget: overlayWidget,
        hideOnTapOutside: hideOnTapOutside,
      );

      controller.state.addListener(() {
        if (controller.state.value) {
          _showOverlay(state, entry);
        } else {
          _hideOverlay(entry);
        }
      });
    });

    return child;
  }

  void _showOverlay(OverlayState? state, OverlayEntry? entry) {
    if (state != null && entry != null) state.insert(entry);
  }

  void _hideOverlay(OverlayEntry? entry) {
    if (entry != null) entry.remove();
  }

  OverlayState _buildOverlayState(BuildContext context) {
    return Overlay.of(context)!;
  }

  OverlayEntry _buildOverlayEntry({
    required BuildContext context,
    required Widget overlayWidget,
    required bool hideOnTapOutside,
  }) {
    final RenderBox? renderBox = (context.findRenderObject() ??
        this.context.findRenderObject()) as RenderBox?;
    assert(renderBox != null);

    final Size size = renderBox!.size;
    final Offset offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(builder: (contextBuilder) {
      return Stack(
        children: [
          GestureDetector(
            onTap: hideOnTapOutside ? () => controller.hide() : null,
          ),
          Positioned(
            top: position?.bottom != null
                ? offset.dy + size.height - (position!.bottom! * 10)
                : position?.bottom,
            left: position?.right != null
                ? offset.dx + size.width - (position!.right! * 10)
                : position?.right,
            bottom: position?.top != null
                ? offset.dy - size.height - (position!.top! * 10)
                : position?.top,
            right: position?.left != null
                ? offset.dx + size.width - (position!.left! * 10)
                : position?.left,
            child: overlayWidget,
          ),
        ],
      );
    });
  }
}
