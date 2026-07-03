import 'dart:math';
import 'package:FitnessJungle/Screens/HomeScreen.dart';
import 'package:FitnessJungle/services/preference_services.dart';
import 'package:flutter/material.dart';

class CompletionScreen extends StatefulWidget {
  const CompletionScreen({super.key});
 
  @override
  State<CompletionScreen> createState() => _CompletionScreenState();
}
 
class _CompletionScreenState extends State<CompletionScreen>
    with TickerProviderStateMixin {
  late AnimationController _heroController;
  late Animation<double> _heroScale;
  late Animation<double> _heroFade;
 
  late AnimationController _particleController;
 
  final Random _rnd = Random();
 
  late final List<_Particle> _particles;
 
  String _username = 'Champ';
 
  @override
  void initState() {
    super.initState();
 
    _heroController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _heroScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _heroController, curve: Curves.elasticOut),
    );
    _heroFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _heroController, curve: Curves.easeIn),
    );
 
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();
 
    const emojis = ['🎉', '⭐', '🔥', '💪', '✨', '🏆'];
    _particles = List.generate(14, (i) {
      return _Particle(
        emoji: emojis[i % emojis.length],
        startX: _rnd.nextDouble(),
        startY: 0.3 + _rnd.nextDouble() * 0.5,
        speed: 0.4 + _rnd.nextDouble() * 0.6,
        size: 18.0 + _rnd.nextDouble() * 20,
        phase: _rnd.nextDouble(),
      );
    });
 
    _heroController.forward();
    _loadUsername();
  }
 
  Future<void> _loadUsername() async {
    final name = await PreferencesService.getUsername();
    if (!mounted) return;
    if (name != null && name.trim().isNotEmpty) {
      setState(() => _username = name.trim());
    }
  }
 
  @override
  void dispose() {
    _heroController.dispose();
    _particleController.dispose();
    super.dispose();
  }
 
  void _goHome() {
    Navigator.of(context).pushAndRemoveUntil(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => const HomeScreen(),
        transitionsBuilder: (_, anim, __, child) =>
            FadeTransition(opacity: anim, child: child),
        transitionDuration: const Duration(milliseconds: 400),
      ),
      (route) => false,
    );
  }
 
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorScheme = Theme.of(context).colorScheme;
    final lime = colorScheme.primary;
 
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _particleController,
            builder: (context, _) {
              return CustomPaint(
                size: size,
                painter: _ParticlePainter(
                  particles: _particles,
                  progress: _particleController.value,
                  baseColor: colorScheme.onBackground,
                ),
              );
            },
          ),
 
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const Spacer(),
 
                  FadeTransition(
                    opacity: _heroFade,
                    child: ScaleTransition(
                      scale: _heroScale,
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: lime.withOpacity(0.15),
                              shape: BoxShape.circle,
                              border: Border.all(color: lime.withOpacity(0.4), width: 2),
                            ),
                            child: const Center(
                              child: Text('🏆', style: TextStyle(fontSize: 60)),
                            ),
                          ),
                          const SizedBox(height: 32),
                          Text(
                            'Congratulations,',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            '$_username!',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge
                                ?.copyWith(
                              color: lime,
                              fontSize: 44,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'You crushed today\'s workout.\nKilling it, one rep at a time.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontSize: 16, height: 1.6),
                          ),
                        ],
                      ),
                    ),
                  ),
 
                  const Spacer(),
 
                  FadeTransition(
                    opacity: _heroFade,
                    child: ElevatedButton(
                      onPressed: _goHome,
                      child: const Text('Back to Home 🏠'),
                    ),
                  ),
 
                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
 
class _Particle {
  final String emoji;
  final double startX;
  final double startY;
  final double speed;
  final double size;
  final double phase;
 
  const _Particle({
    required this.emoji,
    required this.startX,
    required this.startY,
    required this.speed,
    required this.size,
    required this.phase,
  });
}
 
class _ParticlePainter extends CustomPainter {
  final List<_Particle> particles;
  final double progress;
  final Color baseColor;
 
  const _ParticlePainter({
    required this.particles,
    required this.progress,
    required this.baseColor,
  });
 
  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      final t = (progress + p.phase) % 1.0;
 
      final y = (p.startY - t * 0.5 * p.speed) * size.height;
      final x = p.startX * size.width;
 
      final opacity = t < 0.2
          ? t / 0.2
          : t > 0.7
              ? (1.0 - t) / 0.3
              : 1.0;
 
      final tp = TextPainter(
        text: TextSpan(
          text: p.emoji,
          style: TextStyle(fontSize: p.size, color: baseColor.withOpacity(opacity.clamp(0, 1))),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
 
      tp.paint(canvas, Offset(x, y));
    }
  }
 
  @override
  bool shouldRepaint(_ParticlePainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.baseColor != baseColor;
}
 