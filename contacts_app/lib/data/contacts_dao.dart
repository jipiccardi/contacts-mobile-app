import 'package:floor/floor.dart';

import '../domain/models/contact.dart';

@dao
abstract class ContactsDao {
  @Query('SELECT * FROM Contact')
  Future<List<Contact>> findAllContacts();
}