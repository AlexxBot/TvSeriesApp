import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/widgets/text_widget.dart';
import 'expansion_tile_widget.dart';
import 'filter_container_widget.dart';

class FilterWidget extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final VoidCallback onPressed;
  final bool isExpanded;
  const FilterWidget(
      {Key? key,
      this.title = 'Filtro de Busqueda',
      required this.children,
      required this.onPressed,
      this.isExpanded = false})
      : super(key: key);

  @override
  FilterWidgetState createState() => FilterWidgetState();
}

class FilterWidgetState extends State<FilterWidget> {
  late bool _isExpanded;

  late bool _readOnly;

  /* final _expansionTileKey =
      GlobalKey<ExpansionTileWidgetState>(debugLabel: 'expansion_Tile'); */

  bool get isExpanded => _isExpanded;

  bool get readOnly => _readOnly;

  set isExpanded(bool value) {
    setState(() {
      _isExpanded = value;
    });
  }

  set readOnly(bool value) {
    setState(() {
      _readOnly = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isExpanded = widget.isExpanded;
    _readOnly = false;
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_readOnly,
      child: FilterContainerWidget(
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTileWidget(
              maintainState: true,
              onExpansionChanged: (bool value) {
                if (!readOnly) isExpanded = value;
              },
              initiallyExpanded: _isExpanded,

              //backgroundColor: Colors.amber,
              childrenPadding: const EdgeInsets.symmetric(
                  vertical: vspace_m, horizontal: hspace_m),
              /* tilePadding: EdgeInsets.symmetric(
                                    vertical: vspace_s, horizontal: hspace_xxl), */
              //leading: Icon(Icons.search),
              callback: () {
                if (!readOnly) widget.onPressed();
              } /* print("hola mundo") */,
              trailing:
                  /* _isExpanded
                        ? */ /* ButtonStyledWidget(
                            onPressed: () =>
                                null /* {
                              this.widget.onPressed();
                              //isExpanded = false;
                            } */
                            ,
                            title: "Buscar",
                            withBackground: true,
                          ) */
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: hspace_l, vertical: vspace_m),
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(borderRadiusModal),
                      ),
                      child: const TextWidget("Buscar")),
              /* : Icon(Icons.arrow_drop_down_sharp), */
              title: _readOnly
                  ? const SizedBox(
                      height: 0,
                    )
                  : Text(widget.title,
                      style: const TextStyle(
                          fontSize: fontSize_xl, fontWeight: fontWeightTitle)),
              children: widget.children),
        ),
      ),
    );
  }
}
