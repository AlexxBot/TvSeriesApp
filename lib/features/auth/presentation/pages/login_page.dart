import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/widgets/will_pop_scope_widget.dart';
import 'package:tvseries_app/features/auth/presentation/widgets/login/footer_widget.dart';
import 'package:tvseries_app/features/auth/presentation/widgets/login/form_widget.dart';
import 'package:tvseries_app/features/auth/presentation/widgets/login/logo_widget.dart';
import 'package:tvseries_app/features/auth/presentation/widgets/login/title_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScopeWidget(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(vspace_l),
            height: MediaQuery.of(context).size.height,
            //width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TitleWigdet(),
                FormWidget(),
                const SizedBox(height: vspace_xxl),
                FooterWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
