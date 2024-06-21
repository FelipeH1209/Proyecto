import 'package:flutter/material.dart';
import 'package:flutter_application_ganaderia/database/database_helper.dart';
import 'package:flutter_application_ganaderia/database/user_dao.dart';
import 'package:flutter_application_ganaderia/models/user_model.dart';
import 'package:flutter_application_ganaderia/pages/perfil.dart';
import 'package:flutter_application_ganaderia/pages/qrscaner.dart';

import 'pages/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final controller = TextEditingController();
  final dao = UserDao();
  @override
  void initState() async {
    UserModel usuarioInicial =
        UserModel(name: 'Admin', email: 'admin@gmail.com');
    // final id = await dao.insert(usuarioInicial);
    // print(id);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LoginPage(),
      ),
    );
  }
}
