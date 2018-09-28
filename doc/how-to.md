# How to Share a Theme between Flutter and the Web

This how-to will get you set up with a project that has a light and dark theme that work both in Flutter and on the Web.

You should have [Flutter][1] and the the [Dart SDK][2] installed and accessible on your system's path,  with `webdev` and `stagehand` activated by pub ([instructions][3]).

> Although AngularDart is used in this guide, the CSS generated here  can be used without it.

**TL;DR**: See a complete example [here][5].

Two new packages are introduced, [shared_theme][18] and [shared_theme_flutter][19].

## Contents

1. [Getting Started](#Getting_Started)
    1. [Generate the Packages](#Generate_the_Packages)
    2. [Add Dependencies](#Add_Dependencies)
    3. [Name the App](#Name_the_App)
2. [Create Your Themes](#Create_Your_Themes)
    1. [Choose Brand Colors](#Choose_Brand_Colors)
3. [Try it](#Try_it)
    1. [Run the Flutter App](#Run_the_Flutter_App)
    2. [Run the Web App](#Run_the_Web_App)
        1. [First Run](#First_Run)
        1. [Subsequent Runs](#Subsequent_Runs)
4. [Adding Elements](#Adding_Elements)
5. [Adding Fonts and Assets](#Adding_Fonts_and_Assets)
6. [Screenshots](#Screenshots)

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
  shared_preferences: ^0.4.2    # For persisting theme preference.
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

Replace the contents of `mobile/lib/main.dart` with the example [here][6]. Be sure to replace "`<project_name>`" in the imports with the name of your base package.

Run the example by using `flutter run` or the equivalent in your IDE.

<a name="Run_the_Web_App"></a>
### Run the Web App

<a name="First_Run"></a>
#### First Run

Before running the web project for the first time, several files have to be modified or created. They are described by the following table, which links to each file in the [gist][7].

File | Description
-|-
[`bin/build_themes.dart`][8] | Script to generate `lib/src/_themes.g.scss`.
[`web/index.html`][9] | Add small script to load saved theme.
[`web/styles.scss`][10] | Global styles for the web app.
[`lib/app_component.dart`][11] | The main component of the app.
[`lib/app_component.html`][12] | The main component of the app.
[`lib/app_component.scss`][13] | The main component of the app.
[`lib/src/example_list/example_list.dart`][14] | Demo of current theme.
[`lib/src/example_list/example_list.html`][15] | Demo of current theme.
[`lib/src/example_list/example_list.scss`][16] | Demo of current theme.

Be sure to replace any occurrences of "`<project_name>`" with the name of your base package, or for the case of `index.html`, your app's name.

Generate your initial themes file and start the local server.

```sh
> pub run build_themes.dart
> webdev serve
```

<a name="Subsequent_Runs"></a>
#### Subsequent Runs

Since `webdev serve` runs indefinitely, it helps to have a second terminal open and run `pub run theme_builder.dart` any time you make theme changes in the base package. The webdev server will then pickup those changes automatically.

<a name="Adding_Elements"></a>
## Adding Elements

The theme looks pretty good so far, but those buttons and input field in the demos are bare. Let's add some elements to the theme.

Add the following to the bottom of `base/lib/themes.dart`.

```dart
class _ButtonBase extends Element {
  _ButtonBase({
    Color color,
    Font font,
    ShadowElevation shadow: ShadowElevation.none,
  }) : super(
          align: TextAlign.center,
          padding: BoxSpacing.symmetric(vertical: 4.0, horizontal: 8.0),
          border: Border(radii: BorderRadius(4.0)),
          font: font,
          shadow: shadow,
          color: color,
        );
}
final _elements = ElementSet(
  primaryButton: _ButtonBase(
      color: _lightColors.secondary.color,
      font: FontSet.dark.button
          .copyWith(color: _lightColors.secondary.contrast, size: 16.0),
      shadow: ShadowElevation.dp8),
  secondaryButton: _ButtonBase(
      color: _lightColors.primary.color,
      font: FontSet.dark.button.copyWith(color: _lightColors.primary.contrast)),
  inputBase: Element.outlineInput,
);
```

Now your themeset declaration should look like this.

```dart
final themeset = ThemeSet(themes: [
  Theme(
      name: 'Light',
      brightness: Brightness.light,
      colors: _lightColors,
      fonts: FontSet.dark,
      elements: _elements),
  Theme(
      name: 'Dark',
      brightness: Brightness.dark,
      colors: _darkColors,
      fonts: FontSet.light,
      elements: _elements),
]);
```

Hot-restart your Flutter app and `pub run build_themes.dart` in your web app to see the changes!

<a name="Adding_Fonts_and_Assets"></a>
## Adding Fonts and Assets

To see how to use custom fonts and shared assets, see [themes.dart][17] from the `shared_theme` package's example.


<a name="Screenshots"></a>
## Screenshots

Mobile light | Mobile dark
-|-
![mobile-light][20] | ![mobile-dark][21]

Web light | Web dark
-|-
![web-light][22] | ![web-dark][23]

[1]: https://flutter.io/get-started/install
[2]: https://webdev.dartlang.org/guides/get-started#2-install-dart
[3]: https://webdev.dartlang.org/guides/get-started#3-get-cli-tools-or-webstorm-or-both
[4]: https://material.io/tools/color/#!/?view.left=0&view.right=0&primary.color=009688&secondary.color=FF6D00
[5]: https://github.com/jifalops/shared_theme/tree/master/example
[6]: https://gist.github.com/jifalops/4db10fb8b8b22b2896e8adac24938c33#file-main-dart
[7]: https://gist.github.com/jifalops/ca4b209936637df8fb6e28118ce11ce2
[8]: https://gist.github.com/jifalops/ca4b209936637df8fb6e28118ce11ce2#file-bin-build_themes-dart
[9]: https://gist.github.com/jifalops/ca4b209936637df8fb6e28118ce11ce2#file-web-index-html
[10]: https://gist.github.com/jifalops/ca4b209936637df8fb6e28118ce11ce2#file-web-styles-scss
[11]: https://gist.github.com/jifalops/ca4b209936637df8fb6e28118ce11ce2#file-lib-app_component-dart
[12]: https://gist.github.com/jifalops/ca4b209936637df8fb6e28118ce11ce2#file-lib-app_component-html
[13]: https://gist.github.com/jifalops/ca4b209936637df8fb6e28118ce11ce2#file-lib-app_component-scss
[14]: https://gist.github.com/jifalops/ca4b209936637df8fb6e28118ce11ce2#file-lib-src-example_list-example_list-dart
[15]: https://gist.github.com/jifalops/ca4b209936637df8fb6e28118ce11ce2#file-lib-src-example_list-example_list-html
[16]: https://gist.github.com/jifalops/ca4b209936637df8fb6e28118ce11ce2#file-lib-src-example_list-example_list-scss
[17]: https://github.com/jifalops/shared_theme/blob/master/example/packages/base/lib/themes.dart
[18]: https://pub.dartlang.org/packages/shared_theme
[19]: https://pub.dartlang.org/packages/shared_theme_flutter
[20]: https://github.com/jifalops/shared_theme/blob/master/example/images/mobile-light.png
[21]: https://github.com/jifalops/shared_theme/blob/master/example/images/mobile-dark.png
[22]: https://github.com/jifalops/shared_theme/blob/master/example/images/web-light.png
[23]: https://github.com/jifalops/shared_theme/blob/master/example/images/web-dark.png