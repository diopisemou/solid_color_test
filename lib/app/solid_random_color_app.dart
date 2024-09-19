import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solid_color_test/app/presentation/color_changing_screen.dart';
import 'package:solid_color_test/bloc/color_bloc.dart';

/// SolidRandomColorApp class
/// The root widget of the application.
///
/// This widget sets up the global configuration and provides the necessary
/// dependencies for the app to function. It is responsible for initializing
/// and configuring aspects like screen size adaptation, state management,
/// and navigation.
class SolidRandomColorApp extends StatelessWidget {
  /// Constructor for SolidRandomColorApp
  const SolidRandomColorApp({super.key});

@override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (_, __) {
        return BlocProvider(
          create: (_) => ColorBloc(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Solid Random Color App',
            theme: ThemeData(primarySwatch: Colors.blue,
            useMaterial3: true,),
            home: const ColorChangingScreen(),
      ),
        );
      },
    );
  }

}