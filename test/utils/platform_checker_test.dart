import 'package:flutter/foundation.dart' show TargetPlatform;
import 'package:fresh_base_package/fresh_base_package.dart';
import 'package:test/test.dart';

void main() {
  group('Test Platform Checking Logic', () {
    var platform = TargetPlatform.linux;
    test('Check isDesktop()', () {
      platform = TargetPlatform.android;
      expect(
        PlatformChecker.defaultLogic().isDesktop(
          platform: platform,
        ),
        false,
      );

      for (final desktopPlatform in [
        TargetPlatform.macOS,
        TargetPlatform.linux,
        TargetPlatform.windows
      ]) {
        expect(
          const PlatformChecker(shouldItWeb: false, overrideIsWeb: false)
              .isDesktop(
            platform: desktopPlatform,
          ),
          true,
        );

        expect(
          const PlatformChecker(shouldItWeb: false, overrideIsWeb: true)
              .isDesktop(
            platform: desktopPlatform,
          ),
          false,
        );

        expect(
          const PlatformChecker(shouldItWeb: true, overrideIsWeb: true)
              .isDesktop(
            platform: desktopPlatform,
          ),
          true,
        );
      }
    });
    test('Check isMobile()', () {
      platform = TargetPlatform.macOS;
      expect(
        PlatformChecker.defaultLogic().isMobile(
          platform: platform,
        ),
        false,
      );

      for (final mobilePlatform in [
        TargetPlatform.android,
        TargetPlatform.iOS,
        TargetPlatform.fuchsia,
      ]) {
        expect(
          const PlatformChecker(shouldItWeb: false, overrideIsWeb: false)
              .isMobile(
            platform: mobilePlatform,
          ),
          true,
        );

        expect(
          const PlatformChecker(shouldItWeb: false, overrideIsWeb: true)
              .isMobile(
            platform: mobilePlatform,
          ),
          false,
        );

        expect(
          const PlatformChecker(shouldItWeb: true, overrideIsWeb: true)
              .isMobile(
            platform: mobilePlatform,
          ),
          true,
        );
      }
    });
    test(
      'Check `shouldItWeb` parameter when using desktop platform on web',
      () {
        platform = TargetPlatform.macOS;
        expect(
          PlatformChecker.defaultLogic().isDesktop(
            platform: platform,
          ),
          true,
        );
        expect(
          const PlatformChecker(shouldItWeb: false, overrideIsWeb: false)
              .isDesktop(
            platform: platform,
          ),
          true,
        );

        expect(
          const PlatformChecker(shouldItWeb: false, overrideIsWeb: true)
              .isDesktop(
            platform: platform,
          ),
          false,
        );
      },
    );

    test(
      'Check supportWeb parameter when using mobile platform on web',
      () {
        platform = TargetPlatform.android;
        expect(
          const PlatformChecker(shouldItWeb: true, overrideIsWeb: true)
              .isMobile(
            platform: platform,
          ),
          true,
        );
        expect(
          const PlatformChecker(shouldItWeb: false, overrideIsWeb: false)
              .isMobile(
            platform: platform,
          ),
          true,
        );

        expect(
          const PlatformChecker(shouldItWeb: false, overrideIsWeb: true)
              .isMobile(
            platform: platform,
          ),
          false,
        );
      },
    );
  });
}
