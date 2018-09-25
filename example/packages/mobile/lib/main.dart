import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sharedtheme_example/config.dart';
import 'package:sharedtheme_example/themes.dart';
import 'package:shared_theme_flutter/shared_theme_flutter.dart' as themer;

void main() => runApp(App());

class App extends StatefulWidget {
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  themer.Theme theme;

  @override
  void initState() {
    super.initState();
    _setTheme(themeset.themes.first);
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: appName,
        theme: themer.themeData(theme),
        home: Scaffold(
          appBar: AppBar(
              title: Text(appName,
                  style: themer.textStyle(theme.fonts.title).copyWith(
                      color: Color(theme.colors.primary.contrast.argb))),
              actions: <Widget>[
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Dark',
                        style: themer.textStyle(theme.fonts.title).copyWith(
                            color: Color(theme.colors.primary.contrast.argb)),
                      ),
                      Switch(
                          value: theme == themeset.themes.last,
                          onChanged: (enabled) => setState(() => _setTheme(
                              enabled
                                  ? themeset.themes.last
                                  : themeset.themes.first)))
                    ])
              ]),
          body: Padding(
              padding: EdgeInsets.all(8.0),
              child: ListView(
                children: <Widget>[DemoItems()],
              )),
        ),
      );

  void _setTheme(themer.Theme t) {
    theme = t;
    themer.setTheme(theme);
  }
}

class DemoItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = themer.currentTheme;
    void _showSnackBar() => Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("I'm a SnackBar.")));
    Widget _colorWidget(themer.ContrastingColors colors, String text) =>
        Container(
            alignment: Alignment.center,
            height: 56.0,
            width: 256.0,
            color: themer.getColor(colors, Theme.of(context).backgroundColor),
            child: Text(text,
                style: Theme.of(context).textTheme.body2.copyWith(
                    color: themer.getContrast(
                        colors, Theme.of(context).textTheme.body2.color))));
print(MediaQueryData().devicePixelRatio);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            width: 160.0,
            color: Colors.red,
            child:  Text(
                  'Tj|',
                  style: TextStyle(fontSize: 160.0),
                )),
        Text('Display4', style: Theme.of(context).textTheme.display4),
        Text('Display3', style: Theme.of(context).textTheme.display3),
        Text('Display2', style: Theme.of(context).textTheme.display2),
        Text('Display1', style: Theme.of(context).textTheme.display1),
        Text('Headline', style: Theme.of(context).textTheme.headline),
        Text('Title', style: Theme.of(context).textTheme.title),
        Text('Subhead', style: Theme.of(context).textTheme.subhead),
        Text('Body2', style: Theme.of(context).textTheme.body2),
        Text('Body1', style: Theme.of(context).textTheme.body1),
        Text('Button', style: Theme.of(context).textTheme.button),
        Text('Caption', style: Theme.of(context).textTheme.caption),
        _colorWidget(theme.colors.primary, 'Primary'),
        _colorWidget(theme.colors.primaryLight, 'Primary Light'),
        _colorWidget(theme.colors.primaryDark, 'Primary Dark'),
        _colorWidget(theme.colors.secondary, 'Secondary ("Accent")'),
        _colorWidget(theme.colors.secondaryLight, 'Secondary Light'),
        _colorWidget(theme.colors.secondaryDark, 'Secondary Dark'),
        _colorWidget(theme.colors.background, 'Background'),
        _colorWidget(theme.colors.background.invert(), 'Background (inverted)'),
        _colorWidget(theme.colors.surface, 'Surface'),
        _colorWidget(theme.colors.surface.invert(), 'Surface (inverted)'),
        _colorWidget(theme.colors.divider, 'Divider'),
        _colorWidget(theme.colors.error, 'Error'),
        _colorWidget(theme.colors.notice, 'Notice'),
        _colorWidget(theme.colors.indicator, 'Indicator'),
        _colorWidget(theme.colors.hint, 'Hint'),
        _colorWidget(theme.colors.selectedRow, 'SelectedRow'),
        _colorWidget(theme.colors.highlight, 'Highlight'),
        _colorWidget(theme.colors.splash, 'Splash'),
        themer.primaryButton(_showSnackBar, text: 'Primary Button'),
        themer.secondaryButton(_showSnackBar, text: 'Secondary Button'),
        themer.tertiaryButton(_showSnackBar, text: 'Tertiary Button'),
        themer.wrapInput(
            TextField(decoration: InputDecoration(labelText: 'Input'))),
      ],
    );
  }
}
