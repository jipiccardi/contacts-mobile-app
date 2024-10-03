import 'package:contacts_app/domain/models/contact.dart';

abstract class ContactsRepository {
  Future<List<Contact>> getContacts();
  Future<Contact> getById(int id);

  Future<void> insertContact(Contact contact);

  Future<void> updateContact(Contact contact);

  Future<void> deleteContact(Contact contact);
}