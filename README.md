# Shared Theme

Easily share a theme between Flutter and the web.

## Theme

A `Theme` is a `ColorSet`, `FontSet`, and an `ElementSet`, which
are abstract containers for defining properties such as border, padding, etc.

## ThemeSet

Themes are typically combined into a single `ThemeSet` per application. The
ThemeSet adds support for bundled `FontFace`s, and `ThemeSet.toString()`
returns an SCSS string that fully represents the ThemeSet.

## Example

There is a [complete example](https://github.com/jifalops/shared_theme/tree/master/example)
included, and in particular, see its
[ThemeSet definition](https://github.com/jifalops/shared_theme/blob/master/example/packages/base/lib/themes.dart).

<!-- ## [Tutorial, How-to, and explanation](doc/) -->

## Screenshots

Mobile light | Mobile dark
-|-
![mobile-light](https://github.com/jifalops/shared_theme/tree/master/example/images/mobile-light.png) | ![mobile-dark](https://github.com/jifalops/shared_theme/tree/master/example/images/mobile-dark.png)

Web light | Web dark
-|-
![web-light](https://github.com/jifalops/shared_theme/tree/master/example/images/web-light.png) | ![web-dark](https://github.com/jifalops/shared_theme/tree/master/example/images/web-dark.png)

