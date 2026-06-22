import 'package:WorkoutApp/Screens/splashscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BootaWorkoutApp());
}

class BootaWorkoutApp extends StatelessWidget {
  const BootaWorkoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boota Workout',
      debugShowCheckedModeBanner: false,

     
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F0F13),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFFC6FF00),   
          secondary: const Color(0xFF1E1E28),
          surface: const Color(0xFF1E1E28),
          onPrimary: Colors.black,
          onSurface: Colors.white,
        ),
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 48,
            fontWeight: FontWeight.w900,
            letterSpacing: -1,
            color: Colors.white,
          ),
          headlineMedium: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 15,
            color: Color(0xFFAAAAAA),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFC6FF00),
            foregroundColor: Colors.black,
            minimumSize: const Size.fromHeight(56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            textStyle: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
            ),
          ),
        ),
        useMaterial3: true,
      ),

      home: const SplashScreen(),
    );
  }
}