import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';
import 'package:scoped_model/scoped_model.dart';

import '../preview/app_preview.dart';
import 'panels/editor_topbar_web.dart';
import 'theme_editor.dart';

class PanacheEditorScreen extends StatefulWidget {
  @override
  PanacheEditorScreenState createState() {
    return PanacheEditorScreenState();
  }
}

class PanacheEditorScreenState extends State<PanacheEditorScreen> {
  bool showCode = false;
  bool initialized = false;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ThemeModel>(builder: (context, child, model) {
      if (!initialized) {
        model.newTheme(primarySwatch: Colors.blue, brightness: Brightness.light);
        initialized = true;
      }

      return _buildLargeLayout(
        model,
        WebPanacheEditorTopbar(
          model: model,
          showCode: showCode,
          onShowCodeChanged: (value) => setState(() => showCode = value),
        ),
      );
    });
  }

  Scaffold _buildLargeLayout(ThemeModel model, Widget topbar) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: topbar,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: ThemeEditor(model: model)),
          Expanded(child: AppPreviewContainer(kIPhone6, showCode: showCode)),
        ],
      ),
    );
  }
}
