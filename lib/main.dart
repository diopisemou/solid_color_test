import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const SolidRandomColorApp());
}

// SolidRandomColorApp class
class SolidRandomColorApp extends StatelessWidget {
  const SolidRandomColorApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Solid Random Color App',
        theme: ThemeData(primarySwatch: Colors.blue,
        useMaterial3: true,),
        home: const ColorChangingScreen(title: 'Solid Random Color App'),
      );
}

// ColorChangingScreen class
class ColorChangingScreen extends StatefulWidget {
  const ColorChangingScreen({required this.title, super.key});

  //Title property for the color changing page
  final String title;
  @override
  State<ColorChangingScreen> createState() => _ColorChangingScreenState();
}

class _ColorChangingScreenState extends State<ColorChangingScreen> {
  static const int _maxColorValue = 256;
  static String _greetMessage = 'Hello there';
  Color _backgroundColor = Colors.white;

// Helper function to change the background color
  void _changeBackgroundColor() {
    setState(() {
      _backgroundColor = _generateRandomColor();
    });
  }

  // Generate a random color using RGB values
  Color _generateRandomColor() {
    final random = Random();

    return Color.fromRGBO(
      random.nextInt(_maxColorValue),
      random.nextInt(_maxColorValue),
      random.nextInt(_maxColorValue),
      1,
    );
  }

  // Determine text color based on background brightness for better contrast
  Color _getTextColor(Color backgroundColor) =>
      backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;

    void _clickForSurprise() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _greetMessage = 'Surprise! A new color has appeared.';
      _backgroundColor = _generateRandomColor();
    });
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: _changeBackgroundColor,
        child: Scaffold(
          appBar: AppBar(
          // TRY THIS: Try changing the color here to a specific color (to
          // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
          // change color while the other colors stay the same.
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          // Here we take the value from the MyHomePage object that was created 
          // by the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
          backgroundColor: _backgroundColor,
          body: Center(
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _greetMessage,
                  style: TextStyle(
                    fontSize: 24,
                    color: _getTextColor(_backgroundColor),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'RGB: (${_backgroundColor.red}, '
                  '${_backgroundColor.green}, ${_backgroundColor.blue})',
                  style: TextStyle(
                    fontSize: 16,
                    color: _getTextColor(_backgroundColor),
                  ),
                ),
              ],
            ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: _clickForSurprise,
        tooltip: 'Click for a surprise',
        child: const Icon(Icons.star),
      ), 
        ),
      );
}
