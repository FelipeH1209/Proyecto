import 'package:flutter/material.dart';
import 'package:flutter_application_ganaderia/pages/login_page.dart';
import 'package:flutter_application_ganaderia/pages/menu_page.dart';

import 'pages/splash_page.dart';
import 'routes.dart';

T getArguments<T>(BuildContext context) {
  return ModalRoute.of(context)!.settings.arguments as T;
}

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    // desde aca se renderiza la pagina principal
    Routes.home: (context) => const MenuPage(),
    Routes.splash: (context) => const SplashPage(),
    Routes.login: (context) => const LoginPage(),
  };
}
