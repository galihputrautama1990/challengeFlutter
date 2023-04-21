import 'dart:async';

import 'package:flutter_training/services/auth_service.dart';
import 'package:flutter_training/sources/network_source.dart';
import 'package:flutter_training/utils/wrapper.dart';

// enum LoginState { init, loading, success, failure }

abstract class LoginState {}

class LoginInit implements LoginState {}

class LoginError implements LoginState {
  final String message;

  LoginError(this.message);
}

class LoginSuccess implements LoginState {}

class LoginLoading implements LoginState {}

class LoginBloc {
  LoginBloc() {
    _state.sink.add(LoginInit());
  }

  final _state = StreamController<LoginState>();
  Stream<LoginState> get state => _state.stream;

  Future<void> login(Map<String, dynamic> payload) async {
    _state.sink.add(LoginLoading());
    try {
      await AuthService(NetworkSource.dio()).doLogin(payload);
      _state.sink.add(LoginSuccess());
    } catch (e) {
      _state.sink.add(LoginError(e.toString()));
    }
  }
}
