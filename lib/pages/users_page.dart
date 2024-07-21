import 'package:flutter/material.dart';
import 'package:flutter_application_ganaderia/pages/user_add_page.dart';
import 'package:flutter_application_ganaderia/pages/user_edit_page.dart';
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
      resizeToAvoidBottomInset: true,
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

class DataTableExample extends StatefulWidget {
  @override
  State<DataTableExample> createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  void _editRecord(int index) async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: FormEditModal(index: index),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FutureBuilder<List<Map<dynamic, dynamic>>>(
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
                DataColumn(
                  label: Text('Acción'),
                ),
              ],
              rows: users.map((user) {
                int _index = user['id'];
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
                    DataCell(
                      (_index != 1)
                          ? IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _editRecord(_index);
                              },
                            )
                          : Text(''),
                    )
                  ],
                );
              }).toList(),
            );
          }
        },
      ),
    );
  }
}

Future<List<Map<dynamic, dynamic>>> getDataUser() async {
  final validateUser = await LocalDatabase().readAllUser();
  return validateUser;
}
