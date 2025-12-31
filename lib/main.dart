import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/cubit_observer.dart';

void main() {
  Bloc.observer = CubitObserver();
  runApp(const MyApp());
}