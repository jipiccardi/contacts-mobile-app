import '../main.dart';

import 'package:contacts_app/data/users_dao.dart';
import 'package:contacts_app/domain/models/user.dart';
import 'package:contacts_app/domain/repositories/users_repository.dart';

class LocalUsersRepository implements UsersRepository {
  final UsersDao _usersDao = database.userDao;

  @override
  Future<List<User>> getUsers() {
    return _usersDao.findAllUsers();
  }

  @override
  Future<User> getUserById(int id) {
    return _usersDao.findUserById(id).then((contact) => contact!);
  }
}
