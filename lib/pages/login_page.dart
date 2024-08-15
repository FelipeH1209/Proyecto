import 'package:flutter/material.dart';
import 'package:flutter_application_ganaderia/database/localDb.dart';
import 'package:flutter_application_ganaderia/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

// de esta manera se refactoriza el menu page para que tenga rutas creadas a partir de una clase
class PageData {
  final String name;
  final String label;
  final Object?
      arguments; // con el interrogante permite crear instancias de una clase y este atributo puede ser nulo o no
  final void Function(Object?)? onResult;

  PageData({
    required this.name,
    required this.label,
    this.arguments,
    this.onResult,
  });
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final List<PageData> _pages;
  String _email = '', _password = '';
  bool _password_incorrect = false;

  @override
  void initState() {
    super.initState();
    _pages = [
      PageData(
        name: Routes.home,
        label: 'Go menu',
        arguments: _email,
      ),
    ];
    _password_incorrect = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              "Aplicación ganadería",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 50),
            Center(
              child: Container(
                width: 170,
                height: 170,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  'assets/images/logo_login.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 50),
            TextFormField(
              key: const Key('login-email'),
              onChanged: (text) {
                _email = text.trim();
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                label: Text('Email'),
              ),
              validator: (text) {
                text = text ?? '';
                final isValid = RegExp(
                        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                    .hasMatch(text);
                if (isValid) {
                  return null;
                }
                return 'Invalid email';
              },
            ),
            SizedBox(height: 30),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: const Key('login-pass'),
              onChanged: (value) {
                _password = value.replaceAll(' ', '');
              },
              obscureText: true,
              decoration: const InputDecoration(
                label: Text('Contraseña'),
              ),
              validator: (value) {
                value = value ?? '';
                if (value.length >= 8) {
                  return null;
                }
                return 'Invalid password';
              },
            ),
            _password_incorrect == true
                ? Center(
                    child: const Text(
                      "Password incorrecto",
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                : const Text(''),
            const SizedBox(
              height: 30,
            ),
            Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  final data = _pages[0];
                  final validateUser = await LocalDatabase()
                      .readUser(email: _email, password: _password);
                  if (!validateUser.isEmpty) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.setString(
                        'auth_token', 'mi_token_de_autenticacion');
                    final result = await Navigator.pushNamed(
                      context,
                      data.name,
                      arguments: validateUser,
                    );
                    if (data.onResult != null) {
                      data.onResult!(result);
                    }
                  } else {
                    _password_incorrect = true;
                    setState(() {});
                  }
                },
                child: const Text(
                  'Ingresar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo.shade400,
                  elevation: 10,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
