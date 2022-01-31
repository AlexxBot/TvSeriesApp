import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';
import 'package:tvseries_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tvseries_app/router.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({Key? key}) : super(key: key);

  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  late final AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const TextWidget('Series'),
          onTap: () =>
              Navigator.pushReplacementNamed(context, RouteGenerator.showsPage),
        ),
        /* ListTile(
          title: const TextWidget('Favorites'),
          onTap: () => Navigator.pushReplacementNamed(
              context, RouteGenerator.favoritesPage),
        ), */
        ListTile(
          title: const TextWidget('People'),
          onTap: () => Navigator.pushReplacementNamed(
              context, RouteGenerator.peoplePage),
        ),
      ],
    );
  }
}
