import 'package:flutter/services.dart';

/// Extension on SystemChrome to manage screen orientation.
///
/// This extension provides utility methods to easily lock and unlock
/// the device orientation in different modes (vertical, horizontal, or both).
extension OrientationExtension on SystemChrome {
  /// Locks the screen orientation to vertical.
  ///
  /// This method sets the preferred orientations to portrait mode only,
  /// allowing the device to be used in portrait up
  /// and portrait down orientations.
  static Future<void> lockVertical() async =>
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);

  /// Locks the screen orientation to horizontal.
  ///
  /// This method sets the preferred orientations to landscape mode only,
  /// allowing the device to be used in landscape
  /// left and landscape right orientations.
  static Future<void> lockHorizontal() async =>
      SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
      );

  /// Unlocks the screen orientation.
  ///
  /// This method resets the preferred orientations, allowing the device
  /// to automatically rotate and adapt to both portrait and landscape modes.
  static Future<void> unlock() async => SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
}
