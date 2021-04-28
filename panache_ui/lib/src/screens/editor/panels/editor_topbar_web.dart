import 'package:flutter/material.dart';
import 'package:panache_core/panache_core.dart';

class WebPanacheEditorTopbar extends StatelessWidget implements PreferredSizeWidget {
  final ThemeModel model;
  final bool showCode;
  final ValueChanged<bool> onShowCodeChanged;

  WebPanacheEditorTopbar({this.model, this.showCode, this.onShowCodeChanged});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final title = Text.rich(TextSpan(text: 'Panache', children: [
      TextSpan(text: ' Flutterando', style: textTheme.caption.copyWith(color: Colors.blueGrey.shade900))
    ]));

    return AppBar(
      title: title,
      actions: <Widget>[
        TextButton.icon(
          icon: Icon(Icons.mobile_screen_share),
          label: Text(
            'App preview',
            style: TextStyle(color: Colors.blueGrey.shade50),
          ),
          onPressed: showCode ? () => onShowCodeChanged(false) : null,
        ),
        TextButton.icon(
          icon: Icon(Icons.keyboard),
          label: Text('Code preview', style: TextStyle(color: Colors.blueGrey.shade50)),
          onPressed: showCode ? null : () => onShowCodeChanged(true),
        ),
        SizedBox(
          width: 50,
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
