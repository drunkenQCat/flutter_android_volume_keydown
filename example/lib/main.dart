import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_android_volume_keydown/flutter_android_volume_keydown.dart';

void main() {
  runApp(MyHomePage());
}


class EventStream {
  final StreamController<String> _streamController = StreamController<String>();

  Stream<String> get stream => _streamController.stream;

  void sendEvent(String eventText) {
    _streamController.sink.add(eventText);
  }

  void dispose() {
    _streamController.close();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  EventStream eventStream = EventStream();
  StreamSubscription<HardwareButton>? subscription;

  @override
  void initState() {
    super.initState();
    startListening();
  }

  @override
  void dispose() {
    subscription?.cancel();
    eventStream.dispose();
    super.dispose();
  }

  void startListening() {
    subscription = FlutterAndroidVolumeKeydown.stream.listen((event) {
      if (event == HardwareButton.volume_down) {
        eventStream.sendEvent("Volume down received");
      } else if (event == HardwareButton.volume_up) {
        eventStream.sendEvent("Volume up received");
      } else if (event == HardwareButton.power) {
        eventStream.sendEvent("Power button received");
      } else if (event == HardwareButton.volume_down_long) {
        eventStream.sendEvent("Long press on volume down received");
      } else if (event == HardwareButton.volume_down_double) {
        eventStream.sendEvent("Double press on volume down received");
      } else {
        eventStream.sendEvent("Other hardware button received");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Stream Example'),
      ),
      body: Center(
        child: StreamBuilder<String>(
          stream: eventStream.stream,
          initialData: 'Waiting for physical key ...',
          builder: (context, snapshot) {
            return Text(snapshot.data!);
          },
        ),
      ),
    );
  }
}