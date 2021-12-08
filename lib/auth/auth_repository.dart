import 'dart:async';

import 'package:service_desk/auth/user.dart';
import 'package:service_desk/core/api_manager.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class SuccessfullAuthEvent extends AuthEvent {
  const SuccessfullAuthEvent(this.user);

  final User user;
}

class FailureAuthEvent extends AuthEvent {
  const FailureAuthEvent(this.error);

  final String error;
}

class AuthRepository {
  final _controller = StreamController<AuthEvent>();
  final _api = APIManager();

  Stream<AuthEvent> get events => _controller.stream;

  Future<void> login({required String login, required String password}) async {
    final response = await _api.login(login: login, password: password);

    if (response.containsKey('userId')) {
      _controller.add(SuccessfullAuthEvent(User(userId: response['userId'])));
    } else {
      _controller.add(const FailureAuthEvent('An error has occurred'));
    }
  }

  void dispose() {
    _controller.close();
  }
}
