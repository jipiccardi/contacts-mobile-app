import 'package:floor/floor.dart';

@entity
class Contact {
  @PrimaryKey(autoGenerate: true)
  int? id;

  final String name;
  final String? lastname;
  final String phoneNumber;
  final String? img;
  final String? email;
  final String? notes;
  final int userId;

  Contact({
    this.id,
    required this.name,
    this.lastname,
    required this.phoneNumber,
    this.img,
    this.email,
    this.notes,
    required this.userId
  });

  
}