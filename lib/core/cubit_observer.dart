import 'package:flutter_bloc/flutter_bloc.dart';

class CubitObserver extends BlocObserver {
  void _log(String message) {
    // You can replace print with debugPrint if you want
    print(message);
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _log(
      '''
══════════════════════════════════════
🟢 CREATED
📦 Cubit: ${bloc.runtimeType}
══════════════════════════════════════
''',
    );
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _log(
      '''
──────────────────────────────────────
🔄 STATE CHANGE
📦 Cubit : ${bloc.runtimeType}
⬅️ From : ${change.currentState}
➡️ To   : ${change.nextState}
──────────────────────────────────────
''',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _log(
      '''
❌ ERROR
📦 Cubit: ${bloc.runtimeType}
💥 Error: $error
🧵 StackTrace:
$stackTrace
''',
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    _log(
      '''
🔴 CLOSED
📦 Cubit: ${bloc.runtimeType}
══════════════════════════════════════
''',
    );
  }
}
