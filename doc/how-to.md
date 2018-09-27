# How to Share a Theme between Flutter and the Web

This guide will walk you through setting up a project with themes that can be used in Flutter and on the Web. It assumes you have [Flutter][1] and the the [Dart SDK][2] installed and accessible on your system's path,  with `webdev` and `stagehand` activated by pub ([instructions][3]).

> Although AngularDart is used in this guide, the CSS generated here  can be used without it.

**TL;DR**: See a complete example [here][5].

## Contents

1. [Getting Started](#Getting_Started)

    1.1 [Generate the Packages](#Generate_the_Packages)

    1.2 [Add Dependencies](#Add_Dependencies)

    1.3 [Name the App](#Name_the_App)

2. [Create Your Themes](#Create_Your_Themes)

    2.1. [Choose Brand Colors](#Choose_Brand_Colors)

3. [Try it](#Try_it)

    3.1. [Run the Flutter App](#Run_the_Flutter_App)

    3.2. [Run the Web App](#Run_the_Web_App)

        3.2.1. [First_Run](#First_Run)

<a name="Getting_Started"></a>
## Getting Started

Your project will need three packages, one each for Flutter and the web, and a base package they will share.

Create this minimal directory structure, and add READMEs etc. as you see fit.

```
<project_name>
  packages/
    <project_name>/
    <project_name>_mobile/
    <project_name>_web/
```

<a name="Generate_the_Packages"></a>
### Generate the Packages

The name of each package directory will be the name of the generated package. Afterwards we'll rename the directories to make things simpler.

> Before doing this you may want to ensure your version of `stagehand` and `flutter` are up to date.
> ```
> > pub global activate stagehand
> > flutter upgrade
> ```

1. Generate the base package by entering the following from  the `packages/<project_name>` directory.

    ```sh
    > stagehand package-simple
    > pub get
    ```

   *Delete everything inside the generated `lib/` directory, we're going to create our own files.*

2. Generate the web package by entering the following from the `packages/<project_name>_web` directory.

    ```sh
    > stagehand web-angular
    > pub get
    ```

3. Generate the mobile package by entering the following from the `packages/<project_name>_mobile` directory.

    ```sh
    > flutter create .
    ```

Now that the packages have been created with their desired names, we can rename the directories to make things easier.

```
<project_name>
  packages/
    base/
    mobile/
    web/
```

<a name="Add_Dependencies"></a>
### Add Dependencies

Add the following dependencies to each package. Do not delete the existing ones.

> Be sure to use the latest version of each dependency. A quick way to check is to add the dependency without a version constraint, and then check the version that is added to the `.packages` file.

In the base project's `pubspec.yaml`, add the following dependency.

```
dependencies:
  shared_theme: ^0.1.2
```

For the mobile package, add these dependencies.

```
dependencies:
  <project_name>:
    path: ../base
  shared_theme_flutter: ^0.1.2
```

The web packages requires a dev dependency as well.

```
dependencies:
  <project_name>:
    path: ../base

dev_dependencies:
  sass_builder: ^2.1.1
```

<a name="Name_the_App"></a>
### Name the App

Since both apps are going to use the same user-facing name let's define it in `base/lib/config.dart`.

```dart
const appName = 'My Awesome App';
```


<a name="Create_Your_Themes"></a>
## Create Your Themes

Create the file `packages/base/lib/themes.dart` and add the following to it.

```dart
import 'package:shared_theme/shared_theme.dart';

final themeset = ThemeSet(themes: [
  Theme(
    name: 'Light',
    brightness: Brightness.light,
    colors: ColorSet(),
    fonts: FontSet.dark,
    elements: ElementSet()
  ),
  Theme(
    name: 'Dark',
    brightness: Brightness.dark,
    colors: ColorSet(),
    fonts: FontSet.light,
    elements: ElementSet()
  ),
]);
```

<a name="Choose_Brand_Colors"></a>
### Choose Brand Colors

You'll notice a `ColorSet` requires at least a few colors, so for this example we picked some using the material color tool. You can see them [here][4].

Add the following light and dark theme colors to `themes.dart`.

```dart
// See the theme at https://material.io/tools/color/#!/?view.left=0&view.right=0&primary.color=009688&secondary.color=FF6D00
const _primary = ContrastingColors(Color(0xFF009688), Colors.black);
const _primaryLight = ContrastingColors(Color(0xFF52c7b8), Colors.black);
const _primaryDark = ContrastingColors(Color(0xFF00675b), Colors.white);
const _secondary = ContrastingColors(Color(0xFFff6d00), Colors.black);
const _secondaryLight = ContrastingColors(Color(0xFFff9e40), Colors.black);
const _secondaryDark = ContrastingColors(Color(0xFFc43c00), Colors.white);
const _error = ContrastingColors(Colors.error, Colors.onError);

const _lightColors = _ThemeColors(
  background: ContrastingColors(Color(0xFFfefefe), Colors.black),
  surface: ContrastingColors(Color(0xFFfefefe), Colors.black),
  divider: ContrastingColors(Color(0xFFeeeeee), Colors.black),
);

const _darkColors = _ThemeColors(
  background: ContrastingColors(Color(0xFF333333), Colors.white),
  surface: ContrastingColors(Color(0xFF333333), Colors.white),
  divider: ContrastingColors(Color(0xFF484848), Colors.white),
);

/// Makes using shared colors easier.
class _ThemeColors extends ColorSet {
  const _ThemeColors({
    ContrastingColors background,
    ContrastingColors surface,
    ContrastingColors divider,
  }) : super(
          primary: _primary,
          primaryLight: _primaryLight,
          primaryDark: _primaryDark,
          secondary: _secondary,
          secondaryLight: _secondaryLight,
          secondaryDark: _secondaryDark,
          error: _error,
          background: background,
          scaffold: surface,
          dialog: surface,
          card: surface,
          divider: divider,
          selectedRow: divider,
          indicator: _secondary,
          textSelection: _primaryLight,
          textSelectionHandle: _primaryDark,
        );
}
```

> The brand colors are declared as private constants so they can be used in various places as constructor arguments.

Now change your `themeset` declaration to use `_lightColors` and `_darkColors`.

<a name="Try_it"></a>
## Try it

<a name="Run_the_Flutter_App"></a>
### Run the Flutter App

Replace `packages/mobile/lib/main.dart` with the following and run it using `flutter run` or your IDE. Be sure to replace `<project_name>` with your base package's name.

```dart
import 'package:flutter/material.dart';
import 'package:<project_name>/config.dart';
import 'package:<project_name>/themes.dart';
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
                      color: themer.contrastOf(theme.colors.primary))),
              actions: <Widget>[_buildThemeSwitch()]),
          body: Padding(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(child: DemoItems()),
          ),
        ),
      );

  void _setTheme(themer.Theme t) {
    theme = t;
    themer.currentTheme = t;
  }

  Widget _buildThemeSwitch() =>
      Row(crossAxisAlignment: CrossAxisAlignment.center, children: <Widget>[
        Text(
          'Dark',
          style: themer.textStyleColored(
              theme.fonts.title, themer.contrastOf(theme.colors.primary)),
        ),
        Switch(
          value: theme.brightness == themer.Brightness.dark,
          onChanged: (enabled) => _toggleTheme(),
        )
      ]);

  void _toggleTheme() {
    setState(() => _setTheme(theme == themeset.themes.first
        ? themeset.themes.last
        : themeset.themes.first));
  }
}

class DemoItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = themer.currentTheme;
    void _showSnackBar() => Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text("I'm a SnackBar.")));
    Widget _colorWidget(themer.ContrastingColors colors, String text) =>
        _buildColorWidget(context, colors, text);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
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
        _colorWidget(theme.colors.card, 'Card'),
        _colorWidget(theme.colors.divider, 'Divider'),
        _colorWidget(theme.colors.error, 'Error'),
        SizedBox(height: 12.0),
        themer.primaryButton(_showSnackBar, text: 'Primary Button'),
        SizedBox(height: 12.0),
        themer.secondaryButton(_showSnackBar, text: 'Secondary Button'),
        themer.wrapInput(
            TextField(decoration: InputDecoration(labelText: 'Input'))),
      ],
    );
  }

  Widget _buildColorWidget(
          BuildContext context, themer.ContrastingColors colors, String text) =>
      Container(
          alignment: Alignment.center,
          height: 56.0,
          width: 256.0,
          color: themer.colorOf(colors, Theme.of(context).backgroundColor),
          child: Text(text,
              style: Theme.of(context).textTheme.body2.copyWith(
                  color: themer.contrastOf(
                      colors, Theme.of(context).textTheme.body2.color))));
}
```

<a name="Run_the_Web_App"></a>
### Run the Web App

<a name="First_Run"></a>
#### First Run





[1]: https://flutter.io/get-started/install
[2]: https://webdev.dartlang.org/guides/get-started#2-install-dart
[3]: https://webdev.dartlang.org/guides/get-started#3-get-cli-tools-or-webstorm-or-both
[4]: https://material.io/tools/color/#!/?view.left=0&view.right=0&primary.color=009688&secondary.color=FF6D00
[5]: https://github.com/jifalops/shared_theme/tree/master/example