import 'dart:async';

import 'package:flutter/foundation.dart';
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

  final fibonacciInput = 40;

  @override
  void initState() {
    super.initState();
    sumResult = plugin_ffi.sum(1, 2);
    sumAsyncResult = plugin_ffi.fibonacci(fibonacciInput);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'sum(1, 2) = $sumResult',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 60,
          ),
          FutureBuilder<int>(
            future: sumAsyncResult,
            builder: (BuildContext context, AsyncSnapshot<int> value) {
              final data = value.data;
              if (value.hasError) {
                if (kDebugMode) {
                  print(value.error);
                }
                return const Text('An error occured');
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'await fibonacci($fibonacciInput) =',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  if (data == null)
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                        ],
                      ),
                    )
                  else
                    Text(
                      data.toString(),
                      style: Theme.of(context).textTheme.headlineMedium,
                      textAlign: TextAlign.center,
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
