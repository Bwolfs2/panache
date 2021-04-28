import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';

import 'converters/theme_converter.dart';
import 'models.dart';
import 'services/persistence_service.dart';

import 'services/theme_service.dart';
import 'utils/uuid.dart';

typedef Future<Uint8List> ScreenShooter();

class ThemeModel extends Model {
  get dirPath => _service.dir.path;

  static ThemeModel of(BuildContext context) => ScopedModel.of<ThemeModel>(context);

  //final CloudService _cloudService;

  final List<PanacheTheme> _themes;

  final Uuid _uuid = Uuid();

  ThemeService _service;

  PanacheTheme _currentTheme;

  final LocalStorage localData;

  ThemeData get theme => _service.theme;

  MaterialColor get primarySwatch => _currentTheme.primarySwatch;

  String get themeCode => themeToCode(theme);

  List<PanacheTheme> get themes => _themes;

  String get uuid => _uuid.generateV4();

  Map<String, dynamic> get panelStates => localData.panelStates;

  double get scrollPosition => localData.scrollPosition;

  ThemeModel({
    @required ThemeService service,
    @required this.localData,
  })  : _service = service,
        //_cloudService = cloudService,
        _themes = localData.themes {
    _service.init(onChange);
  }

  void newTheme({
    @required MaterialColor primarySwatch,
    Brightness brightness: Brightness.light,
  }) {
    assert(primarySwatch != null);
    final defaultThemeName = 'new-theme';
    _currentTheme = PanacheTheme(
      id: uuid,
      name: defaultThemeName,
      primarySwatch: primarySwatch,
      brightness: brightness,
    );

    _service.initTheme(primarySwatch: primarySwatch, brightness: brightness);

    _themes.add(_currentTheme);
    localData.updateThemeList(_themes);

    print('CursorColor: ${_service.theme.textSelectionTheme.cursorColor}');
    print('SelectionColor: ${_service.theme.textSelectionTheme.selectionColor}');
    print('SelectionHandleColor: ${_service.theme.textSelectionTheme.selectionHandleColor}');

    notifyListeners();
  }

  onChange() => notifyListeners();

  void updateTheme(ThemeData updatedTheme) {
    _service.updateTheme(updatedTheme);

    print('CursorColor: ${updatedTheme.textSelectionTheme.cursorColor}');
    print('SelectionColor: ${updatedTheme.textSelectionTheme.selectionColor}');
    print('SelectionHandleColor: ${updatedTheme.textSelectionTheme.selectionHandleColor}');
    notifyListeners();
  }

  void updateColor({String property, Color color}) {
    print(color);
    print(property);

    final args = <Symbol, dynamic>{};
    args[Symbol(property)] = color;
    final updatedTheme = Function.apply(theme.copyWith, null, args);
    updateTheme(updatedTheme);
  }

  deleteTheme(PanacheTheme theme) async {
    localData.deleteTheme(theme);
    _themes.remove(theme);

    notifyListeners();
  }

  String themeDataPath(PanacheTheme theme) => '${_service.dir?.path ?? ''}/themes/${theme.id}.json';

  void saveEditorState(Map<String, bool> panelStates, double pixels) => localData.saveEditorState(panelStates, pixels);

  void saveScrollPosition(double pixels) => localData.saveScrollPosition(pixels);
}
