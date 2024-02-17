// ignore_for_file: one_member_abstracts

// generate code with: dart run pigeon --input pigeons/contacts_api.dart

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/api/contacts_api.dart',
    swiftOut: 'ios/Runner/ContactsApi.swift',
    swiftOptions: SwiftOptions(),
  ),
)
@HostApi()
abstract class ContactsApi {
  List<String> getContacts();
}
