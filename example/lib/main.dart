import 'package:flutter/material.dart';
import 'package:simple_overlay/simple_overlay.dart';

void main() {
  runApp(MaterialApp(home: HomePage()));
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final overlayController = SimpleOverlayController();

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
                onPressed: overlayController.show,
                child: const Text("Show overlay's"),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SimpleOverlayWidget(
                context: context,
                controller: overlayController,
                hideOnTapOutside: false,
                position: SimpleOverlayPosition.topRight(),
                overlayWidget: _overlayWidget,
                child: const Text('top right'),
              ),
              SimpleOverlayWidget(
                context: context,
                controller: overlayController,
                hideOnTapOutside: false,
                position: SimpleOverlayPosition.bottomRight(),
                overlayWidget: _overlayWidget,
                child: const Text('bottom right'),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SimpleOverlayWidget(
                context: context,
                controller: overlayController,
                hideOnTapOutside: false,
                position: SimpleOverlayPosition.topLeft(),
                overlayWidget: _overlayWidget,
                child: const Text('top left'),
              ),
              SimpleOverlayWidget(
                context: context,
                controller: overlayController,
                hideOnTapOutside: false,
                position: SimpleOverlayPosition.bottomLeft(),
                overlayWidget: _overlayWidget,
                child: const Text('bottom left'),
              ),
            ],
          ),
        ],
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
            const Text('Hello im a overlay widget'),
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
