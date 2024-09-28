import 'dart:developer';

import 'package:contacts_app/config/database/database.dart';
import 'package:flutter/material.dart';
import 'package:contacts_app/config/router/app_router.dart';

late AppDatabase database;

void main() async{
  // Ensure that the binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database and measure initialization time
  final stopwatch = Stopwatch()..start();
  database = await AppDatabase.create('app_database.db');
  stopwatch.stop();
  log('Database initialized in ${stopwatch.elapsed.inMilliseconds}ms');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Contacts',
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.grey,
        brightness: Brightness.light
      ),
    );
  }
}
