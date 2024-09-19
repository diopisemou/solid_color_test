import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:solid_color_test/bloc/color_bloc.dart';
import 'package:solid_color_test/bloc/color_event.dart';
import 'package:solid_color_test/bloc/color_state.dart';

class MockColorBloc extends MockBloc<ColorEvent, ColorState>
    implements ColorBloc {}

void main() {
  const selectedInterval = 30;
  ColorBloc colorBloc = MockColorBloc();

  setUp(() {
    colorBloc = ColorBloc();
  });

  tearDown(() async {
    await colorBloc.close(); // Ensure the bloc is closed
  });

  group('ColorBloc', () {
    test('initial state is correct', () {
      expect(colorBloc.state, ColorState.data());
    });

    blocTest<ColorBloc, ColorState>(
      'emits [loading, initialized] when ColorEvent.init is added',
      build: () => colorBloc,
      act: (bloc) async => bloc.add(ColorEvent.init()),
      expect: () async => [
        // Simulate some initialization work
        colorBloc.state.copyWith(isLoading: true),
        colorBloc.state.copyWith(
          isLoading: false,
          triggerColorChange: false,
          greetMessage: "Hello there",
          colorPageTile: "Solid Random Color App",
        ),
      ],
    );

    blocTest<ColorBloc, ColorState>(
      'emits color change message when ChangeColorEvent is added',
      build: () => colorBloc,
      act: (bloc) => bloc.add(ColorEvent.changeColor()),
      expect: () => [
        // Replace with expected state change based on your implementation
        colorBloc.state.copyWith(
          greetMessage: "Hello there",
          // Add other expected state changes as needed
        ),
      ],
    );

    blocTest<ColorBloc, ColorState>(
      'emits color change message when ClickForSurpriseEvent is added',
      build: () => colorBloc,
      act: (bloc) => bloc.add(ColorEvent.clickForSurprise()),
      expect: () => [
        // Replace with expected state change based on your implementation
        colorBloc.state.copyWith(
          greetMessage: "Surprise! A new color has appeared.",
          // Add other expected state changes as needed
        ),
      ],
    );

    blocTest<ColorBloc, ColorState>(
      'emits updated interval when UpdateTimerIntervalEvent is added',
      build: () => colorBloc,
      act: (bloc) => bloc.add(const ColorEvent.updateTimerIntervalEvent(30)),
      expect: () => [
        // Verify state change with the new interval
        colorBloc.state.copyWith(
          selectedInterval: selectedInterval,
          // Add properties that would change based on your implementation
        ),
      ],
    );

    // Add more tests as needed for other events and behaviors
  });
}
