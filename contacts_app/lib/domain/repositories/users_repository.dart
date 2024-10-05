import 'package:contacts_app/domain/models/user.dart';

abstract class UsersRepository {
  Future<List<User>> getUsers();
  Future<User> getUserById(int id);
}