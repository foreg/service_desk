import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:service_desk/auth/auth_repository.dart';
import 'package:service_desk/auth/user.dart';

class AuthState extends ChangeNotifier {
  AuthState(this._authRepository) {
    _eventsSubscription = _authRepository.events.listen(_onAuthEvent);
  }

  final AuthRepository _authRepository;
  late final StreamSubscription _eventsSubscription;
  User? _user;
  String? _error;

  User? get user => _user;
  String? get error => _error;

  bool get isLoggedIn => _user != null;

  Future<void> login({required String login, required String password}) {
    _updateState(user: null, error: null);
    return _authRepository.login(login: login, password: password);
  }

  void _onAuthEvent(AuthEvent event) {
    if (event is SuccessfullAuthEvent) {
      _updateState(user: event.user, error: null);
    } else if (event is FailureAuthEvent) {
      _updateState(user: null, error: event.error);
    } else if (event is LogoutAuthEvent) {
      _updateState(user: null, error: null);
    }
  }

  Future<void> logout() {
    return _authRepository.logout();
  }

  void _updateState({User? user, String? error}) {
    _user = user;
    _error = error;
    notifyListeners();
  }

  @override
  void dispose() {
    _eventsSubscription.cancel();
    super.dispose();
  }
}
