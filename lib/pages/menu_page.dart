import 'package:flutter/material.dart';
import 'package:flutter_application_ganaderia/routes.dart';

// de esta manera se refactoriza el menu page para que tenga rutas creadas a partir de una clase
class PageData {
  final String name;
  final String label;
  final Object?
      arguments; // con el interrogante permite crear instancias de una clase y este atributo puede ser nulo o no
  final void Function(Object?)? onResult;
  final IconData? icon;

  PageData({
    required this.name,
    required this.label,
    this.arguments,
    this.onResult,
    required this.icon,
  });
}

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  Color _color = Colors.indigo.shade400;
  late final List<PageData> _pages;
  @override
  void initState() {
    super.initState();
    _pages = [
      PageData(
        name: Routes
            .login, // <- esto hay que cambiarlo cuando se vaya creando las vistas
        label: 'Consulta',
        arguments: 'Jerson0493@gmail.com',
        icon: Icons.visibility,
      ),
      PageData(
        name: Routes
            .login, // <- esto hay que cambiarlo cuando se vaya creando las vistas
        label: 'Registro',
        arguments: 'Jerson0493@gmail.com',
        icon: Icons.add_alert_rounded,
      ),
      PageData(
        name: Routes
            .login, // <- esto hay que cambiarlo cuando se vaya creando las vistas
        label: 'Actualización',
        arguments: 'Jerson0493@gmail.com',
        icon: Icons.edit,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
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
                    Routes.login,
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
                    Routes.login,
                    arguments: '',
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: Text('Contenido de la aplicación'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción cuando se presiona el botón
        },
        child: Icon(Icons.add),
        tooltip: 'Agregar',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
