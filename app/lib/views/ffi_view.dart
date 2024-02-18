import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plugin_ffi/plugin_ffi.dart' as plugin_ffi;

class FfiView extends StatefulWidget {
  const FfiView({super.key});

  @override
  State<FfiView> createState() => _FfiViewState();
}

class _FfiViewState extends State<FfiView> {
  late int sumResult;
  late Future<int> sumAsyncResult;

  @override
  void initState() {
    super.initState();
    sumResult = plugin_ffi.sum(1, 2);
    sumAsyncResult = plugin_ffi.sumAsync(3, 4);
  }

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 25);
    const spacerSmall = SizedBox(height: 10);
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text(
            'This calls a native function through FFI that is shipped as source in the package. '
            'The native code is built as part of the Flutter Runner build.',
            style: textStyle,
            textAlign: TextAlign.center,
          ),
          spacerSmall,
          Text(
            'sum(1, 2) = $sumResult',
            style: textStyle,
            textAlign: TextAlign.center,
          ),
          spacerSmall,
          FutureBuilder<int>(
            future: sumAsyncResult,
            builder: (BuildContext context, AsyncSnapshot<int> value) {
              final displayValue = (value.hasData) ? value.data : 'loading';
              return Text(
                'await sumAsync(3, 4) = $displayValue',
                style: textStyle,
                textAlign: TextAlign.center,
              );
            },
          ),
        ],
      ),
    );
  }
}
