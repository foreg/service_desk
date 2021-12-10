import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_desk/auth/auth_page.dart';
import 'package:service_desk/auth/auth_state.dart';
import 'package:service_desk/home/ticket_mock.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = 'home';

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  AuthState? authState;

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
      appBar: AppBar(
        title: const Text('Ваши заявки'),
        actions: [
          IconButton(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: ticketsMock.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () => {},
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 33),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                Text(
                  ticketsMock[index].address.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.black54,
                    letterSpacing: 1.5,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  ticketsMock[index].title,
                  style: const TextStyle(color: Colors.black, fontSize: 16),
                ),
                const SizedBox(height: 2),
                Text(
                  ticketsMock[index].description,
                  style: const TextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(height: 15),
                const Divider(height: 1, thickness: 1),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onAddTap,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onAuthStateChange() {
    if (!(authState?.isLoggedIn ?? true)) {
      Navigator.of(context).pushReplacementNamed(AuthPage.routeName);
    }
  }

  void _onAddTap() {
    Navigator.pushNamed(context, 'add_request');
  }

  void _logout() {
    authState?.logout();
  }
}
