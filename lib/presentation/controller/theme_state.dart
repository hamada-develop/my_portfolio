part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  final ThemeMode themeMode;

  const ThemeState({required this.themeMode});

  bool get isDark => themeMode == ThemeMode.dark;

  @override
  List<Object?> get props => [themeMode];
}
