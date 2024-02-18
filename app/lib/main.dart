import 'package:flutter/material.dart';
import 'package:playgroundnative/views/event_channel_view.dart';
import 'package:playgroundnative/views/ffi_view.dart';
import 'package:playgroundnative/views/method_channel_view.dart';
import 'package:playgroundnative/views/pigeon_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  final titles = [
    const Text('Method Chan.'),
    const Text('Event Channel'),
    const Text(
      'Pigeon',
    ),
    const Text(
      'FFI',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: titles[currentPageIndex],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) {
          setState(() {
            currentPageIndex = value;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: 'Method Channel',
          ),
          NavigationDestination(
            icon: Icon(Icons.stream),
            label: 'Event Channel',
          ),
          NavigationDestination(
            icon: Icon(Icons.airline_stops),
            label: 'Pigeon',
          ),
          NavigationDestination(
            icon: Icon(Icons.code),
            label: 'FFI',
          ),
        ],
      ),
      body: [
        const MethodChannelView(),
        const EventChannelView(),
        const PigeonView(),
        const FfiView(),
      ][currentPageIndex],
    );
  }
}
