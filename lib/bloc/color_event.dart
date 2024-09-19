// ignore_for_file: avoid_unused_parameters
import 'package:freezed_annotation/freezed_annotation.dart';
part 'color_event.freezed.dart';

/// Represents events that can occur in the home page.
/// It uses the freezed package to provide
/// an immutable state management solution.
@freezed
// ignore: prefer_match_file_name
class ColorEvent with _$ColorEvent {
  /// Factory constructor for initializing the color page state.
  factory ColorEvent.init() = ColorEventInit;

  /// Factory constructor for triggering a color change event.
  factory ColorEvent.changeColor() = ChangeColorEvent;

  /// Factory constructor for updating timer value.
  const factory ColorEvent.updateTimerIntervalEvent(int interval) =
      UpdateTimerIntervalEvent;

  /// Factory constructor for triggering automatically color change event.
  factory ColorEvent.autoChangeColorEvent() = AutoChangeColorEvent;

  /// Factory constructor for triggering a color change event.
  factory ColorEvent.enableAutoChangeColorEvent() = EnableAutoChangeColorEvent;

  /// Factory constructor for triggering a color change event.
  factory ColorEvent.clickForSurprise() = ClickForSupriseEvent;
}
