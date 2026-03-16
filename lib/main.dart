import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/cubit_observer.dart';
import 'core/widgets/loading_skeleton.dart';

void main() {
  Bloc.observer = CubitObserver();
  runApp(const _AppEntry());
}

/// Entry point that shows a loading bar while assets initialize,
/// then transitions to the main app.
class _AppEntry extends StatefulWidget {
  const _AppEntry();

  @override
  State<_AppEntry> createState() => _AppEntryState();
}

class _AppEntryState extends State<_AppEntry> {
  bool _isReady = false;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (mounted) {
      setState(() => _isReady = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: _isReady ? const MyApp() : const _LoadingApp(),
    );
  }
}

/// Minimal MaterialApp wrapper for the loading screen.
class _LoadingApp extends StatelessWidget {
  const _LoadingApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const LoadingScreen(),
    );
  }
}