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
  // Length of the day's own bodyweight/cardio block (e.g. legsCardioExercises),
  // NOT counting the shared 3-move warm-up. Comes from
  // workout_data.dart's bodyweightBlockCount(type) so this screen never has
  // to guess block sizes — those lists can be any length per day. 0 for
  // cardio-only days, where there's no separate block to distinguish.
  final int bodyweightCount;

  const WorkoutScreen({
    super.key,
    required this.workoutTitle,
    required this.exercises,
    this.isCardioOnly = false,
    this.bodyweightCount = 0,
  });

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

// Rotating hype lines, picked by how far through the workout the user is.
// Keeps the CTA area feeling alive instead of static "Next Exercise" text.
const List<String> _kickoffLines = [
  "Let's get to work 💪",
  'First rep of many 🔥',
  'Show up — you\'re already winning 🚀',
];
const List<String> _midLines = [
  'Keep the momentum going 🔥',
  'You\'re doing great, keep pushing 👊',
  'Halfway hero — don\'t slow down ⚡',
  'Every rep counts. Stay locked in. 🎯',
];
const List<String> _lateLines = [
  'Almost there — dig in! ⚡',
  'Final stretch, finish strong 🏁',
  'This is where champions are made 🦁',
];
const String _lastLine = 'Last one — leave it all here! 🏆';

/// Plain label+color pair for the section header — a lightweight
/// alternative to a Dart 3 record so this compiles on any SDK constraint.
class _SectionInfo {
  final String label;
  final Color color;
  const _SectionInfo(this.label, this.color);
}

class _WorkoutScreenState extends State<WorkoutScreen>
    with TickerProviderStateMixin {
  int _currentIndex = 0;

  late AnimationController _slideController;
  late Animation<Offset> _slideAnim;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;

  late final AnimationController _ctaPulse;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 380),
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
    _scaleAnim = Tween<double>(begin: 0.94, end: 1.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutBack),
    );
    _slideController.forward();

    _ctaPulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1100),
    )..repeat(reverse: true);
  }

  Exercise get _current => widget.exercises[_currentIndex];

  bool get _isLast => _currentIndex == widget.exercises.length - 1;

  // Three honest states instead of guessing from Exercise.category alone
  // (which tags every bodyweight move — squats, planks, pushups included —
  // as "cardio"). Position-based, using the block sizes workout_data.dart
  // reports, so this stays correct no matter how long each day's
  // bodyweight list is.
  static const _cyan = Color(0xFF00CFDD);
  static const _amber = Color(0xFFFF9F45);

  _SectionInfo get _section {
    if (widget.isCardioOnly) {
      return const _SectionInfo('🏃 CARDIO SESSION', _cyan);
    }
    if (_currentIndex < warmupExerciseCount) {
      return const _SectionInfo('🏃 WARM-UP', _cyan);
    }
    if (_currentIndex < warmupExerciseCount + widget.bodyweightCount) {
      return const _SectionInfo('🤸 BODYWEIGHT BLOCK', _amber);
    }
    return _SectionInfo('🏋️ MAIN WORKOUT', Theme.of(context).colorScheme.primary);
  }

  String get _hypeLine {
    final total = widget.exercises.length;
    if (_isLast) return _lastLine;
    final progress = total <= 1 ? 1.0 : _currentIndex / (total - 1);
    final seed = _currentIndex;
    if (progress < 0.15) {
      return _kickoffLines[seed % _kickoffLines.length];
    } else if (progress < 0.7) {
      return _midLines[seed % _midLines.length];
    }
    return _lateLines[seed % _lateLines.length];
  }

  void _onNext() {
    if (_isLast) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => CompletionScreen(
          ),
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
    _ctaPulse.dispose();
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
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: lime.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_currentIndex + 1} / $total',
                      style: TextStyle(
                        fontSize: 13,
                        color: lime,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0, end: progress),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                builder: (context, value, _) => ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: value,
                    minHeight: 7,
                    backgroundColor: colorScheme.surfaceVariant,
                    valueColor: AlwaysStoppedAnimation<Color>(lime),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Rotating hype line — swaps with every exercise to keep the
            // session feeling like a coach is talking, not a checklist.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, anim) => FadeTransition(
                  opacity: anim,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.2),
                      end: Offset.zero,
                    ).animate(anim),
                    child: child,
                  ),
                ),
                child: Text(
                  _hypeLine,
                  key: ValueKey(_currentIndex),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: context.appText.secondary,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Makes it unmistakable that every "Morning Gym" training day
            // starts with the cardio warm-up block before moving into the
            // day's main lifts. On pure cardio-only days (Sprint/Endurance/
            // Light Mix), the session itself is the cardio work, so it's
            // labeled as a session rather than a "warm-up".
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: Text(
                    _section.label,
                    key: ValueKey(_section.label),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: _section.color,
                    ),
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
                  child: ScaleTransition(
                    scale: _scaleAnim,
                    child: _ExerciseCard(exercise: _current),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
              child: AnimatedBuilder(
                animation: _ctaPulse,
                builder: (context, child) {
                  final glow = _isLast
                      ? 0.25 + (_ctaPulse.value * 0.35)
                      : 0.0;
                  final scale = _isLast
                      ? 1.0 + (_ctaPulse.value * 0.02)
                      : 1.0;
                  return Transform.scale(
                    scale: scale,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: glow > 0
                            ? [
                                BoxShadow(
                                  color: lime.withOpacity(glow),
                                  blurRadius: 24,
                                  spreadRadius: 1,
                                ),
                              ]
                            : null,
                      ),
                      child: child,
                    ),
                  );
                },
                child: ElevatedButton(
                  onPressed: _onNext,
                  child: Text(_isLast ? 'Finish Workout 🎉' : 'Next Exercise →'),
                ),
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