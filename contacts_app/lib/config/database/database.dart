import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../data/contacts_dao.dart';
import '../../data/users_dao.dart';
import '../../domain/models/contact.dart';
import '../../domain/models/user.dart';

part 'database.g.dart';

@Database(version: 1, entities: [Contact, User])
abstract class AppDatabase extends FloorDatabase {
  ContactsDao get contactDao;
  UsersDao get userDao;

  static Future<AppDatabase> create(String name) {
    return $FloorAppDatabase.databaseBuilder(name).addCallback(
      Callback(
        onCreate: (database, version) async {
          // This method is only called when the database is first created.
          await _prepopulateDb(database);
        },
      ),
    ).build();
  }

  static Future<void> _prepopulateDb(sqflite.DatabaseExecutor database) async {
    List<User> users = [
      User(id: 1, username: 'nacho', password: 'asdasd'),
      User(id: 2, username: 'test', password: 'asdasd'),
      User(id: 3, username: 'usuario', password: 'asdasd')
    ];

    for (final user in users) {
      await InsertionAdapter(
        database,
        'User',
        (User item) => <String,Object?>{
          'id':item.id,
          'username':item.username,
          'password':item.password
        },
      ).insert(user, OnConflictStrategy.replace);
    }
  }
}
