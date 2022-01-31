import 'package:flutter/material.dart';
import 'package:tvseries_app/core/widgets/custom_page_route.dart';
import 'package:tvseries_app/features/auth/presentation/pages/config_page.dart';
import 'package:tvseries_app/features/person/presentation/pages/person_page.dart';
import 'package:tvseries_app/features/show/presentation/pages/show_favorite_page.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/show/presentation/pages/show_page.dart';

class RouteGenerator {
  static const String loginPage = '/';
  static const String showsPage = '/shows';
  static const String peoplePage = '/people';
  static const String favoritesPage = '/favorites';
  static const String episodePage = '/episodes';
  static const String configPage = '/config';
  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginPage:
        return CustomPageRoute(
          const LoginPage(),
        );
      case configPage:
        return CustomPageRoute(
          const ConfigPage(),
        );
      case showsPage:
        return CustomPageRoute(
          const ShowPage(),
        );
      case peoplePage:
        return CustomPageRoute(
          const PersonPage(),
        );
      case favoritesPage:
        return CustomPageRoute(
          const ShowFavoritePage(),
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
