import 'package:FitnessJungle/Screens/HomeScreen.dart';
import 'package:FitnessJungle/Screens/usernamescreen.dart';
import 'package:FitnessJungle/services/preference_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
 
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
 
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;
 
  @override
  void initState() {
    super.initState();
 
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
 
    _scaleAnim = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
 
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
 
    _controller.forward();
 
    Future.delayed(const Duration(milliseconds: 2200), _goNext);
  }
 
  Future<void> _goNext() async {
    if (!mounted) return;
    final hasUsername = await PreferencesService.hasUsername();
    if (!mounted) return;
 
    final destination =
        hasUsername ? const HomeScreen() : const UsernameScreen();
 
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => destination,
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }
 
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
 
    return Scaffold(
      backgroundColor: colorScheme.background,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: ScaleTransition(
            scale: _scaleAnim,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      'F',
                      style: TextStyle(
                        fontSize: 56,
                        fontWeight: FontWeight.w900,
                        color: colorScheme.onPrimary,
                        height: 1,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
 
                Text(
                  'FitnessJungle',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: colorScheme.onBackground,
                    letterSpacing: 8,
                    fontSize: 38,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'WORKOUT',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 6,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
 