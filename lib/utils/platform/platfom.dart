library platform_utils;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' as Pl show Platform;

part "models/platform_type.dart";

class PlatformUtils {
  static PlatformType get platformType {
    if (kIsWeb) return WebPlatform();

    if (Pl.Platform.isAndroid) return AndroidPlatform();
    if (Pl.Platform.isFuchsia) return FuchsiaPlatform();
    if (Pl.Platform.isIOS) return IOSPlatform();
    if (Pl.Platform.isLinux) return LinuxPlatform();
    if (Pl.Platform.isMacOS) return MacOSPlatform();
    if (Pl.Platform.isWindows) return WindowsPlatform();

    return UnknownPlatform();
  }
}
