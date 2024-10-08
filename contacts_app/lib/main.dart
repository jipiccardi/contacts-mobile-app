import 'dart:developer';

import 'package:contacts_app/config/database/database.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/config/router/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:contacts_app/config/theme/theme_provider.dart';

late AppDatabase database;

String sessionUserId = '';
String sessionUsername = '';

void main() async {
  // Ensure that the binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database and measure initialization time
  final stopwatch = Stopwatch()..start();
  database = await AppDatabase.create('app_database.db');
  stopwatch.stop();
  log('Database initialized in ${stopwatch.elapsed.inMilliseconds}ms');

  await _loadSession();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);

    return MaterialApp.router(
      title: 'Contacts',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          useMaterial3: true,
          brightness: isDarkMode ? Brightness.dark : Brightness.light),
    );
  }
}

Future<void> _loadSession() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  sessionUserId = prefs.getString('user_id') ?? '';
  sessionUsername = prefs.getString('username') ?? '';
  return;
}
