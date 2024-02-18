import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:playgroundnative/ffi/libhello_generated_bindings.dart'
    as hello_lib;

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
    final helloNative = DynamicLibrary.process();
    hello = hello_lib.hello(helloNative);
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
