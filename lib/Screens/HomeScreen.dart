import 'package:WorkoutApp/Screens/runningscreen.dart';
import 'package:WorkoutApp/Screens/workoutscreen.dart';
import 'package:flutter/material.dart';
import '../data/workout_data.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _onDayTap(BuildContext context, String day, WorkoutType type) {
    if (type == WorkoutType.running) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const RunningScreen()),
      );
    } else {
      final exercises = getExercisesFor(type)!;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => WorkoutScreen(
            workoutTitle: workoutLabel(type),
            exercises: exercises,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final lime = Theme.of(context).colorScheme.primary;
    final days = dayWorkoutMap.keys.toList();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),

              Text(
                'Welcome back,',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                'Boota 👋',
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  fontSize: 36,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Choose your training day',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 28),

              Expanded(
                child: ListView.separated(
                  itemCount: days.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final day = days[index];
                    final type = dayWorkoutMap[day]!;
                    return _DayCard(
                      day: day,
                      type: type,
                      onTap: () => _onDayTap(context, day, type),
                    );
                  },
                ),
              ),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class _DayCard extends StatelessWidget {
  final String day;
  final WorkoutType type;
  final VoidCallback onTap;

  const _DayCard({
    required this.day,
    required this.type,
    required this.onTap,
  });

  Color _accentFor(WorkoutType t) {
    switch (t) {
      case WorkoutType.legs:
        return const Color(0xFF7B61FF);
      case WorkoutType.abs:
        return const Color(0xFFFF6B35);
      case WorkoutType.chest:
        return const Color(0xFFC6FF00);
      case WorkoutType.running:
        return const Color(0xFF00CFDD);
    }
  }

  @override
  Widget build(BuildContext context) {
    final accent = _accentFor(type);

    return Material(
      color: const Color(0xFF1E1E28),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: accent.withOpacity(0.15),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    workoutEmoji(type),
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      day,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      workoutLabel(type),
                      style: TextStyle(
                        fontSize: 13,
                        color: accent,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.chevron_right_rounded,
                color: Colors.white.withOpacity(0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}