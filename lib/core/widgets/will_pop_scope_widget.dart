import 'package:flutter/cupertino.dart';
import 'package:tvseries_app/core/utils/dialogs.dart';

class WillPopScopeWidget extends StatelessWidget {
  final Widget child;
  const WillPopScopeWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: child,
      onWillPop: () =>
          confirmation(context, text: "Want to leave the application?"),
    );
  }
}
