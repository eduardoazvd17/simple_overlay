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
          context: context,
          controller: controller,
          onShowOverlay: () {
            // ignore: avoid_print
            print('onShowOverlay');
          },
          onHideOverlay: () {
            // ignore: avoid_print
            print('onHideOverlay');
          },
          configuration: SimpleOverlayConfiguration(
            startShowing: false,
            hideOnTapOutside: false,
            autoHideDuration: null,
          ),
          position: SimpleOverlayPosition.bottomRight(),
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

  Widget get _child => ValueListenableBuilder(
        valueListenable: controller.state,
        builder: (context, value, _) {
          if (value) {
            return ElevatedButton(
              onPressed: controller.hide,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.red,
                ),
              ),
              child: const Text("Close"),
            );
          } else {
            return ElevatedButton(
              onPressed: controller.show,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  Colors.green,
                ),
              ),
              child: const Text("Open"),
            );
          }
        },
      );
}
