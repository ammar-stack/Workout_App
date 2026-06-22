import 'package:flutter/material.dart';

class RunningScreen extends StatelessWidget {
  const RunningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lime = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  padding: const EdgeInsets.only(top: 12),
                  icon: const Icon(Icons.arrow_back_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),

              const Spacer(),

              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 700),
                curve: Curves.elasticOut,
                builder: (context, value, child) => Transform.scale(
                  scale: value,
                  child: child,
                ),
                child: const Text('🏃', style: TextStyle(fontSize: 90)),
              ),

              const SizedBox(height: 32),

              Text(
                'Running Day',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 34,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              Text(
                'Stay Active!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: lime,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'Lace up your shoes and hit the pavement.\nEvery step counts, Boota.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 16,
                  height: 1.6,
                ),
              ),

              const Spacer(),

              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Back to Home'),
              ),

              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}