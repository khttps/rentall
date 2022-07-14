import 'package:flutter/material.dart';

const _primarySwatch = Colors.blueGrey;

const _inputDecoration = InputDecorationTheme(
  filled: true,
  fillColor: Colors.white,
  isDense: true,
  contentPadding: EdgeInsets.all(8.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(2.0),
    ),
  ),
);

get themeData {
  return ThemeData(
      primarySwatch: _primarySwatch,
      inputDecorationTheme: _inputDecoration,
      brightness: Brightness.light);
}

get darkThemeData {
  return ThemeData(
    primarySwatch: Colors.grey,
    inputDecorationTheme: _inputDecoration,
    brightness: Brightness.dark,
  );
}
