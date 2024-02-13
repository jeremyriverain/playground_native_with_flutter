// ignore_for_file: one_member_abstracts

// generate code with: dart run pigeon --input pigeons/example_api.dart

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/api/example_api.dart',
    swiftOut: 'ios/Runner/ExampleApi.swift',
    swiftOptions: SwiftOptions(),
  ),
)
@HostApi()
abstract class ExampleApi {
  String getPlatformVersion();
}
