import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:panache_core/panache_core.dart';
import 'package:panache_ui/panache_ui.dart';
import 'package:scoped_model/scoped_model.dart';

import 'src/web_local_data.dart';
import 'src/web_theme_service.dart';

void main() async {
  clearPersisted();
  final localData = WebLocalData();

  final themeModel = ThemeModel(
    localData: localData,
    service: WebThemeService(),
  );

  runApp(PanacheApp(themeModel: themeModel));
}

class PanacheApp extends StatelessWidget {
  final ThemeModel themeModel;

  const PanacheApp({Key key, @required this.themeModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<ThemeModel>(
      model: themeModel,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: buildAppTheme(Theme.of(context), panachePrimarySwatch),
        home: PanacheEditorScreen(),
      ),
    );
  }
}
