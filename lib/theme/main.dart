import 'package:flutter/material.dart';

class AppTheme {
  static final Color primaryColor = Color(0xff6237a0);
  static final Color accentColor = Color(0xff9754cb);
  static final Color secondaryHeaderColor = Color(0xffdeacf5);
  static final VisualDensity visualDensity =
      VisualDensity.adaptivePlatformDensity;

  static final ThemeData data = ThemeData.light().copyWith(
      primaryColor: AppTheme.primaryColor,
      accentColor: AppTheme.accentColor,
      secondaryHeaderColor: AppTheme.secondaryHeaderColor,
      visualDensity: AppTheme.visualDensity,
      colorScheme: ColorScheme.light().copyWith(
          primary: AppTheme.primaryColor, secondary: AppTheme.accentColor));
}

// fontFamily: "Raleway"
class AppDarkTheme {
  static final ThemeData data = ThemeData.dark().copyWith(
      primaryColor: AppTheme.primaryColor,
      accentColor: AppTheme.accentColor,
      secondaryHeaderColor: AppTheme.secondaryHeaderColor,
      visualDensity: AppTheme.visualDensity,
      colorScheme: ColorScheme.dark().copyWith(
          primary: AppTheme.primaryColor, secondary: AppTheme.accentColor));
}
