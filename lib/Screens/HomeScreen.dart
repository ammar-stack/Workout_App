import 'package:WorkoutApp/Data/workout_data.dart';
import 'package:WorkoutApp/Screens/runningscreen.dart';
import 'package:WorkoutApp/Screens/workoutscreen.dart';
import 'package:WorkoutApp/Screens/restscreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _onDayTap(BuildContext context, String day, WorkoutType type) {
    switch (type) {
      case WorkoutType.restJog:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const RunningScreen(),
          ),
        );
        break;
      case WorkoutType.rest:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const RestScreen(),
          ),
        );
        break;
      default:
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
      case WorkoutType.restJog:
        return const Color(0xFF00CFDD);
      case WorkoutType.chest:
        return const Color(0xFFC6FF00);
      case WorkoutType.abs:
        return const Color(0xFFFF6B35);
      case WorkoutType.fullBody:
        return const Color(0xFFFFD600);
      case WorkoutType.rest:
        return const Color(0xFF4A9EFF);
    }
  }

  bool _isRestDay(WorkoutType t) =>
      t == WorkoutType.rest || t == WorkoutType.restJog;

  @override
  Widget build(BuildContext context) {
    final accent = _accentFor(type);
    final isRest = _isRestDay(type);

    return Material(
      color: isRest
          ? const Color(0xFF161620)
          : const Color(0xFF1E1E28),
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: accent.withOpacity(0.15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: isRest
                ? Border.all(color: accent.withOpacity(0.15), width: 1)
                : null,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: accent.withOpacity(isRest ? 0.08 : 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      workoutEmoji(type),
                      style: TextStyle(fontSize: isRest ? 22 : 24),
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
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: isRest
                              ? Colors.white.withOpacity(0.6)
                              : Colors.white,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        workoutLabel(type),
                        style: TextStyle(
                          fontSize: 13,
                          color: isRest ? accent.withOpacity(0.7) : accent,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        workoutSubtitle(type),
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.35),
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                Icon(
                  isRest
                      ? Icons.bedtime_outlined
                      : Icons.chevron_right_rounded,
                  color: isRest
                      ? accent.withOpacity(0.3)
                      : Colors.white.withOpacity(0.3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}