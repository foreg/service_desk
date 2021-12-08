import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_desk/auth/auth_state.dart';
import 'package:service_desk/home/home_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  static const routeName = 'auth';

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();
  AuthState? authState;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    authState ??= Provider.of<AuthState>(context)
      ..addListener(_onAuthStateChange);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    authState?.removeListener(_onAuthStateChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _loginController),
            TextField(controller: _passwordController),
            if (authState?.error != null) Text(authState!.error!),
            ElevatedButton(
              onPressed: _onSubmit,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }

  void _onSubmit() {
    authState?.login(
        login: _loginController.text, password: _passwordController.text);
  }

  void _onAuthStateChange() {
    if (authState?.isLoggedIn ?? false) {
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    }
  }
}
