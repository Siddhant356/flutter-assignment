import 'package:flutter/material.dart';

import '../../box_ui.dart';

final ThemeData assignmentTheme = _buildGoChargeTheme();

ThemeData _buildGoChargeTheme() {
  final ThemeData base = ThemeData();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: appPrimaryColor,
      onPrimary: appPrimaryColor.withOpacity(0.5),
      secondary: appSecondaryColor,
    ),
    // TODO: Add the text themes (103)
    // TODO: Decorate the inputs (103)
  );
}