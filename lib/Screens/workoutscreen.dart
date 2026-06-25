import 'package:WorkoutApp/Data/workout_data.dart';
import 'package:WorkoutApp/Screens/completionscreen.dart';
import 'package:flutter/material.dart';

class WorkoutScreen extends StatefulWidget {
  final String workoutTitle;
  final List<Exercise> exercises;

  const WorkoutScreen({
    super.key,
    required this.workoutTitle,
    required this.exercises,
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
    final lime = Theme.of(context).colorScheme.primary;
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
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFFAAAAAA),
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
                  backgroundColor: const Color(0xFF2A2A35),
                  valueColor: AlwaysStoppedAnimation<Color>(lime),
                ),
              ),
            ),

            const SizedBox(height: 24),

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
    final lime = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E28),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFF2E2E3A),
                  width: 1.5,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: _buildImage(),
              ),
            ),
          ),

          const SizedBox(height: 24),

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
                label: 'REPS',
                value: '${exercise.reps}',
                accentColor: lime,
              ),
              const SizedBox(width: 12),
              _StatChip(
                label: 'SETS',
                value: '${exercise.sets}',
                accentColor: const Color(0xFF7B61FF),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Widget _buildImage() {
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
                color: Colors.white.withOpacity(0.15),
              ),
              const SizedBox(height: 12),
              Text(
                'Add ${exercise.imagePath.split('/').last}\nto assets/images/',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.25),
                ),
              ),
            ],
          ),
        );
      },
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
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.5,
              color: Color(0xFFAAAAAA),
            ),
          ),
        ],
      ),
    );
  }
}