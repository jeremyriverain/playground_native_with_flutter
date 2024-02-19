import 'package:flutter/material.dart';
import 'package:playgroundnative/api/contacts_api.dart';

class PigeonView extends StatefulWidget {
  const PigeonView({super.key});

  @override
  State<PigeonView> createState() => _PigeonViewState();
}

class _PigeonViewState extends State<PigeonView> {
  var _contacts = <String?>[];

  Future<void> _getContacts() async {
    final api = ContactsApi();
    final contacts = await api.getContacts();
    setState(() {
      _contacts = contacts;
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
          ..._contacts.map((m) => ListTile(title: Text(m ?? ''))),
        ],
      ),
    );
  }
}
