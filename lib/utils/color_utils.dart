import 'dart:math';
import 'package:flutter/material.dart';

/// Utility class for color operations.
class ColorUtils {
  /// Maximum value for a 24-bit RGB color.
  ///
  /// This constant represents the highest possible integer value
  /// that can be used to define a color in the RGB color space.
  /// It is used as the upper bound for generating random color values.
  static const int maxRGBValue = 0xFFFFFF;

  /// Generates and returns a random color.
  ///
  /// Uses Dart's Random class to generate a random integer, which is then
  /// used to create a Color object with a random color value.
  static Color getRandomColor() {
    return Color((Random().nextDouble() * maxRGBValue).toInt())
        .withOpacity(1.0);
  }

  /// Checks if there is sufficient contrast between two colors.
  ///
  /// The contrast is calculated based on the luminance of each color
  /// and then compared to a standard contrast ratio.
  /// Returns true if the contrast ratio is 4.5 or higher, which is considered
  /// readable for normal text.
  static bool hasSufficientContrast(Color bgColor, Color textColor) {
    const minContrastRatioReadability = 4.5;
    final bgLuminance = bgColor.computeLuminance();
    final textLuminance = textColor.computeLuminance();
    final contrastRatio = (bgLuminance > textLuminance)
        ? (bgLuminance + 0.05) / (textLuminance + 0.05)
        : (textLuminance + 0.05) / (bgLuminance + 0.05);

    return contrastRatio >= minContrastRatioReadability;
  }
}
