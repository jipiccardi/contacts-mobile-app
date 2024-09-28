import 'package:contacts_app/domain/models/contact.dart';

abstract class ContactsRepository {
  Future<List<Contact>> getContacts();
}