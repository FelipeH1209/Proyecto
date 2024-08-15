import 'package:flutter/material.dart';
import 'package:flutter_application_ganaderia/pages/user_add_page.dart';
import 'package:flutter_application_ganaderia/pages/user_edit_page.dart';
import 'package:flutter_application_ganaderia/routes.dart';
import 'package:flutter_application_ganaderia/database/localDb.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                leading: Icon(Icons.home),
                title: Text('Inicio'),
                onTap: () async {
                  await Navigator.pushNamed(
                    context,
                    Routes.home,
                    arguments: '',
                  );
                },
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
                leading: Icon(Icons.addchart_outlined),
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
                leading: Icon(Icons.edit_note),
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
                leading: Icon(Icons.insert_chart_outlined),
                title: Text('Informes'),
                onTap: () async {
                  await Navigator.pushNamed(
                    context,
                    Routes.users,
                    arguments: '',
                  );
                },
              ),
              if (args['perfil'] == 1)
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
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Cerrar sesión'),
                onTap: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('auth_token');
                  await Navigator.pushNamed(
                    context,
                    Routes.initialRoute,
                    arguments: null,
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

  Future<bool?> _deleteRecor(BuildContext context, int index) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmar tu acción'),
          content: Text('¿ Estas Seguro de proceder ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Cierra el diálogo y retorna false
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                await LocalDatabase().deleteUser(id: index);
                Navigator.of(context)
                    .pop(true); // Cierra el diálogo y retorna true
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  // void _deleteRecor(int index) async {
  //
  //   setState(() {});
  // }

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
                  label: Center(
                    child: Text(
                      'Acción',
                    ),
                  ),
                  numeric: true,
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
                          ? Center(
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      _editRecord(_index);
                                    },
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        _deleteRecor(context, _index);
                                        setState(() {});
                                      },
                                      icon: Icon(Icons.delete))
                                ],
                              ),
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
