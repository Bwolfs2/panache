import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

import 'controls/brightness_control.dart';
import 'controls/color_selector.dart';

class GlobalThemePropertiesControl extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = ThemeModel.of(context);

    final isDark = model.theme.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: ColorSelector(
              'Primary swatch',
              model.theme.primaryColor,
              (color) => _onSwatchSelection(model, swatchFor(color: color)),
              padding: 0,
            ),
          ),
          SizedBox(width: 10),
          BrightnessSelector(
            isDark: isDark,
            label: 'Brightness',
            onBrightnessChanged: (value) => _onBrightnessChanged(model, value),
          ),
        ],
      ),
    );
  }

  void _onBrightnessChanged(ThemeModel model, Brightness brightness) {
    var primarySwatch = model.primarySwatch ??
        swatchFor(
          color: model.theme.primaryColor,
        );
    model.updateTheme(ThemeData.localize(
      //TODO: ThemeData Change
      ThemeData(
        primarySwatch: model.primarySwatch ??
            swatchFor(
              color: model.theme.primaryColor,
            ),
        brightness: brightness,
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: primarySwatch[100],
          selectionColor: primarySwatch[300],
          selectionHandleColor: primarySwatch[600],
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: primarySwatch[600],
        ),
      ),

      model.theme.textTheme,
    ));
  }

  void _onSwatchSelection(ThemeModel model, MaterialColor swatch) {
    model.updateTheme(ThemeData.localize(
        //TODO: ThemeData Change
        ThemeData(
          primarySwatch: swatch,
          brightness: model.theme.brightness,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: swatch[100],
            selectionColor: swatch[300],
            selectionHandleColor: swatch[600],
          ),
          inputDecorationTheme: InputDecorationTheme(
            fillColor: swatch[600],
          ),
        ),
        model.theme.textTheme));
  }
}
