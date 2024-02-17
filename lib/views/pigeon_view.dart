import 'package:flutter/material.dart';
import 'package:playgroundnative/api/contacts_api.dart';

class PigeonView extends StatelessWidget {
  const PigeonView({super.key});

  Future<List<String?>?> _getContacts() {
    final api = ContactsApi();
    return api.getContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: _getContacts(),
        builder: (context, snapshot) {
          final data = snapshot.data;
          if (data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemBuilder: (context, index) => ListTile(
              title: Text(data[index] ?? ''),
            ),
            itemCount: data.length,
          );
        },
      ),
    );
  }
}
