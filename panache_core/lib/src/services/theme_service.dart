import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class ThemeService<D, F> {
  final Future<D> Function() dirProvider;
  D _dir;
  D get dir => _dir;

  ThemeData _theme;
  ThemeData get theme => _theme;

  List<F> _themes;
  List<F> get themes => _themes;

  VoidCallback _onChange;

  ThemeService({this.dirProvider});

  init(VoidCallback onChange) {
    _onChange = onChange;
    if (dirProvider != null)
      dirProvider().then((dir) {
        _dir = dir;
        _onChange();
      });
  }

  void initTheme({MaterialColor primarySwatch: Colors.blue, Brightness brightness: Brightness.light});

  void updateTheme(ThemeData newTheme);
}
