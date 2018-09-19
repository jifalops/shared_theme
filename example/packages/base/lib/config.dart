import 'package:meta/meta.dart';

/// Shorthand for [BuildConfig.instance].
BuildConfig get config => BuildConfig.instance;

/// Configuration for the current flavor of the app
/// (e.g. production, development, staging).
class BuildConfig {
  BuildConfig._({
    @required this.flavor,
    @required this.appName,
    @required this.cacheName,
  });

  /// The type of configuration
  final BuildFlavor flavor;

  /// The app's name/title
  final String appName;

  /// The name of the service worker cache.
  final String cacheName;

  static BuildConfig instance;

  /// Sets up the top-level [config] getter on the first call only.
  static void init({
    String appName: 'Shared Theme Example',
    @required String cacheName,
    @required BuildFlavor flavor,
  }) =>
      instance ??= BuildConfig._(
        flavor: flavor,
        appName: appName,
        cacheName: cacheName,
      );
}

enum BuildFlavor { production, development, staging }
