import 'package:contacts_app/config/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  static const name = 'settings_screen';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final isDarkMode = ref.watch(darkModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Dark mode'),
            subtitle: const Text('Enable dark mode'),
            value: isDarkMode,
            onChanged: (value) {
              ref.read(darkModeProvider.notifier).toggleDarkMode();
            },
          )
        ],
      ),
    );
  }
}
