// ignore_for_file: avoid_unused_parameters
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'color_state.freezed.dart';

/// Represents the state of the color page.
/// Includes properties for background color, text color, and loading status.
/// It leverages freezed for immutable state management.
@freezed
class ColorState with _$ColorState {
  /// Getter to retrieve the data state of the color page.
  ColorStateData get data => this as ColorStateData;

  /// Internal constructor for creating state instances.
  const ColorState._();

  /// Factory constructor for creating a default or specific state.
  /// Allows setting of background color, text color, and loading status,
  /// with default values if not specified
  ///
  factory ColorState.data({
    @Default(5) int selectedInterval,
    @Default(Colors.white) Color backgroundColor,
    @Default(Colors.black) Color textColor,
    @Default(false) bool isLoading,
    @Default(false) bool triggerColorChange,
    @Default('Hello there') String greetMessage,
    @Default('Solid Random Color App') String colorPageTile,
  }) = ColorStateData;
}
