import 'package:flutter/material.dart';
import 'package:simple_overlay/simple_overlay.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final overlayController = SimpleOverlayController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('simple_overlay example')),
      body: Center(
        child: SimpleOverlayWidget(
          context: context,
          controller: overlayController,
          hideOnTapOutside: false,
          position: SimpleOverlayPosition(top: 0, right: 0),
          overlayWidget: _overlayWidget,
          child: const Text('Hello world!'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: overlayController.show,
        child: const Icon(Icons.open_in_browser),
      ),
    );
  }

  Widget get _overlayWidget {
    return Card(
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Text('simple_overlay'),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: overlayController.hide,
                child: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
