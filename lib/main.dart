import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_desk/auth/auth_page.dart';
import 'package:service_desk/auth/auth_repository.dart';
import 'package:service_desk/auth/auth_state.dart';
import 'package:service_desk/requests/add_request.dart';
import 'package:service_desk/core/notification_manager.dart';
import 'package:service_desk/core/api_manager.dart';
import 'package:service_desk/home/home_page.dart';
import 'package:service_desk/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationManager().init();
  await APIManager().init();

  final authRepository = AuthRepository();
  final authState = AuthState(authRepository);
  runApp(
    ChangeNotifierProvider.value(
      value: authState,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme,
      initialRoute: AuthPage.routeName,
      routes: {
        AuthPage.routeName: (context) => const AuthPage(),
        HomePage.routeName: (context) => const HomePage(),
        RequestPage.routeName: (context) => const RequestPage(),
      },
    );
  }
}
