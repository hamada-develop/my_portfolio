import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(const ThemeState(themeMode: ThemeMode.dark));

  void toggleTheme() {
    final newMode =
        state.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    emit(ThemeState(themeMode: newMode));
  }

  void setTheme(ThemeMode mode) {
    if (state.themeMode != mode) {
      emit(ThemeState(themeMode: mode));
    }
  }

  bool get isDark => state.themeMode == ThemeMode.dark;
}
