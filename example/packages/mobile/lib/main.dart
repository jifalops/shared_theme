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
        appBar: AppBar(title: Text(appName)),
        body: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Dark theme'),
                    Switch(
                        value: theme == themeset.themes.last,
                        onChanged: (enabled) => setState(() => _setTheme(enabled
                            ? themeset.themes.last
                            : themeset.themes.first)))
                  ]),
              DemoItems(),
            ],
          ),
        ),
      ));

  void _setTheme(themer.Theme t) {
    theme = t;
    themer.setTheme(theme);
  }
}

class DemoItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showSnackBar() => Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("I'm a SnackBar.")));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
        themer.primaryButton(_showSnackBar, text: 'Primary'),
        themer.secondaryButton(_showSnackBar, text: 'Secondary'),
        themer.tertiaryButton(_showSnackBar, text: 'Tertiary'),
        themer.inputWidget(
            TextField(decoration: InputDecoration(labelText: 'Input'))),
        SizedBox(height: 24.0),
        Text('Default Widgets:'),
        RaisedButton(onPressed: _showSnackBar, child: Text('Raised')),
        FlatButton(onPressed: _showSnackBar, child: Text('Flat')),
        TextField(decoration: InputDecoration(labelText: 'Input')),
      ],
    );
  }
}
