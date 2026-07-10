import 'package:FitnessJungle/Data/workout_data.dart';
import 'package:FitnessJungle/Screens/completionscreen.dart';
import 'package:FitnessJungle/main.dart';
import 'package:flutter/material.dart';

class WorkoutScreen extends StatefulWidget {
  final String workoutTitle;
  final List<Exercise> exercises;
  // True for the pure cardio-only days (Sprint Session, Endurance Jog,
  // Light Cardio Mix), where the whole session IS the cardio work rather
  // than a warm-up in front of a lifting day.
  final bool isCardioOnly;

  const WorkoutScreen({
    super.key,
    required this.workoutTitle,
    required this.exercises,
    this.isCardioOnly = false,
  });

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;

  late AnimationController _slideController;
  late Animation<Offset> _slideAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _slideAnim = Tween<Offset>(
      begin: const Offset(0.12, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeIn),
    );
    _slideController.forward();
  }

  Exercise get _current => widget.exercises[_currentIndex];

  bool get _isLast => _currentIndex == widget.exercises.length - 1;

  void _onNext() {
    if (_isLast) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const CompletionScreen(),
          transitionsBuilder: (_, anim, __, child) =>
              FadeTransition(opacity: anim, child: child),
          transitionDuration: const Duration(milliseconds: 400),
        ),
      );
    } else {
      _slideController.reset();
      setState(() => _currentIndex++);
      _slideController.forward();
    }
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final lime = colorScheme.primary;
    final total = widget.exercises.length;
    final progress = (_currentIndex + 1) / total;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_rounded),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  Expanded(
                    child: Text(
                      widget.workoutTitle.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3,
                        color: lime,
                      ),
                    ),
                  ),
                  Text(
                    '${_currentIndex + 1} / $total',
                    style: TextStyle(
                      fontSize: 14,
                      color: context.appText.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 5,
                  backgroundColor: colorScheme.surfaceVariant,
                  valueColor: AlwaysStoppedAnimation<Color>(lime),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Makes it unmistakable that every "Morning Gym" training day
            // starts with the cardio warm-up block before moving into the
            // day's main lifts. On pure cardio-only days (Sprint/Endurance/
            // Light Mix), the session itself is the cardio work, so it's
            // labeled as a session rather than a "warm-up".
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.isCardioOnly
                      ? '🏃 CARDIO SESSION'
                      : (_current.category == ExerciseCategory.cardio
                          ? '🏃 CARDIO WARM-UP'
                          : '🏋️ MAIN WORKOUT'),
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.5,
                    color: widget.isCardioOnly ||
                            _current.category == ExerciseCategory.cardio
                        ? const Color(0xFF00CFDD)
                        : lime,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 8),

            Expanded(
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: _ExerciseCard(exercise: _current),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
              child: ElevatedButton(
                onPressed: _onNext,
                child: Text(_isLast ? 'Finish Workout 🎉' : 'Next Exercise →'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  final Exercise exercise;
  const _ExerciseCard({required this.exercise});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final lime = colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: colorScheme.outline,
                  width: 1.5,
                ),
                boxShadow: appCardShadow(context),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: _buildImage(colorScheme),
              ),
            ),
          ),

          const SizedBox(height: 20),

          _CategoryBadge(category: exercise.category),

          const SizedBox(height: 10),

          Text(
            exercise.name,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),

          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _StatChip(
                label: exercise.unitLabel ??
                    (exercise.isDuration ? 'MIN' : 'REPS'),
                value: '${exercise.reps}',
                accentColor: lime,
              ),
              const SizedBox(width: 12),
              _StatChip(
                label: exercise.isDuration ? 'ROUNDS' : 'SETS',
                value: '${exercise.sets}',
                accentColor: const Color(0xFF7B61FF),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage(ColorScheme colorScheme) {
    return Image.asset(
      exercise.imagePath,
      fit: BoxFit.contain,
      errorBuilder: (context, _, __) {
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.fitness_center_rounded,
                size: 80,
                color: colorScheme.onSurface.withOpacity(0.15),
              ),
              const SizedBox(height: 12),
              Text(
                'Add ${exercise.imagePath.split('/').last}\nto assets/images/',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onSurface.withOpacity(0.25),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _CategoryBadge extends StatelessWidget {
  final ExerciseCategory category;
  const _CategoryBadge({required this.category});

  @override
  Widget build(BuildContext context) {
    final isCardio = category == ExerciseCategory.cardio;
    final color = isCardio ? const Color(0xFF00CFDD) : const Color(0xFFC6FF00);
    final label = isCardio ? 'CARDIO' : 'STRENGTH';
    final emoji = isCardio ? '🏃' : '🏋️';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 12)),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final String value;
  final Color accentColor;

  const _StatChip({
    required this.label,
    required this.value,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: accentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: accentColor,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
              color: context.appText.secondary,
            ),
          ),
        ],
      ),
    );
  }
}