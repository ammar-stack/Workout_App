import 'package:flutter/material.dart';

class RestScreen extends StatelessWidget {
  const RestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final blue = const Color(0xFF4A9EFF);

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
                child: const Text('😴', style: TextStyle(fontSize: 90)),
              ),

              const SizedBox(height: 32),

              Text(
                'Full Rest Day',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 32,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 12),

              Text(
                'You\'ve earned it.',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: blue,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 24),

              // Rest pillars
              _RestCard(
                emoji: '🛌',
                title: 'Recovery',
                subtitle: 'Let your muscles rebuild and grow stronger',
                color: blue,
              ),
              const SizedBox(height: 12),
              _RestCard(
                emoji: '😴',
                title: 'Sleep',
                subtitle: 'Aim for 7–9 hours of quality sleep tonight',
                color: const Color(0xFF7B61FF),
              ),
              const SizedBox(height: 12),
              _RestCard(
                emoji: '🥗',
                title: 'Nutrition',
                subtitle: 'Fuel your body with protein and whole foods',
                color: const Color(0xFFC6FF00),
              ),

              const SizedBox(height: 20),

              Text(
                'Rest is not weakness — it\'s where the\ngrowth actually happens, Boota.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: 15,
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

class _RestCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final Color color;

  const _RestCard({
    required this.emoji,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 26)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}