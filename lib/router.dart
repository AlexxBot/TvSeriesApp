import 'package:flutter/material.dart';
import 'features/show/presentation/pages/show_page.dart';

class RouteGenerator {
  //static const String splashPage = '/';
  static const String loginPage = '/login';
  static const String showsPage = '/';
  static const String episodePage = '/episode';
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
      /* return MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ); */
      case showsPage:
        return MaterialPageRoute(
          builder: (_) => const ShowPage(),
        );

      default:
        throw const RouteException("Route not found");
    }
  }
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
