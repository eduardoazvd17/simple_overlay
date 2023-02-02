import 'package:flutter/material.dart';
import 'package:simple_overlay/simple_overlay.dart';

void main() {
  runApp(MaterialApp(home: HomePage()));
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final overlayController1 = SimpleOverlayController();
  final overlayController2 = SimpleOverlayController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('simple_overlay example')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: overlayController1.show,
                child: const Text('Show overlay #1'),
              ),
              ElevatedButton(
                onPressed: overlayController2.show,
                child: const Text('Show overlay #2'),
              ),
            ],
          ),
          SimpleOverlayWidget(
            context: context,
            controller: overlayController1,
            hideOnTapOutside: false,
            position: SimpleOverlayPosition.topLeft(),
            overlayWidget: _overlayWidget1,
            child: Container(
              height: 100,
              width: 80,
              color: Colors.red,
            ),
          ),
          SimpleOverlayWidget(
            context: context,
            controller: overlayController2,
            hideOnTapOutside: false,
            position: SimpleOverlayPosition.topRight(),
            overlayWidget: _overlayWidget2,
            child: Container(
              height: 80,
              width: 100,
              color: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget get _overlayWidget1 {
    return Card(
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Text('Overlay #1'),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: overlayController1.hide,
                child: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _overlayWidget2 {
    return Card(
      elevation: 8.0,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const Text('Overlay #2'),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: overlayController2.hide,
                child: const Icon(Icons.close),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
