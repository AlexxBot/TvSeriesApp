import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/widgets/button_styled_widget.dart';
import 'package:tvseries_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tvseries_app/router.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({Key? key}) : super(key: key);

  @override
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  /* void _goConfig(BuildContext context) async {
    Navigator.pop(context);
    await Navigator.pushReplacementNamed(context, RouteGenerator.configPage);
  } */

  late final AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
  }

  /* void _setTheme() {
    context.read<ThemeProvider>().changeMode();
  } */

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: filterBackground),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ListTile(
              leading: Text(
                "Account",
                style: TextStyle(
                    fontSize: fontSize_l,
                    color: Theme.of(context).primaryColor),
              ),
              trailing: ButtonStyledWidget(
                  hOutPadding: hspace_l,
                  withBackground: true,
                  title: "Settings",
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, RouteGenerator.configPage);
                  }),

              /* trailing: ChipWidget(
                  withBackground: false,
                  icon: Icons.settings,
                  onPressed: () => _goConfig(context),
                  text: " ",
                ) */ /* IconButton(
                  iconSize: fontSize_m * 2,
                  onPressed: () => _goConfig(context),
                  icon: Icon(Icons.settings),
                  color: Theme.of(context).scaffoldBackgroundColor,
                ) */
            ),

            /* ListTile(
              leading: Text(
                "Settings",
                style: TextStyle(
                    fontSize: fontSize_l,
                    color: Theme.of(context).scaffoldBackgroundColor),
              ),
              onTap: () =>
                  Navigator.pushNamed(context, RouteGenerator.configPage),
            ) */
          ],
        ),
      ),
    );
  }
}
