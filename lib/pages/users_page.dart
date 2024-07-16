import 'package:flutter/material.dart';
import 'package:flutter_application_ganaderia/routes.dart';
import 'package:flutter_application_ganaderia/database/localDb.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  Color _color = Colors.indigo.shade400;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
        actions: [
          IconButton(
            // si initial date es diferente a la fecha inicial habilitamos el botom
            onPressed: () {},
            icon: const Icon(Icons.save),
          ),
        ],
        // automaticallyImplyLeading: false,
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(args['name']),
                accountEmail: Text(args['email']),
                currentAccountPicture: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/images/users/' + args['photo']),
                ),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade400,
                ),
              ),
              ListTile(
                leading: Icon(Icons.search),
                title: Text('Consultar'),
                onTap: () async {
                  await Navigator.pushNamed(
                    context,
                    Routes.login,
                    arguments: '',
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.app_registration),
                title: Text('Registrar'),
                onTap: () async {
                  await Navigator.pushNamed(
                    context,
                    Routes.reistrer,
                    arguments: '',
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.update),
                title: Text('Actualizar'),
                onTap: () async {
                  await Navigator.pushNamed(
                    context,
                    Routes.login,
                    arguments: '',
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.group),
                title: Text('Usuarios'),
                onTap: () async {
                  await Navigator.pushNamed(
                    context,
                    Routes.users,
                    arguments: args,
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: DataTableExample(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción cuando se presiona el botón
          _showFormModal(context);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        tooltip: 'Agregar',
        backgroundColor: Colors.indigo.shade300,
        hoverColor: Colors.indigo.shade900,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _showFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: FormModal(),
        );
      },
    );
  }
}

class DataTableExample extends StatelessWidget {
  // var usuarios = getDataUser();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<dynamic, dynamic>>>(
      future: getDataUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No data available'));
        } else {
          final users = snapshot.data!;
          return DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text('Nombre'),
              ),
              DataColumn(
                label: Text('Correo'),
              ),
              DataColumn(
                label: Text('Tipo'),
              ),
            ],
            rows: users.map((user) {
              String perfil = '';
              if (user['perfil'] == '1') {
                perfil = 'Administrador';
              } else {
                perfil = 'Operador';
              }
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text(user['name']!)),
                  DataCell(Text(user['email']!)),
                  DataCell(Text(perfil)),
                ],
              );
            }).toList(),
          );
        }
      },
    );
  }
}

Future<List<Map<dynamic, dynamic>>> getDataUser() async {
  final validateUser = await LocalDatabase().readAllUser();
  return validateUser;
}

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
