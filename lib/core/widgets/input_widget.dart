import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';

class InputWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final VoidCallback? onPressed;
  const InputWidget(
      {Key? key,
      this.label = '',
      required this.controller,
      this.focusNode,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      //style: const TextStyle(color: filterBackground),

      cursorColor: primaryColor,
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: primaryColor, width: 1.0),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusColor: Colors.white,
          labelText: label,
          hintText: label,
          suffixIcon: IconButton(
            iconSize: 30,
            color: primaryColor,
            icon: const Icon(Icons.search),
            onPressed: onPressed,
          ),
          counterStyle: const TextStyle(color: primaryColor),
          fillColor: primaryColor,
          hintStyle: const TextStyle(color: primaryColor),
          helperStyle: const TextStyle(color: primaryColor),
          labelStyle: const TextStyle(color: primaryColor),
          border: const OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(borderRadiusInput)))),
    );
  }
}
