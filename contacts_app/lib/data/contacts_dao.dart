import 'package:floor/floor.dart';

import '../domain/models/contact.dart';

@dao
abstract class ContactsDao {
  @Query('SELECT * FROM Contact')
  Future<List<Contact>> findAllContacts();

  @Query('SELECT * FROM Contact WHERE id = :id')
  Future<Contact?> findContactById(int id);

  @insert
  Future<void> insertContact(Contact contact);

  @update
  Future<void> updateContact(Contact contact);

  @delete
  Future<void> deleteContact(Contact contact);
}