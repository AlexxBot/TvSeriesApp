import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/widgets/button_styled_widget.dart';
import 'package:tvseries_app/core/widgets/loading_widget.dart';
import 'package:tvseries_app/core/widgets/snack_widget.dart';
import 'package:tvseries_app/features/auth/presentation/bloc/auth_bloc.dart';

class ConfigPage extends StatefulWidget {
  const ConfigPage({Key? key}) : super(key: key);

  @override
  State<ConfigPage> createState() => _ConfigPageState();
}

class _ConfigPageState extends State<ConfigPage> {
  late final AuthBloc authBloc;

  final _pinNumber = TextEditingController(text: "");
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    authBloc = BlocProvider.of<AuthBloc>(context);
    //authBloc.add(const GetPinEvent());
  }

  void _setPin() {
    if (!_formKey.currentState!.validate()) {
      SnackWidget.showMessage(context, 'Invalidate Pin Number');
    } else {
      authBloc.add(SetPinEvent(pinNumber: _pinNumber.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Settings"),
        ),
        body: BlocListener<AuthBloc, AuthState>(
          bloc: authBloc,
          listener: (context, state) {
            /* if (state is LoadingState) {
              LoadingWidget.show(context);
            } */
            if (state is PinSavedState) {
              //LoadingWidget.hide(context);
              if (state.saved) {
                SnackWidget.showMessage(context, 'Pin saved succesfully');
              }
            }
            if (state is ErrorState) {
              //LoadingWidget.hide(context);
              SnackWidget.showMessage(context, state.message);
            }
          },
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0, horizontal: hspace_xl),
                  child: Padding(
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
                          borderRadius:
                              BorderRadius.circular(borderRadiusInput),
                          borderSide:
                              const BorderSide(color: primaryColor, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(borderRadiusInput),
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
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: hspace_xl, vertical: vspace_s),
                  child: ButtonStyledWidget(
                    title: "Set Pin Number",
                    onPressed: _setPin,
                    //isExpanded: true,
                    textSize: fontSize_l,
                    withBackground: true,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
