import 'package:flutter/material.dart';
import 'package:dompet/extension/size.dart';

const _darkBackground = Color(0xff102a27);
const _darkSurface = Color(0xff183b35);
const _darkPrimary = Color(0xff18a889);
const _darkAccent = Color(0xffb8e6d8);
const _darkText = Color(0xfff4f8f6);
const _darkSecondaryText = Color(0xffa8bdb6);
const _darkDivider = Color(0xff31534b);

final ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
    primary: _darkPrimary,
    onPrimary: _darkBackground,
    secondary: _darkAccent,
    onSecondary: _darkBackground,
    surface: _darkSurface,
    onSurface: _darkText,
    onSurfaceVariant: _darkSecondaryText,
    outline: _darkDivider,
  ),
  scaffoldBackgroundColor: _darkBackground,
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: _darkText,
      fontWeight: FontWeight.bold,
      fontSize: 18.fp,
    ),
    foregroundColor: _darkText,
    scrolledUnderElevation: 0.0,
    backgroundColor: _darkBackground,
    centerTitle: true,
    elevation: 0.0,
  ),
  fontFamily: 'PingFang, Arial, Sans-serif',
  primaryColorLight: _darkSurface,
  primaryColor: _darkPrimary,
  hintColor: _darkSecondaryText,
  dividerColor: _darkDivider,
  cardColor: _darkSurface,
  dialogTheme: DialogThemeData(
    backgroundColor: _darkSurface,
    surfaceTintColor: Colors.transparent,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: _darkSurface,
    surfaceTintColor: Colors.transparent,
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: _darkSurface,
    surfaceTintColor: Colors.transparent,
  ),
);
