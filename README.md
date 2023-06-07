<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# simple_overlay
The simple and easy overlay package. With it, you can overlay a custom widget on any other widget.

## Features
- Custom widget overlay;
- Auto show on build;
- Auto hide by duration;
- Hide on tap outside overlay;
- Controller with show/hide functions;
- Custom background shadow color/opacity;

## Getting started
1 - Import library on pubspec.yaml:
```yaml
dependencies:
  simple_overlay: ^1.0.1
```
2 - Add import for SimpleOverlay package on your file:
```dart
import 'package:simple_overlay/simple_overlay.dart';
```
3 - Creating SimpleOverlayWidget:
```dart
SimpleOverlayWidget(
  controller: SimpleOverlayController(),
  configuration: SimpleOverlayConfiguration(
    startShowing: false,
    hideOnTapOutside: true,
    autoHideDuration: const Duration(seconds: 5),
    shadowColor: Colors.black,
    shadowOpacity: 0.5,
    onShowOverlay: () {
      // Called after show overlay widget
    },
    onHideOverlay: () {
      // Called after hide overlay widget
    },
  ),
  position: SimpleOverlayPosition.topLeft(),
  overlayWidget: _overlayWidget,
  child: _child,
)
```
4 - Show/hide overlay manually:
```dart
final controller = SimpleOverlayController();
...
controller.show();
controller.hide();
```
