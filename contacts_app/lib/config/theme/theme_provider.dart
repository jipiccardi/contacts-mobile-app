import 'package:flutter_riverpod/flutter_riverpod.dart';

class DarkModeNotifier extends StateNotifier<bool> {
  DarkModeNotifier() : super(false);

  void toggleDarkMode() {
    state = !state;
  }
}

final darkModeProvider = StateNotifierProvider<DarkModeNotifier, bool>((ref) {
  return DarkModeNotifier();
});
