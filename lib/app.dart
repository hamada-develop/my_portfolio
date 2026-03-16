import 'package:book/presentation/controller/home_cubit.dart';
import 'package:book/presentation/controller/theme_cubit.dart';
import 'package:book/presentation/screens/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'Hamada Mohamed Seif | Portfolio',
            theme: ThemeData(colorScheme: MaterialTheme.lightScheme()),
            darkTheme: ThemeData(colorScheme: MaterialTheme.darkScheme()),
            themeMode: themeState.themeMode,
            debugShowCheckedModeBanner: false,
            home: const HomeView(),
          );
        },
      ),
    );
  }
}
