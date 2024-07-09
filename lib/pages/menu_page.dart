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
            .reistrer, // <- esto hay que cambiarlo cuando se vaya creando las vistas
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: _color,
        // automaticallyImplyLeading: false,
      ),
      drawer: Drawer(
        elevation: 10,
        // Widget del drawer
        child: ListView.builder(
          itemBuilder: (_, index) {
            final data = _pages[index];
            return ListTile(
              leading: Icon(data.icon),
              title: Text(data.label),
              onTap: () async {
                final result = await Navigator.pushNamed(
                  context,
                  data.name,
                  arguments: data.arguments,
                );
                if (data.onResult != null) {
                  data.onResult!(result);
                }
              },
            );
          },
          itemCount: _pages.length,
        ),
      ),
      body: Center(
        child: Text('Contenido de la aplicación'),
      ),
    );
  }
}
