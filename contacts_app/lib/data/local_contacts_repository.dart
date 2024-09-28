import '../main.dart';

import 'package:contacts_app/data/contacts_dao.dart';
import 'package:contacts_app/domain/models/contact.dart';
import 'package:contacts_app/domain/repositories/contacts_repository.dart';

class LocalContactsRepository implements ContactsRepository {
  final ContactsDao _contactsDao = database.contactDao;

  @override
  Future<List<Contact>> getContacts() {
    return _contactsDao.findAllContacts();
  }
}