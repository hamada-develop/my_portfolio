import 'package:book/core/theme.dart';
import 'package:book/view/home_view2.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: MaterialTheme.darkScheme()
      ),
      home: const HomeView2(),
    );
  }
}
