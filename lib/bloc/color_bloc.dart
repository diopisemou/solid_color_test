import 'dart:async';
import 'dart:ui';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_color_test/bloc/color_event.dart';
import 'package:solid_color_test/bloc/color_state.dart';
import 'package:solid_color_test/utils/color_utils.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  StreamSubscription<dynamic>? _autoChangeTimer;

  ColorBloc() : super(ColorState.data()) {
    on<ColorEventInit>(_onInit);
    on<ChangeColorEvent>(_changeColor);
    on<UpdateTimerIntervalEvent>(_updateTimerIntervalEvent);
    on<AutoChangeColorEvent>(_autoChangeColorEvent);
    on<EnableAutoChangeColorEvent>(_enableAutoColorChange);
    on<ClickForSupriseEvent>(_clickForSurprise);

    // Initialize the bloc
    add(ColorEvent.init());
  }

  Future<void> _onInit(ColorEventInit event, Emitter<ColorState> emit) async {
    // Show loading state
    emit(state.copyWith(isLoading: true));

    // Simulate some initialization work
    await Future.delayed(const Duration(milliseconds: 500));

    // Update state with initial values
    emit(state.copyWith(
      isLoading: false,
      triggerColorChange: false,
      greetMessage: "Hello there",
      colorPageTile: "Solid Random Color App",
    ));
  }

  void _changeColor(ChangeColorEvent event, Emitter<ColorState> emit) {
    _updateColorState(emit, "Hello there");
  }

  void _clickForSurprise(ClickForSupriseEvent event, Emitter<ColorState> emit) {
    _updateColorState(emit, "Surprise! A new color has appeared.");
  }

  void _autoChangeColorEvent(
      AutoChangeColorEvent event, Emitter<ColorState> emit) {
    _updateColorState(emit, "Hello there - Color Changed Automatically");
  }

  void _enableAutoColorChange(
      EnableAutoChangeColorEvent event, Emitter<ColorState> emit) async {
    final shouldEnableAutoChange = !state.triggerColorChange;

    // Emit the new state first
    emit(state.copyWith(triggerColorChange: shouldEnableAutoChange));

    if (shouldEnableAutoChange) {
      await _startAutoColorChange(emit); // Await the function
    } else {
      _stopAutoColorChange();
    }
  }

  Future<void> _updateTimerIntervalEvent(
      UpdateTimerIntervalEvent event, Emitter<ColorState> emit) async {
    emit(state.copyWith(
      selectedInterval: event.interval,
      triggerColorChange: state.triggerColorChange,
    ));

    if (state.triggerColorChange) {
      await _startAutoColorChange(emit); // Await the function
    } else {
      _stopAutoColorChange();
    }
  }

  Future<void> _startAutoColorChange(Emitter<ColorState> emit) async {
    _stopAutoColorChange(); // Ensure any existing timer is cancelled

    // Trigger an immediate color change
    _updateColorState(emit, "Hello There - Auto color change started");

    // Use a local variable to manage the ongoing stream
    _autoChangeTimer =
        Stream.periodic(Duration(seconds: state.selectedInterval))
            .listen((_) async {
      if (_autoChangeTimer == null) return;
      // Ensure the timer is still active
      // Emit within an async context to ensure we respect the handler's lifecycle
      await Future.microtask(() {
        add(ColorEvent.autoChangeColorEvent());
      });
    });
  }

// Assuming this method exists in your class
  void _updateColorState(Emitter<ColorState> emit, String message) {
    Color newBackgroundColor, newTextColor;

    do {
      newBackgroundColor = ColorUtils.getRandomColor();
      newTextColor = ColorUtils.getRandomColor();
    } while (
        !ColorUtils.hasSufficientContrast(newBackgroundColor, newTextColor));

    emit(state.copyWith(
      backgroundColor: newBackgroundColor,
      textColor: newTextColor,
      greetMessage: message,
    ));
  }

  void _stopAutoColorChange() {
    _autoChangeTimer?.cancel();
    _autoChangeTimer = null;
  }

  @override
  Future<void> close() {
    _stopAutoColorChange(); // Ensure the timer is stopped

    return super.close();
  }
}
