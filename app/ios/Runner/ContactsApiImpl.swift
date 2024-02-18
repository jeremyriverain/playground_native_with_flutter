import Flutter
import Contacts

extension FlutterError: Error {}


class ContactsApiImpl: ContactsApi {
  func getContacts() throws -> [String] {
      let contactStore = CNContactStore()
        var contactsArray: [String] = []
        
        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]

        do {
            try contactStore.enumerateContacts(with: CNContactFetchRequest(keysToFetch: keysToFetch)) {
                (contact, cursor) -> Void in
                let fullName = CNContactFormatter.string(from: contact, style: .fullName) ?? ""
                contactsArray.append(fullName)
            }
            return contactsArray
        } catch {
            throw FlutterError(code: "Failed to fetch contacts",
                                 message: error.localizedDescription,
                                 details: nil)
        }
  }
}
