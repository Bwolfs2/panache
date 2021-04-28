import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:panache_core/panache_core.dart';

class WebThemeService extends ThemeService<dynamic, dynamic> {
  dynamic _dir;
  dynamic get dir => _dir;

  ThemeData _theme;
  ThemeData get theme => _theme;

  List<dynamic> _themes;
  List<dynamic> get themes => _themes;

  VoidCallback _onChange;

  init(VoidCallback onChange) {
    _onChange = onChange;
    if (dirProvider != null)
      dirProvider().then((dir) {
        _dir = dir;
        _onChange();
      });
  }

  // ThemeData _localize(ThemeData theme) =>
  //     ThemeData.localize(theme, Typography.englishLike2018);

  void initTheme({MaterialColor primarySwatch: Colors.blue, Brightness brightness: Brightness.light}) {
    //final inputTheme = InputDecoration().applyDefaults(InputDecorationTheme());
    //TODO: ThemeData Change
    _theme = ThemeData(
      fontFamily: 'Roboto',
      primarySwatch: primarySwatch,
      brightness: brightness,
      platform: TargetPlatform.iOS,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: primarySwatch[100],
        selectionColor: primarySwatch[300],
        selectionHandleColor: primarySwatch[600],
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: primarySwatch[600],
      ),
    );
  }

  void updateTheme(ThemeData newTheme) {
    _theme = newTheme;
  }
}
