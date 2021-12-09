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
  bool submitEnabled = false;
  bool isLoading = false;

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
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          children: [
            const Spacer(flex: 3),
            Text(
              'Clarity',
              style: theme.textTheme.headline3,
            ),
            const Spacer(flex: 2),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Войдите в аккаунт:',
                style: theme.textTheme.bodyText2,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _loginController,
              onChanged: _onChanged,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(hintText: 'Логин'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              onChanged: _onChanged,
              textInputAction: TextInputAction.done,
              onEditingComplete: submitEnabled ? _onSubmit : null,
              decoration: const InputDecoration(hintText: 'Пароль'),
            ),
            if (authState?.error != null) ...[
              const SizedBox(height: 16),
              Text(authState!.error!),
            ],
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: submitEnabled ? _onSubmit : null,
              child: isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator.adaptive(
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Войти'),
            ),
            const Spacer(flex: 4),
          ],
        ),
      ),
    );
  }

  void _onSubmit() async {
    setState(() {
      isLoading = true;
    });
    await authState?.login(
        login: _loginController.text, password: _passwordController.text);
  }

  void _onAuthStateChange() {
    if (authState?.user != null || authState?.error != null) {
      setState(() {
        isLoading = false;
      });
    }
    if (authState?.isLoggedIn ?? false) {
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    }
  }

  void _onChanged(String value) {
    final valid =
        _loginController.text.isNotEmpty && _passwordController.text.isNotEmpty;
    if (valid != submitEnabled) {
      setState(() {
        submitEnabled = valid;
      });
    }
  }
}
