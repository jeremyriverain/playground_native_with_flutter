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

  Future<List<String>?> _getContacts() {
    return platform.invokeListMethod<String>('getContacts');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getContacts(),
      builder: (context, snapshot) {
        final data = snapshot.data;
        if (data == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemBuilder: (context, index) => ListTile(
            title: Text(data[index]),
          ),
          itemCount: data.length,
        );
      },
    );
  }
}
