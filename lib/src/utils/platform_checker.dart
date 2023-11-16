import 'package:flutter/foundation.dart'
    show
        TargetPlatform,
        immutable,
        kIsWeb,
        visibleForTesting,
        defaultTargetPlatform;

/// A utility that help you to check the current running platform
///
/// With it you can check if you want check if the running platform is Android for example
/// is it Android running on browser or a separated app
///
/// Why we have this logic??
/// to better support all the platforms
///
/// for example you want to use `Cupertino` for Apple Platforms
/// and `Material` for Android and other platforms
/// The question does it matter if it running on a web or separated native app??
///
/// if yes then you should pass false [shouldItWeb] or use [PlatformChecker.nativePlatform]
///
/// if not which is in this case
/// then pass true or use [PlatformChecker.defaultLogic] to save you some time
///
/// the properties [overrideTargetPlatform] and [overrideIsWeb] used only for testing
@immutable
class PlatformChecker {
  const PlatformChecker({
    required this.shouldItWeb,
    @visibleForTesting this.overrideIsWeb,
    @visibleForTesting this.overrideTargetPlatform,
  });
  factory PlatformChecker.nativePlatform() => _nativePlatform;
  factory PlatformChecker.defaultLogic() => _defaultLogic;
  static const PlatformChecker _nativePlatform =
      PlatformChecker(shouldItWeb: false);
  static const PlatformChecker _defaultLogic =
      PlatformChecker(shouldItWeb: true);

  /// Should we care if the platform is running on web browser or only native apps?
  ///
  /// if true then it will check the platform no matter what
  /// if false then it will check the platform and make sure it's not running on web browser
  ///
  /// Example usage when you want to do some logic for mobile since the mobile apps
  /// are sandboxed unlike desktop and web apps
  ///
  /// so you really want to execute that logic only for mobile apps and not web browser
  final bool shouldItWeb;

  @visibleForTesting
  final bool? overrideIsWeb;
  @visibleForTesting
  final TargetPlatform? overrideTargetPlatform;

  /// is the current running app in web browser??
  bool isWeb() => overrideIsWeb ?? kIsWeb;

  /// Shared logic between all methods
  bool get _sharedShouldReturnFalse => isWeb() && !shouldItWeb;

  /// Shared logic between all methods
  TargetPlatform get _defaultTargetPlatform => defaultTargetPlatform;

  /// Apple platforms
  static const applePlatforms = [
    TargetPlatform.iOS,
    TargetPlatform.macOS,
  ];

  /// Is the current running platform is Apple System??
  bool isAppleSystem({TargetPlatform? platform}) {
    if (_sharedShouldReturnFalse) return false;
    platform ??= _defaultTargetPlatform;
    return applePlatforms.contains(overrideTargetPlatform ?? platform);
  }

  /// Used to check if the current running platform is iOS device
  bool isIOS({TargetPlatform? platform}) {
    if (_sharedShouldReturnFalse) return false;
    platform ??= _defaultTargetPlatform;
    return (overrideTargetPlatform ?? platform) == TargetPlatform.iOS;
  }

  /// Used to check if the current running platform is Android device
  bool isAndroid({TargetPlatform? platform}) {
    if (_sharedShouldReturnFalse) return false;
    platform ??= _defaultTargetPlatform;
    return (overrideTargetPlatform ?? platform) == TargetPlatform.android;
  }

  /// Used to check if the current running platform is Fuchsia device
  bool isFuchsia({TargetPlatform? platform}) {
    if (_sharedShouldReturnFalse) return false;
    platform ??= _defaultTargetPlatform;
    return (overrideTargetPlatform ?? platform) == TargetPlatform.fuchsia;
  }

  /// Mobile platforms
  static const mobilePlatforms = [
    TargetPlatform.android,
    TargetPlatform.iOS,
    // Could be considered as a mobile
    TargetPlatform.fuchsia,
  ];

  /// Used to check if the current running device is a mobile
  bool isMobile({TargetPlatform? platform}) {
    if (_sharedShouldReturnFalse) return false;
    platform ??= _defaultTargetPlatform;
    return mobilePlatforms.contains(overrideTargetPlatform ?? platform);
  }

  static const desktopPlatforms = [
    TargetPlatform.linux,
    TargetPlatform.macOS,
    TargetPlatform.windows,
  ];

  /// Used to check if the current running device is a desktop or laptop device
  ///
  /// like Windows, macOS, Linux
  bool isDesktop({TargetPlatform? platform}) {
    if (_sharedShouldReturnFalse) return false;
    platform ??= _defaultTargetPlatform;
    return desktopPlatforms.contains(overrideTargetPlatform ?? platform);
  }
}
