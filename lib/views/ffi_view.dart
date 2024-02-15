import 'dart:ffi';
import 'dart:io';

import 'package:playgroundnative/ffi/libhello_generated_bindings.dart'
    as hello_lib;
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';

class FfiView extends StatefulWidget {
  const FfiView({
    super.key,
  });

  @override
  State<FfiView> createState() => _FfiViewState();
}

class _FfiViewState extends State<FfiView> {
  late hello_lib.hello hello;

  @override
  void initState() {
    super.initState();
    final cJSONNative = Platform.isAndroid
        ? DynamicLibrary.open('libhello.so')
        : DynamicLibrary.process();
    hello = hello_lib.hello(cJSONNative);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'hello world from C library:',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              hello
                  .helloWorld('ffi'.toNativeUtf8().cast<Char>())
                  .cast<Utf8>()
                  .toDartString(),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}
