import 'package:floor/floor.dart';

@entity
class User {
  @primaryKey
  final int id;
  final String username;
  final String password;

  User({
    required this.id,
    required this.username,
    required this.password
  });
}