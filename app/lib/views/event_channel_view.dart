import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EventChannelView extends StatelessWidget {
  const EventChannelView({super.key});

  static const eventChannel = EventChannel('flutter.demo/timer');

  Stream<String> streamTimeFromNative() {
    return eventChannel
        .receiveBroadcastStream()
        .map((event) => event.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder<String>(
        stream: streamTimeFromNative(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              '${snapshot.data}',
              style: Theme.of(context).textTheme.headlineMedium,
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
