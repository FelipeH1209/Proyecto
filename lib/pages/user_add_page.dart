import 'package:flutter/material.dart';
import 'package:flutter_application_ganaderia/database/localDb.dart';

class FormModal extends StatefulWidget {
  @override
  _FormModalState createState() => _FormModalState();
}

class _FormModalState extends State<FormModal> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _perfil = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Nombre'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese su nombre';
                }
                return null;
              },
              onSaved: (value) {
                _name = value ?? '';
              },
            ),
            // correo electronico
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
              onSaved: (value) {
                _email = value ?? '';
              },
            ),
            // perfiles
            DropdownButtonFormField<String>(
              decoration: InputDecoration(labelText: 'Perfil'),
              value: _perfil.isEmpty ? null : _perfil,
              items: ['Administrador', 'Operador']
                  .map((option) => DropdownMenuItem(
                        value: option,
                        child: Text(option),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _perfil = value ?? '';
                });
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, seleccione una opción';
                }
                return null;
              },
              onSaved: (value) {
                _perfil = value ?? '';
              },
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: const Key('user-pass'),
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
              onSaved: (value) {
                _password = value ?? '';
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState?.save();
                  Navigator.pop(context);
                  // Aquí puedes manejar los datos del formulario
                  await LocalDatabase().insertUser(
                      name: _name,
                      email: _email,
                      password: _password,
                      perfil: _perfil);
                  setState(() {});
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo.shade400,
                shadowColor: Colors.black, // Color de la sombra
                elevation: 5, // Elevación del botón
                padding: EdgeInsets.symmetric(
                    horizontal: 30, vertical: 15), // Padding del botón
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold), // Estilo del texto
              ),
              child: Text(
                'Guardar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
