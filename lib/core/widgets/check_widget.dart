import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/utils/phone_actions_utils.dart';

class CheckWidget extends StatefulWidget {
  final VoidCallback? onTap;
  final bool? isChecked;
  final Color color;
  final bool visible;
  const CheckWidget(
      {Key? key,
      this.isChecked = false,
      this.color = primaryColor,
      this.onTap,
      this.visible = true})
      : super(key: key);

  @override
  CheckWidgetState createState() => CheckWidgetState();
}

class CheckWidgetState extends State<CheckWidget>
    with AutomaticKeepAliveClientMixin {
  late bool _checked;
  //late bool _visible;

  bool get value => _checked;

  set value(bool _isChecked) {
    //if (_checked >= 0 /* && _newValue <= widget.options.length */) {
    setState(() {
      _checked = _isChecked;
    });
    //}
  }

  /* set visible(bool visible) {
    setState(() {
      _visible = visible;
    });
  }
 */
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checked = widget.isChecked ?? false;
    //_visible = widget.visible;
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: InkWell(
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap!();
            vibrate();
          }
        },
        child: Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.all(0),
            decoration: BoxDecoration(
                color: _checked
                    ? filterBackground
                    : Theme.of(context).scaffoldBackgroundColor,
                border: Border.all(color: primaryColor)),
            height: fontSize_m * 2,
            width: fontSize_m * 2,
            child: _checked
                ? Icon(
                    Icons.check,
                    color: widget.color,
                    size: fontSize_m * 2,
                  )
                : SizedBox(
                    height: fontSize_xl,
                    width: fontSize_xl,
                  )),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
