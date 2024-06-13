import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Image.asset(
              'assets/images/vacas.jpg',
              height: 300,
            ),
            TextField(
              enableInteractiveSelection: false,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(labelText: "Nombre Usuario"),
            ),
            SizedBox(height: 30),
            TextField(
              obscureText: true,
              enableInteractiveSelection: false,
              decoration: InputDecoration(labelText: "Contraseña"),
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(onPressed: () {}, child: Text('Entrar')),
          ],
        ),
      ),
    );
  }
}
