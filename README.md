# Native playground with Flutter

This repo showcases differents mechanisms provided by Flutter to interact with native platforms.

You'll find demos of:

- [MethodChannel](https://api.flutter.dev/flutter/services/MethodChannel-class.html)
- [EventChannel](https://api.flutter.dev/flutter/services/EventChannel-class.html)
- [Pigeon](https://pub.dev/packages/pigeon)
- [FFI](https://dart.dev/interop/c-interop) with [ffigen](https://pub.dev/packages/ffigen)

iOS and Android only.

## Installation

Ensure your Flutter configuration is OK:

```bash 
flutter doctor
```

Install the dependencies:

```bash
dart pub global activate melos
flutter pub get
melos bootstrap
```

Launch an Android or iOS emulator (or plug a physical device). Then, start the app:

```bash
cd app
flutter run
```