import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../data/contacts_dao.dart';
import '../../domain/models/contact.dart';

part 'database.g.dart';

@Database(
  version: 1,
  entities: [Contact],
)
abstract class  AppDatabase extends FloorDatabase {
  ContactsDao get contactDao;

  static Future<AppDatabase> create(String name){
        return $FloorAppDatabase.databaseBuilder(name).addCallback(
      Callback(
        onCreate: (database, version) async {
          // This method is only called when the database is first created.
          //await _prepopulateDb(database);
        },
      ),
    ).build();
  }
}