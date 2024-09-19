import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_color_test/bloc/color_event.dart';
import 'package:solid_color_test/bloc/color_state.dart';
import 'package:solid_color_test/utils/color_utils.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  Timer? timer;

  /// Constructor for `ColorBloc`.
  ///
  /// Initializes the bloc with an initial state. It also defines event handlers
  /// for various types of `ColorEvent`. The `ColorEvent.init()` event is added
  /// to the event stream to trigger the initialization logic immediately
  /// after the bloc is created.
  ColorBloc() : super(ColorState.data()) {
    on<ColorEventInit>(_onInit);
    on<ChangeColorEvent>(_changeColor);
    on<AutoChangeColorEvent>(_autoChangeColor);
    on<EnableAutoChangeColorEvent>(_enableAutoColorChange);
    on<ClickForSupriseEvent>(_clickForSurprise);
    add(ColorEvent.init());
    add(ColorEvent.autoChangeColorEvent());
  }

  Future<void> _onInit(
    ColorEventInit _,
    Emitter<ColorState> emit,
  ) async {
    emit(
      state.data.copyWith(
        isLoading: true,
      ),
    );
    emit(
      state.data.copyWith(
        isLoading: false,
        triggerColorChange: false,
        greetMessage: "Hello there",
        colorPageTile: "Solid Random Color App",
      ),
    );
  }

  Future<void> _changeColor(
    ChangeColorEvent _,
    Emitter<ColorState> emit,
  ) async {
    _updateColor(emit);
    emit(
      state.data.copyWith(greetMessage: 'Hello there'),
    );
  }

  Future<void> _clickForSurprise(
    ClickForSupriseEvent _,
    Emitter<ColorState> emit,
  ) async {
    _updateColor(emit);
    emit(
      state.data.copyWith(greetMessage: 'Surprise! A new color has appeared.'),
    );
  }

  void _updateColor(Emitter<ColorState> emit) {
    var backgroundColor = ColorUtils.getRandomColor();
    var textColor = ColorUtils.getRandomColor();

    while (!ColorUtils.hasSufficientContrast(backgroundColor, textColor)) {
      backgroundColor = ColorUtils.getRandomColor();
      textColor = ColorUtils.getRandomColor();
    }

    emit(
      state.data.copyWith(
        backgroundColor: backgroundColor,
        textColor: textColor,
      ),
    );
  }

  Future<void> _enableAutoColorChange(
  EnableAutoChangeColorEvent _,
  Emitter<ColorState> emit,
) async {
  // First, update the state to reflect the change in triggerColorChange
  emit(
    state.data.copyWith(
      triggerColorChange: !state.triggerColorChange,
    ),
  );
  if (state.triggerColorChange) {
    // If triggerColorChange is now true, start the timer
    _autoChangeColor(AutoChangeColorEvent(), emit); 
  } else {
    // If triggerColorChange is now false, cancel the timer
    timer?.cancel();
  }
}

  Future<void> _autoChangeColor(
  AutoChangeColorEvent _,
  Emitter<ColorState> emit,
) async {
  timer?.cancel();
  timer = null;
  timer = Timer.periodic(const Duration(seconds: 2), (timer) {
    if (state.triggerColorChange && !emit.isDone) {
      _updateColor(emit); // Call directly
      emit(
        state.data.copyWith(
          greetMessage: 'Hello there - Color Changed Automatically',
        ),
      );
    }
  });
}
}
