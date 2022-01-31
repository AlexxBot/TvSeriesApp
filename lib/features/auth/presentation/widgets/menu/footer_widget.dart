import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tvseries_app/router.dart';

class FooterWidget extends StatefulWidget {
  const FooterWidget({Key? key}) : super(key: key);

  @override
  _FooterWidgetState createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
  late final authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  //void _setNotifications(bool activated) {}

  void _logout() {
    authBloc.add(LogoutEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) {
        if (state is LoggedOutState) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              RouteGenerator.loginPage, (Route<dynamic> route) => false);
        }
      },
      child: Column(children: [
        ListTile(
            onTap: _logout,
            leading: Icon(Icons.logout, color: Theme.of(context).errorColor),
            title: Text("Logout",
                style: TextStyle(color: Theme.of(context).errorColor)))
      ]),
    );
  }
}
