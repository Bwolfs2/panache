import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import 'logo.dart';
import 'new_theme_panel.dart';

class LaunchLayout extends StatelessWidget {
  final ThemeModel model;
  final bool editMode;
  final ColorSwatch newThemePrimary;
  final Brightness initialBrightness;
  final void Function(ColorSwatch value) onSwatchSelection;
  final void Function(Brightness value) onBrightnessSelection;
  final Function(ThemeModel model) newTheme;
  final VoidCallback toggleEditMode;
  final List<Widget> Function(List<PanacheTheme> themes, {String basePath, Size size}) buildThemeThumbs;

  const LaunchLayout({Key key, this.model, this.editMode, this.newThemePrimary, this.initialBrightness, this.onSwatchSelection, this.onBrightnessSelection, this.newTheme, this.toggleEditMode, this.buildThemeThumbs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        print('LaunchLayout.build => constraints $constraints');
        return _buildDefaultLayout(context, model, constraints);
      },
    );
  }

  Column _buildDefaultLayout(BuildContext context, ThemeModel model, BoxConstraints constraints) {
    final useLargeLayout = constraints.biggest.height >= 700;

    final orientation = MediaQuery.of(context).orientation;
    final inPortrait = orientation == Orientation.portrait;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 60),
          child: PanacheLogo(
            minimized: !inPortrait && !useLargeLayout,
          ),
        ),
        ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: 520),
          child: NewThemePanel(
            orientation: orientation,
            newThemePrimary: newThemePrimary,
            initialBrightness: initialBrightness,
            onSwatchSelection: onSwatchSelection,
            onBrightnessSelection: onBrightnessSelection,
            onNewTheme: () => newTheme(model),
          ),
        ),
      ],
    );
  }
}
