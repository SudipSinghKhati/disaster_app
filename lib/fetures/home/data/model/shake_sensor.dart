import 'package:sensors/sensors.dart';

class ShakeSensor {
  final double shakeThreshold;
  final Function() onShake;

  ShakeSensor({this.shakeThreshold = 12.0, required this.onShake}) {
    accelerometerEvents.listen((event) {
      final acceleration =
          event.x * event.x + event.y * event.y + event.z * event.z;

      if (acceleration > shakeThreshold * shakeThreshold) {
        onShake();
      }
    });
  }
}
