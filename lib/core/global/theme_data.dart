import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/size_constants.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

/* final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.black,
  brightness: Brightness.dark,
  backgroundColor: const Color(0xFF212121),
  accentColor: Colors.white,
  accentIconTheme: IconThemeData(color: Colors.black),
  dividerColor: Colors.black12,
);

final lightTheme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: const Color(0xFFE5E5E5),
  accentColor: Colors.black,
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
); */
const textColor = Colors.white;
const primaryColor = Color(0XFF2D2F63);
const secondaryColor = /* Color(0XE6383838) */ /* Color(0xFF5A5A5A) */ Colors
    .black12;
const thirdColor = Color(0xFF5A5A5A);
const itemListColor = Color(0XFFEEEEEE);
final listBackgroundColor = Colors.grey.shade200;
final containerBackGroundColor = /*  Color(0XDDDADADA); */ Color(0XDD383838);
final errorColor = Colors.red[700];
final inputColor = Color(0XFF75ff83);

final enableInputColor = Colors.grey[50];
final readOnlyInputColor = Color(0XFFEEEEEE);

const filterBackground = Colors.grey;

const colorText = Colors.black;
const colorSubtitle = Colors.grey;

MaterialColor colorCustom = MaterialColor(0XFF2D2F63, color);

final darkTheme = ThemeData(
  fontFamily: 'Sora',
  primarySwatch: Colors.grey,
  primaryColor: Colors.black87,
  brightness: Brightness.dark,
  errorColor: Colors.red[800],
  backgroundColor: const Color(0xFF212121),
  dividerColor: Colors.black12,
);

final lightTheme = ThemeData(
    fontFamily: 'Sora',
    primarySwatch:
        colorCustom /* Colors.amber */ /* Colors.grey */, //this is for circle progress idnicator and input border color
    primaryColor: /* Color(0xff3B7FFF) */ primaryColor,
    errorColor: Colors.red,
    inputDecorationTheme: InputDecorationTheme(fillColor: Colors.transparent),
    backgroundColor: secondaryColor,
    scaffoldBackgroundColor: secondaryColor,
    buttonTheme: ButtonThemeData(
      // 4
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
      buttonColor: Colors.amber,
    ),
    /* snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      elevation: 5,
      backgroundColor: Colors.black38,
      shape: CircleBorder(), /* StadiumBorder() */
    ), */

    primaryTextTheme:
        const TextTheme(headline6: TextStyle(color: Colors.black)),
    appBarTheme: const AppBarTheme(
      toolbarTextStyle:
          TextStyle(backgroundColor: Colors.pink, color: Color(0XFF2D2F63)),
      actionsIconTheme: IconThemeData(color: Colors.white),
      iconTheme: IconThemeData(color: Colors.white),
      centerTitle: true,

      elevation: 2,
      titleTextStyle: TextStyle(fontSize: fontSize_s * 2),
      foregroundColor: Color(0Xff4D47C7),
      backgroundColor: Colors.black38, //Colors.white
    ));
