//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';

class InputWidget extends StatefulWidget {
  final String labelText;
  final double vOutPadding;
  final double hOutPadding;
  final double vInPadding;
  final double hInPadding;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  //final ValueChanged<String>? validator;
  //final FunctionStringCallback? validator;
  final FormFieldValidator<String>? validator;
  final int minLines;
  final int maxLines;
  final double fontSize;
  final double borderRadius;
  final TextStyle? style;
  final bool readOnly;
  final TextAlign textAlign;
  final Widget? prefixIcon;
  final String? suffixText;
  final String? initialValue;
  final Color? backGroundColor;
  final ValueChanged<String>? onChanged;
  final bool visible;
  final bool obscureText;
  final String? hintText;
  const InputWidget(
      {Key? key,
      this.labelText = "",
      this.vOutPadding = vspace_m,
      this.hOutPadding = hspace_s,
      this.vInPadding = vspace_l,
      this.hInPadding = hspace_l,
      this.controller,
      this.focusNode,
      this.keyboardType,
      this.inputFormatters,
      this.validator,
      this.minLines = 1,
      this.maxLines = 1,
      this.fontSize = fontSize_l,
      this.borderRadius = borderRadiusInput,
      this.style,
      this.readOnly = false,
      this.textAlign = TextAlign.start,
      this.prefixIcon,
      this.suffixText,
      this.initialValue = '',
      this.backGroundColor,
      this.onChanged,
      this.hintText = '',
      this.visible = true,
      //this.color = textColor,
      this.obscureText = false})
      : super(key: key);

  @override
  InputWidgetState createState() => InputWidgetState();
}

class InputWidgetState extends State<InputWidget> {
  late bool _readOnly;

  late final _controller;

  set readOnly(bool value) {
    setState(() {
      _readOnly = value;
    });
  }

  late bool _visible;

  set visible(bool value) {
    setState(() {
      _readOnly = value;
    });
  }

  bool get readOnly => _readOnly;

  TextEditingController get controller => _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _readOnly = widget.readOnly;
    _visible = widget.visible;
    //widget.controller.text = widget.initialValue;
    _controller = widget.controller ?? TextEditingController();
    //if (widget.controller == null) {
    _controller.text = widget.initialValue ?? '';
    //}
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return /* Visibility(
      visible: _visible,
      child:  */
        Padding(
      padding: EdgeInsets.symmetric(
          vertical: widget.vOutPadding, horizontal: widget.hOutPadding),
      child: TextFormField(
        //initialValue: widget.initialValue,
        decoration: InputDecoration(
          filled: true,
          fillColor: _readOnly ? readOnlyInputColor : enableInputColor,
          suffixText: widget.suffixText,
          prefixIcon: widget.prefixIcon,
          contentPadding: EdgeInsets.symmetric(
              vertical: widget.vInPadding, horizontal: widget.hInPadding),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: const BorderSide(color: primaryColor, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            borderSide: const BorderSide(
              color: primaryColor,
              width: 1.0,
            ),
          ),
          /* hintText: "hint",
                helperText: labelText,
                helperStyle: style == null
                    ? TextStyle(fontSize: fontSize)
                    : style, */
          labelText: widget.labelText,
          hintText: widget.hintText == '' ? widget.labelText : widget.hintText,
          //helperText: labelText,
        ),
        controller: /* widget.controller ??  */ _controller,
        focusNode: widget.focusNode,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        //maxLines: maxlines,
        validator: widget.validator,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        style: widget.style ??
            TextStyle(
                fontSize: widget.fontSize,
                color: _readOnly ? colorText.withOpacity(0.6) : colorText),

        obscureText: widget.obscureText,
        obscuringCharacter: '*',

        readOnly: _readOnly,
        textAlign: widget.textAlign,
        onChanged: widget.onChanged,
      ),
      /* ), */
    );
  }
}
