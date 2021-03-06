import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/provider/theme_provider.dart';
import 'features/person/presentation/bloc/person_bloc.dart';
import 'features/show/presentation/bloc/show_bloc.dart';
import 'injections.dart';
import 'injections.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (context) => sl<AuthBloc>()),
          BlocProvider<ShowBloc>(create: (context) => sl<ShowBloc>()),
          BlocProvider<PersonBloc>(create: (context) => sl<PersonBloc>()),
        ],
        child: ChangeNotifierProvider<ThemeProvider>(
            create: (context) => ThemeProvider(),
            child:
                const TvSeriesApp())); /* BlocProvider<ShowBloc>(
      create: (context) => sl<ShowBloc>(),
      child: ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(), child: const TvSeriesApp()),
    ); */
  }
}
