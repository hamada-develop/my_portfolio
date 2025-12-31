import 'package:book/presentation/controller/home_cubit.dart';
import 'package:book/presentation/screens/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: MaterialApp(
        title: 'Portfolio',
        theme: ThemeData(colorScheme: MaterialTheme.darkScheme()),
        debugShowCheckedModeBanner: false,
        home: HomeView(),
      ),
    );
  }
}
