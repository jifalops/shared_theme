# sharedtheme_example_web

This is the Web version of the app. It has several changes from the default `stagehand web-angular` setup:

File | Changes
-|-
[`pubspec.yaml`](pubspec.yaml) | Add `sass_builder` as a dev dependency, which compiles *.scss files to *.css for `webdev serve` and `webdev build`.
[`web/index.html`](web/index.html) | A simple script was added to set the theme without waiting for Angular to load.
[`web/styles.css`](web/styles.scss) | Renamed to `styles.scss` and rewritten. All styles here are global and pierce component boundaries.
[`bin/build_themes.dart`](bin/build_themes.dart) | Created this file to generate the web app's themes. Use `pub run theme_builder.dart` from the root of the web package to run it. It takes the themes in `../base/lib/themes.dart` and compiles them into `./lib/src/_themes.g.scss`.
[`lib/`](lib/) | Modified the default example components to create the example you see here.

## Workflow

While building the example I found it easiest to have two terminals open. The first terminal is for `webdev serve` to run indefinitely on, and the second terminal is for running `pub run theme_builder.dart` to update the themes file if you make changes in the base package. The webdev server will then pickup those changes.

Also Webstorm currently has better support (than VS Code) for auto-completing all the mixins and class names from `_themes.g.scss` and whatever other Sass files you might import, but it does tend to think SCSS imports are wrong if they use the `@import 'package:...';` scheme.