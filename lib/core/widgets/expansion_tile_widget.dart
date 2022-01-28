import 'package:flutter/material.dart';
import 'package:tvseries_app/core/utils/phone_actions_utils.dart';

const Duration _kExpand = Duration(milliseconds: 300);

class ExpansionTileWidget extends StatefulWidget {
  final Widget? leading;
  final Widget title;
  final Widget? subtitle;
  final ValueChanged<bool>? onExpansionChanged;
  final VoidCallback? callback;
  final List<Widget> children;
  final Color? backgroundColor;
  final Color? collapsedBackgroundColor;
  final Widget? trailing;
  final bool initiallyExpanded;
  final bool maintainState;
  final EdgeInsetsGeometry? tilePadding;
  final Alignment? expandedAlignment;
  final CrossAxisAlignment? expandedCrossAxisAlignment;
  final EdgeInsetsGeometry? childrenPadding;
  final Color? iconColor;
  final Color? collapsedIconColor;
  final Color? textColor;
  final Color? collapsedTextColor;

  const ExpansionTileWidget({
    Key? key,
    this.leading,
    required this.title,
    this.subtitle,
    this.onExpansionChanged,
    this.callback,
    required this.children,
    this.trailing,
    this.initiallyExpanded = false,
    this.maintainState = false,
    this.tilePadding,
    this.expandedCrossAxisAlignment,
    this.expandedAlignment,
    this.childrenPadding,
    this.backgroundColor,
    this.collapsedBackgroundColor,
    this.textColor,
    this.collapsedTextColor,
    this.iconColor,
    this.collapsedIconColor,
  }) : super(key: key);

  @override
  _ExpansionTileWidgetState createState() => _ExpansionTileWidgetState();
}

class _ExpansionTileWidgetState extends State<ExpansionTileWidget>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeOutTween =
      CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _borderColorTween = ColorTween();
  final ColorTween _headerColorTween = ColorTween();
  final ColorTween _iconColorTween = ColorTween();
  final ColorTween _backgroundColorTween = ColorTween();

  late AnimationController _controller;

  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  late Animation<Color?> _borderColor;
  late Animation<Color?> _headerColor;
  late Animation<Color?> _iconColor;
  late Animation<Color?> _backgroundColor;

  late bool _isExpanded;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _borderColor = _controller.drive(_borderColorTween.chain(_easeOutTween));
    _headerColor = _controller.drive(_headerColorTween.chain(_easeInTween));
    _iconColor = _controller.drive(_iconColorTween.chain(_easeInTween));
    _backgroundColor =
        _controller.drive(_backgroundColorTween.chain(_easeOutTween));

    _isExpanded = PageStorage.of(context)?.readState(context) as bool? ??
        widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    vibrate();
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {});
        });
      }

      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    widget.onExpansionChanged?.call(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    final Color borderSideColor = _borderColor.value ?? Colors.transparent;

    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
              top: BorderSide(color: borderSideColor),
              bottom: BorderSide(color: borderSideColor))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTileTheme.merge(
            iconColor: _iconColor.value,
            textColor: _headerColor.value,
            child: ListTile(
              onTap: _handleTap,
              contentPadding: widget.tilePadding,
              leading: widget.leading,
              title: widget.title,
              trailing: widget.trailing != null && _isExpanded
                  ? InkWell(
                      child: widget.trailing,
                      onTap: () {
                        //vibrate();
                        if (_isExpanded) {
                          widget.callback!();
                          _handleTap();
                        }
                      },
                    )
                  : RotationTransition(
                      turns: _iconTurns,
                      child: Icon(
                        Icons.expand_more,
                        color: widget.iconColor,
                      ),
                    ),
            ),
          ),
          ClipRect(
              child: Align(
                  alignment: widget.expandedAlignment ?? Alignment.center,
                  heightFactor: _heightFactor.value,
                  child: child))
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    _borderColorTween.end = theme.dividerColor;
    _headerColorTween
      ..begin = widget.collapsedTextColor ?? theme.textTheme.subtitle1!.color
      ..end = widget.textColor ?? colorScheme.secondary;
    _iconColorTween
      ..begin = widget.collapsedIconColor ?? theme.unselectedWidgetColor
      ..end = widget.iconColor ?? colorScheme.secondary;
    _backgroundColorTween
      ..begin = widget.collapsedBackgroundColor
      ..end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    final bool shouldRemoveChildren = closed && !widget.maintainState;

    final Widget result = Offstage(
      child: TickerMode(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: widget.children,
          ),
        ),
        enabled: !closed,
      ),
      offstage: closed,
    );
    return AnimatedBuilder(
        animation: _controller.view,
        builder: _buildChildren,
        child: shouldRemoveChildren ? null : result);
  }
}
