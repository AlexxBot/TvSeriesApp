import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/widgets/button_styled_widget.dart';
import 'package:tvseries_app/core/widgets/loading_widget.dart';
import 'package:tvseries_app/core/widgets/snack_widget.dart';
import 'package:tvseries_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tvseries_app/router.dart';

class FormWidget extends StatefulWidget {
  const FormWidget({Key? key}) : super(key: key);

  @override
  _FormWidgetState createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  late final AuthBloc authBloc;

  TextEditingController _pinNumber = TextEditingController(text: "");
  String _pinSetted = '';

  late bool visible;

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
    authBloc.add(GetPinEvent());
    visible = false;
  }

  void _login() {
    /* authBloc.add(LoginEvent(
      pin: _pinNumber.text,
    )); */
    if (_pinNumber.text.trim() == _pinSetted.trim()) {
      //LoadingWidget.hide(context);
      Navigator.pushNamed(context, RouteGenerator.showsPage);
    } else {
      SnackWidget.showMessage(context, 'Invalidate Pin Number');
    }
  }

  void _passwordVisibility() {
    setState(() => visible = !visible);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) {
        /* if (state is LoadingState) {
          LoadingWidget.show(context);
        } */
        if (state is PinRetrivedState) {
          //LoadingWidget.hide(context);
          _pinSetted = state.pinNumber;
          if (_pinSetted == '') {
            Navigator.pushReplacementNamed(context, RouteGenerator.showsPage);
          }
        }
        /* if (state is LoggedInState) {
          LoadingWidget.hide(context);
          Navigator.pushNamed(context, RouteGenerator.showsPage);
        } */
        if (state is ErrorState) {
          //LoadingWidget.hide(context);
          SnackWidget.showMessage(context, state.message);
        }
      },
      child: Form(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: 0, horizontal: hspace_xl),
              child: Stack(alignment: Alignment(0.95, 0), children: [
                /* TextField(
                    decoration: InputDecoration(
                        labelText: "Password", border: OutlineInputBorder()),
                    obscureText: true,
                    controller: _passwordController) */

                /* InputWidget(
                  labelText: "Password",
                  controller: _passwordController,
                  obscureText: visible,
                ), */
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: vspace_m, horizontal: hspace_s),
                  child: TextFormField(
                    validator: (value) => (value ?? '').trim() == ''
                        ? 'Enter a pin number'
                        : null,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(borderRadiusInput)),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadiusInput),
                        borderSide:
                            const BorderSide(color: primaryColor, width: 1.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(borderRadiusInput),
                        borderSide: const BorderSide(
                          color: primaryColor,
                          width: 1.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: vspace_l, horizontal: vspace_l),
                      //border: OutlineInputBorder(),
                      labelText: "Pin Number",
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                    controller: _pinNumber,
                    obscureText: !visible,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      //WhitelistingTextInputFormatter
                    ],
                    //obscuringCharacter: '*',
                  ),
                  /* InputWidget(
                      labelText: "Password",
                      controller: _passwordController,
                      obscureText: true,
                    ) */
                ),
                IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    !visible ? Icons.visibility : Icons.visibility_off,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: _passwordVisibility,
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: hspace_xl, vertical: vspace_s),
              child: ButtonStyledWidget(
                title: "Login",
                onPressed: _login,
                //isExpanded: true,
                textSize: fontSize_l,
                withBackground: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
