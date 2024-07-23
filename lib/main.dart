import 'package:flutter/material.dart';
import 'package:flutter_application_ganaderia/app_routes.dart';
import 'package:flutter_application_ganaderia/pages/login_page.dart';
import 'package:flutter_application_ganaderia/pages/menu_page.dart';
import 'package:flutter_application_ganaderia/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
        home: FutureBuilder(
            future: _checkLogin(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == true) {
                  return MenuPage();
                } else {
                  return LoginPage();
                }
              }
              return CircularProgressIndicator();
            }),
        initialRoute: Routes.initialRoute,
        routes: appRoutes,
      ),
    );
  }

  Future<bool> _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token') != null;
  }
}
