import 'package:flutter/material.dart';


const Color appPrimaryColor = Color(0xff1DA1F2);
const Color appSecondaryColor = Color(0xffEDF8FF);
const Color appBackgroundColor = Color(0xffF5F5F5);
const Color appBackgroundSecondaryColor = Color(0xffF2F2F2);
const Color appHintColor = Color(0xff949C9E);

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}