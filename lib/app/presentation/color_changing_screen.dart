import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:solid_color_test/bloc/color_bloc.dart';
import 'package:solid_color_test/bloc/color_event.dart';
import 'package:solid_color_test/bloc/color_state.dart';

/// ColorChangingScreen class
class ColorChangingScreen extends StatelessWidget {
  /// Constructor for ColorChangingScreen
  const ColorChangingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ColorBloc, ColorState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return GestureDetector(
            onTap: () =>
                context.read<ColorBloc>().add(ColorEvent.changeColor()),
            child: Scaffold(
                appBar: AppBar(
                  // TRY THIS: Try changing the color here to a specific color (to
                  // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
                  // change color while the other colors stay the same.
                  backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                  // Here we take the value from the MyHomePage object that was created
                  // by the App.build method, and use it to set our appbar title.
                  title: Text(state.colorPageTile),
                ),
                backgroundColor: state.backgroundColor,
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                          color: state.backgroundColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(18),
                          ),
                          elevation: 20,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "${state.greetMessage}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: state.textColor,
                              ),
                            ),
                          )),
                     SizedBox(height: 20),
                      Text(
                        'RGB: (${state.textColor.red}, '
                        '${state.textColor.green}, ${state.textColor.blue})',
                        style: TextStyle(
                          fontSize: 16,
                          color: state.textColor,
                        ),
                      )
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () => context
                      .read<ColorBloc>()
                      .add(ColorEvent.clickForSurprise()),
                  tooltip: 'Click for a surprise',
                  child: const Icon(Icons.star),
                ),
                bottomNavigationBar: Container(
                  color: Colors.white,
                  height: 56,
                  child: Row(children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Auto Color Change",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            CupertinoSwitch(
                              trackColor: Colors.black,
                              value: state.triggerColorChange,
                              onChanged: (bool value) {
                                context
                                .read<ColorBloc>()
                                .add(ColorEvent.enableAutoChangeColorEvent());
                              },
                            ),
                            const SizedBox(width: 8),
                      DropdownButton<int>(
                        value: state.selectedInterval,
                        hint: const Text("Select Interval"),
                        items: [1, 5, 10, 30, 60].map((int value) {
                          return DropdownMenuItem<int>(
                            value: value,
                            child: Text("$value seconds"),
                          );
                        }).toList(),
                        onChanged: (int? newValue) {
                          
                          // Dispatch an event with the new interval
                          context
                              .read<ColorBloc>()
                              .add(ColorEvent.updateTimerIntervalEvent(newValue!));
                        },
                      ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                )));
      },
    );
  }
}
