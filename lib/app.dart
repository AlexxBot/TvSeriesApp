import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tvseries_app/router.dart';
import 'features/auth/presentation/provider/theme_provider.dart';

class TvSeriesApp extends StatefulWidget {
  const TvSeriesApp({Key? key}) : super(key: key);

  @override
  _TvSeriesAppState createState() => _TvSeriesAppState();
}

class _TvSeriesAppState extends State<TvSeriesApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('es'),
        theme: context.watch<ThemeProvider>().getTheme(),
        onGenerateRoute: RouteGenerator.generateRoute);
  }
}
