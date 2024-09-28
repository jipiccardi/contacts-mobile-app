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
          await _prepopulateDb(database);
        },
      ),
    ).build();
  }


// TODO delete this prepopulation
static Future<void> _prepopulateDb(sqflite.DatabaseExecutor database) async {
  List<Contact> contacts = [
      Contact(id: 1, name: 'John', phoneNumber: '874562319', userId: 1),
      Contact(id: 2, name: 'Karen', phoneNumber: '954312869', userId: 1),
      Contact(id: 3, name: 'Liam', phoneNumber: '758461203', userId: 1),
      Contact(id: 4, name: 'Diana', phoneNumber: '154638207', userId: 1),
      Contact(id: 5, name: 'Chris', phoneNumber: '648517920', userId: 1),
      Contact(id: 6, name: 'Alice', phoneNumber: '253649807', userId: 1),
      Contact(id: 7, name: 'Bob', phoneNumber: '965482130', userId: 1),
      Contact(id: 8, name: 'Grace', phoneNumber: '365489701', userId: 1),
      Contact(id: 9, name: 'Steve', phoneNumber: '472936581', userId: 1),
      Contact(id: 10, name: 'Mia', phoneNumber: '586493702', userId: 1),
      Contact(id: 11, name: 'Jack', phoneNumber: '794652310', userId: 1),
      Contact(id: 12, name: 'Leo', phoneNumber: '851764203', userId: 1),
      Contact(id: 13, name: 'Paul', phoneNumber: '284635107', userId: 1),
      Contact(id: 14, name: 'Wendy', phoneNumber: '165739402', userId: 1),
      Contact(id: 15, name: 'Victor', phoneNumber: '734295816', userId: 1),
      Contact(id: 16, name: 'Tina', phoneNumber: '482596371', userId: 1),
      Contact(id: 17, name: 'Quincy', phoneNumber: '503176894', userId: 1),
      Contact(id: 18, name: 'Rita', phoneNumber: '258973164', userId: 1),
      Contact(id: 19, name: 'Olivia', phoneNumber: '726598304', userId: 1),
      Contact(id: 20, name: 'Frank', phoneNumber: '392761508', userId: 1),
      Contact(id: 21, name: 'Hank', phoneNumber: '184635972', userId: 1),
      Contact(id: 22, name: 'Isabella', phoneNumber: '523789160', userId: 1),
      Contact(id: 23, name: 'Noah', phoneNumber: '905876321', userId: 1),
      Contact(id: 24, name: 'Jane', phoneNumber: '136258479', userId: 1),
      Contact(id: 25, name: 'Ella', phoneNumber: '276153948', userId: 1),
      Contact(id: 26, name: 'Zane', phoneNumber: '402759318', userId: 1),
      Contact(id: 27, name: 'Eve', phoneNumber: '148596273', userId: 1),
      Contact(id: 28, name: 'Xander', phoneNumber: '903258471', userId: 1),
      Contact(id: 29, name: 'Yara', phoneNumber: '714895623', userId: 1),
      Contact(id: 30, name: 'Uma', phoneNumber: '935872640', userId: 1),
      Contact(id: 31, name: 'Nacho', phoneNumber: '523984716', userId: 1),
      Contact(id: 32, name: 'Alice', phoneNumber: '849275136', userId: 1),
      Contact(id: 33, name: 'Liam', phoneNumber: '753896241', userId: 1),
      Contact(id: 34, name: 'Paul', phoneNumber: '295381764', userId: 1),
      Contact(id: 35, name: 'Mia', phoneNumber: '683512490', userId: 1),
      Contact(id: 36, name: 'Steve', phoneNumber: '704129836', userId: 1),
      Contact(id: 37, name: 'Jack', phoneNumber: '485261739', userId: 1),
      Contact(id: 38, name: 'Karen', phoneNumber: '593186472', userId: 1),
      Contact(id: 39, name: 'Chris', phoneNumber: '679215384', userId: 1),
      Contact(id: 40, name: 'Diana', phoneNumber: '239684517', userId: 1),
      Contact(id: 41, name: 'Grace', phoneNumber: '571623894', userId: 1),
      Contact(id: 42, name: 'Victor', phoneNumber: '184639572', userId: 1),
      Contact(id: 43, name: 'Rita', phoneNumber: '958231470', userId: 1),
      Contact(id: 44, name: 'Frank', phoneNumber: '672459813', userId: 1),
      Contact(id: 45, name: 'Uma', phoneNumber: '736549182', userId: 1),
      Contact(id: 46, name: 'Wendy', phoneNumber: '512934687', userId: 1),
      Contact(id: 47, name: 'Yara', phoneNumber: '128345769', userId: 1),
      Contact(id: 48, name: 'Noah', phoneNumber: '905612738', userId: 1),
      Contact(id: 49, name: 'Bob', phoneNumber: '278456193', userId: 1),
      Contact(id: 50, name: 'Leo', phoneNumber: '398245176', userId: 1),
  ];


  for (final contact in contacts) {
    await InsertionAdapter(
      database,
      'Contact',
      (Contact item) => <String, Object?>{
        'id': item.id,
        'name': item.name,
        'lastname': item.lastname,
        'phoneNumber': item.phoneNumber,
        'img': item.img,
        'email': item.email,
        'notes': item.notes,
        'userId': item.userId,
      },
     ).insert(contact, OnConflictStrategy.replace);
    }
  }
  
}