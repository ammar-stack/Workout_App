import 'package:FitnessJungle/main.dart';
import 'package:flutter/material.dart';

class RunningScreen extends StatelessWidget {
  const RunningScreen({super.key});
 
  @override
  Widget build(BuildContext context) {
    final lime = Theme.of(context).colorScheme.primary;
    final cyan = const Color(0xFF00CFDD);
 
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
                'Rest + Jog Day',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 32,
                ),
                textAlign: TextAlign.center,
              ),
 
              const SizedBox(height: 12),
 
              Text(
                'Active Recovery',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: cyan,
                  letterSpacing: 1,
                ),
              ),
 
              const SizedBox(height: 24),
 
              _InfoCard(
                emoji: '🕐',
                title: '10–15 min light jog',
                subtitle: 'Keep your heart rate low and comfortable',
                color: cyan,
              ),
              const SizedBox(height: 12),
              _InfoCard(
                emoji: '🌬️',
                title: 'Breathing recovery',
                subtitle: 'Focus on deep, rhythmic breathing throughout',
                color: lime,
              ),
              const SizedBox(height: 12),
              _InfoCard(
                emoji: '💧',
                title: 'Stay hydrated',
                subtitle: 'Drink water before, during, and after',
                color: const Color(0xFF7B61FF),
              ),
 
              const SizedBox(height: 16),
 
              Text(
                'Today is about letting your body recover\nwhile staying active, Boota.',
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
 
class _InfoCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final Color color;
 
  const _InfoCard({
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
                    color: context.appText.secondary,
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
 