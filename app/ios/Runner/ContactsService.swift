import Flutter
import Contacts

class ContactsService {
    func fetchContacts(result: @escaping FlutterResult) {
         let contactStore = CNContactStore()
         var contactsArray: [String] = []
         
         let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]

         do {
             try contactStore.enumerateContacts(with: CNContactFetchRequest(keysToFetch: keysToFetch)) {
                 (contact, cursor) -> Void in
                 let fullName = CNContactFormatter.string(from: contact, style: .fullName) ?? ""
                 contactsArray.append(fullName)
             }
             result(contactsArray)
         } catch {
             result(FlutterError(code: "Failed to fetch contacts",
                                  message: error.localizedDescription,
                                  details: nil))
         }
     }
}
