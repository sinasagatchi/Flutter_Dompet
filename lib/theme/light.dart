import 'package:flutter/material.dart';
import 'package:dompet/extension/size.dart';

const _lightBackground = Color(0xfff4f8f6);
const _lightSurface = Color(0xffffffff);
const _lightPrimary = Color(0xff18a889);
const _lightAccent = Color(0xff176b58);
const _lightText = Color(0xff172b27);
const _lightSecondaryText = Color(0xff687873);
const _lightDivider = Color(0xffe1eae6);

final ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    primary: _lightPrimary,
    onPrimary: _lightAccent,
    secondary: _lightAccent,
    onSecondary: _lightSurface,
    surface: _lightSurface,
    onSurface: _lightText,
    onSurfaceVariant: _lightSecondaryText,
    outline: _lightDivider,
  ),
  scaffoldBackgroundColor: _lightBackground,
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      color: _lightText,
      fontWeight: FontWeight.bold,
      fontSize: 18.fp,
    ),
    foregroundColor: _lightText,
    scrolledUnderElevation: 0.0,
    backgroundColor: _lightBackground,
    centerTitle: true,
    elevation: 0.0,
  ),
  fontFamily: 'PingFang, Arial, Sans-serif',
  primaryColorLight: _lightSurface,
  primaryColor: _lightPrimary,
  hintColor: _lightSecondaryText,
  dividerColor: _lightDivider,
  cardColor: _lightSurface,
  dialogTheme: DialogThemeData(
    backgroundColor: _lightSurface,
    surfaceTintColor: Colors.transparent,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: _lightSurface,
    surfaceTintColor: Colors.transparent,
  ),
  popupMenuTheme: PopupMenuThemeData(
    color: _lightSurface,
    surfaceTintColor: Colors.transparent,
  ),
);
