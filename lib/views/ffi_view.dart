import 'package:batterylevel/ffi_loader.dart';
import 'package:flutter/material.dart';

class FfiView extends StatelessWidget {
  FfiView({
    super.key,
  });

  final jsonLoader = MyNativeCJson(pathToJson: 'example.json');

  Future<dynamic> loadJson() {
    return jsonLoader.load();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadJson(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'JSON parsed with native library:',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    snapshot.data.toString(),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
