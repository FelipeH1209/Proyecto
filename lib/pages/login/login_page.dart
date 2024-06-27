import 'package:flutter/material.dart';
import 'package:flutter_application_ganaderia/database/localDb.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = '', _password = '';

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
            const SizedBox(
              height: 30,
            ),
            Builder(builder: (context) {
              return ElevatedButton(
                onPressed: () async {
                  await LocalDatabase().addDataLocally(Name: _email);
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
            })
          ],
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    final formState = context.findAncestorStateOfType<FormState>();
    print(formState);

    // if (_formKey.currentState!.validate()) {
    //   // send form request
    // }
  }
}
