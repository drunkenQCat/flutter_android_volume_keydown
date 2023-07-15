import 'dart:async';

import 'package:flutter/services.dart';

class FlutterAndroidVolumeKeydown {
  static const EventChannel _channel =
      EventChannel('dart-tools.dev/flutter_android_volume_keydown');
  static Stream<HardwareButton> stream = _channel
      .receiveBroadcastStream()
      .cast<int>()
      .map((event) {
        switch (event) {
          case 0: return HardwareButton.volume_down;
          case 1: return HardwareButton.volume_up;
          case 2: return HardwareButton.power; 
          case 3: return HardwareButton.volume_down_long;
          case 4: return HardwareButton.volume_down_double;
          default:return HardwareButton.others;
        }
      });
}

enum HardwareButton { volume_up, volume_down, power, volume_down_long, volume_down_double, others }
