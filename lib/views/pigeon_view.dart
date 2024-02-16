import 'package:flutter/material.dart';
import 'package:playgroundnative/api/example_api.dart';

class PigeonView extends StatelessWidget {
  const PigeonView({super.key});

  Future<String> getPlatformVersion() {
    final api = ExampleApi();
    return api.getPlatformVersion();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: getPlatformVersion(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data == null) {
            return const CircularProgressIndicator();
          }
          return Text(
            'version: ${snapshot.data}',
            style: Theme.of(context).textTheme.headlineMedium,
          );
        },
      ),
    );
  }
}
