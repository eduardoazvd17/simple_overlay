import 'package:flutter/material.dart';
import 'package:simple_overlay/simple_overlay.dart';

void main() {
  runApp(MaterialApp(home: HomePage()));
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final controller = SimpleOverlayController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('simple_overlay example')),
      body: Center(
        child: SimpleOverlayWidget(
          controller: controller,
          configuration: SimpleOverlayConfiguration(
            startShowing: false,
            hideOnTapOutside: true,
            autoHideDuration: null,
            shadowColor: Colors.black,
            shadowOpacity: 0.5,
            onShowOverlay: () {
              // ignore: avoid_print
              print('onShowOverlay');
            },
            onHideOverlay: () {
              // ignore: avoid_print
              print('onHideOverlay');
            },
          ),
          position: SimpleOverlayPosition.topLeft(),
          overlayWidget: _overlayWidget,
          child: _child,
        ),
      ),
    );
  }

  Widget get _overlayWidget => const Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('simple_overlay'),
        ),
      );

  Widget get _child {
    return ElevatedButton(
      onPressed: () {
        if (controller.state.value) {
          controller.hide();
        } else {
          controller.show();
        }
      },
      child: const Text("Show / Hide"),
    );
  }
}
