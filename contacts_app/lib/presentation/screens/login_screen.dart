import 'package:contacts_app/data/local_users_repository.dart';
import 'package:contacts_app/domain/models/user.dart';
import 'package:contacts_app/domain/repositories/users_repository.dart';
import 'package:contacts_app/main.dart';
import 'package:contacts_app/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatelessWidget {
  static const name = 'login_screen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: _LoginView(),
    );
  }
}

class _LoginView extends StatelessWidget {
  _LoginView() {
    _existingUsers = _usersRepository.getUsers();
  }

  late final Future<List<User>> _existingUsers;

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final UsersRepository _usersRepository = LocalUsersRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  )),
              const SizedBox(height: 20),
              TextFormField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  )),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    _login(context, usernameController.text,
                        passwordController.text);
                  },
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _login(BuildContext context, username, String password) async {
    try {
      final List<User> userPool = await _existingUsers;
      final User user = userPool.firstWhere(
          (user) => user.username == username && user.password == password,
          orElse: () => throw Exception('User not found'));

      await _saveSessionCredentials(user.id, user.username);
      if (context.mounted) context.pushReplacementNamed(HomeScreen.name);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(
              content: Text('Invalid credentials'),
              duration: Duration(milliseconds: 500),
            ))
            .closed
            .then((value) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
          }
        });
      }
    }
  }

  _saveSessionCredentials(int id, String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setString('user_id', id.toString());
    await prefs.setString('username', username);

    sessionUserId = id.toString();
    sessionUsername = username;
  }
}
