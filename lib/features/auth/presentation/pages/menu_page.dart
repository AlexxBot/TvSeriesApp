import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/features/auth/presentation/widgets/menu/body_widget.dart';
import 'package:tvseries_app/features/auth/presentation/widgets/menu/footer_widget.dart';
import 'package:tvseries_app/features/auth/presentation/widgets/menu/header_widget.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: secondaryColor.withOpacity(0.2),
      child: ListView(
        children: [
          HeaderWidget(),
          BodyWidget(),
          Divider(
            thickness: 2,
          ),
          FooterWidget()
        ],
      ),
    );
  }
}
