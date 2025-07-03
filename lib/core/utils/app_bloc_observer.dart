import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    debugPrint('\x1B[32m[BLOC CREATED]\x1B[0m \x1B[32m${bloc.runtimeType}\x1B[0m');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    debugPrint('\x1B[31m[BLOC CLOSED]\x1B[0m --> \x1B[31m${bloc.runtimeType}\x1B[0m');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('\x1B[33m[BLOC STATE CHANGED]\x1B[0m --> \x1B[33m${bloc.runtimeType}: $change\x1B[0m');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debugPrint('\x1B[33m[BLOC ERROR]\x1B[0m --> \x1B[33m${bloc.runtimeType}: $error\x1B[0m');
  }
}
