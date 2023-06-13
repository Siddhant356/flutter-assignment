import 'package:box_ui/box_ui.dart';
import 'package:flutter/material.dart';

AppBar boxAppBar(String title, {Widget? icon}) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: appPrimaryColor,
    elevation: 0,
    iconTheme: const IconThemeData(
      color: Colors.white, //change your color here
    ),
    title: Text(
      title,
      style: const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500, fontSize: 18, color: Colors.white),
    ),
    actions: icon != null ? [icon] : null,
  );
}
