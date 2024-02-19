import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MethodChannelView extends StatefulWidget {
  const MethodChannelView({
    super.key,
  });

  @override
  State<MethodChannelView> createState() => _MethodChannelViewState();
}

class _MethodChannelViewState extends State<MethodChannelView> {
  static const platform = MethodChannel('flutter.demo/contacts');

  var _contacts = <String>[];

  Future<void> _getContacts() async {
    final contacts = await platform.invokeListMethod<String>('getContacts');
    setState(() {
      _contacts = contacts ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: ElevatedButton(
                onPressed: _getContacts,
                child: const Text('List contacts'),
              ),
            ),
          ),
          ..._contacts.map((m) => ListTile(title: Text(m))),
        ],
      ),
    );
  }
}
