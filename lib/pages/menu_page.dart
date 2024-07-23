import 'package:flutter/material.dart';
import 'package:flutter_application_ganaderia/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  late DateTime _initialDate, _date;

  @override
  void initState() {
    super.initState();

    _initialDate = DateTime(2010, 1);
    _date = _initialDate;
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
            onPressed: _selectedDate,
            icon: Icon(Icons.calendar_month),
          ),
          IconButton(
            // si initial date es diferente a la fecha inicial habilitamos el botom
            onPressed: _initialDate != _date ? () {} : null,
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
      body: SafeArea(
        child: CalendarDatePicker(
          // Date time (año, mes, dia)
          // fecha inicial en que sale el calendario
          initialDate: _date,
          // first date fecha inicial para el calendario
          firstDate: DateTime(2010, 1),
          lastDate: DateTime.now(),
          // como se visualizara en forma inicial por año o normal
          initialCalendarMode: DatePickerMode.day,
          // deshabilitar todos los días sabados

          onDateChanged: (date) {
            setState(() {
              _date = date;
            });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción cuando se presiona el botón
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

  void _selectedDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000, 5),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        _date = date;
      });
    }
  }
}
