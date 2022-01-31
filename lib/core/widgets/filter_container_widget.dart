import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';

class FilterContainerWidget extends StatelessWidget {
  final Widget child;
  const FilterContainerWidget({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return /* Container(
        margin: EdgeInsets.symmetric(vertical: vspace_s, horizontal: hspace_m),
        padding: EdgeInsets.symmetric(vertical: vspace_s, horizontal: hspace_m),
        decoration: BoxDecoration(
          color: /* Theme.of(context).accentColor.withOpacity(0.05) */ filterBackground
          /* primaryColor.withOpacity(0.2) */,
          borderRadius: BorderRadius.circular(borderRadiusModal),
          //shape: BoxShape.rectangle,
        ),
        child: this.child); */
        Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusModal),
      ),
      elevation: 5,
      color: filterBackground,
      margin:
          const EdgeInsets.symmetric(vertical: vspace_s, horizontal: hspace_s),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: hspace_s),
        child: child,
      ),
    );

    /* Padding(
      padding:
          const EdgeInsets.symmetric(vertical: vspace_s, horizontal: hspace_m),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadiusInput),
        child: Container(
          margin:
              EdgeInsets.symmetric(vertical: vspace_s, horizontal: hspace_m),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: filterBackground,
            /* boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0.0, 1.0), //(x,y)
                blurRadius: 6.0,
              ),
            ], */
          ),
          child: this.child,
        ),
      ),
    ); */
  }
}
