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
  List<String>? _contacts;

  Future<void> _getContacts() async {
    final result = await platform.invokeListMethod<String>('getContacts');
    setState(() {
      _contacts = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: _getContacts,
                child: const Text('Get contacts'),
              ),
              ...(_contacts ?? []).map(
                (e) => ListTile(
                  title: Text(e),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
