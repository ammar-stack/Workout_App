import 'package:FitnessJungle/Data/workout_data.dart';
import 'package:FitnessJungle/Screens/settingscreen.dart';
import 'package:FitnessJungle/Screens/walkscreen.dart';
import 'package:FitnessJungle/Screens/workoutscreen.dart';
import 'package:FitnessJungle/main.dart';
import 'package:FitnessJungle/services/preference_services.dart';
import 'package:flutter/material.dart';

/// Root screen after onboarding. Hosts the bottom navigation bar
/// with two tabs: Home and Settings.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabIndex = 0;

  // IndexedStack keeps both tabs alive so scroll position / state
  // isn't lost when switching back and forth.
  late final List<Widget> _tabs = [
    _HomeTab(onUsernameChanged: () => setState(() {})),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _tabIndex, children: _tabs),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: (index) => setState(() => _tabIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

// ── Local, self-contained color/shadow helpers ────────────────────
Color _secondaryText(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return isDark ? const Color(0xFFB6B6C0) : const Color(0xFF534D68);
}

Color _faintText(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return isDark ? const Color(0xFF7C7C87) : const Color(0xFF8A83A0);
}

List<BoxShadow> _cardShadow(BuildContext context) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  if (isDark) return const [];
  return [
    BoxShadow(
      color: Colors.black.withOpacity(0.10),
      blurRadius: 16,
      offset: const Offset(0, 4),
      spreadRadius: -4,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      blurRadius: 3,
      offset: const Offset(0, 1),
    ),
  ];
}

class _HomeTab extends StatefulWidget {
  final VoidCallback onUsernameChanged;
  const _HomeTab({required this.onUsernameChanged});

  @override
  State<_HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<_HomeTab> {
  String _username = '';

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final name = await PreferencesService.getUsername();
    if (!mounted) return;
    setState(() => _username = (name == null || name.isEmpty) ? 'there' : name);
  }

  void _onDayTap(BuildContext context, String day, WorkoutType type) {
    switch (type) {
      case WorkoutType.walk:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const WalkScreen(),
          ),
        );
        break;
      default:
        final exercises = getExercisesFor(type);
        if (exercises == null) return;
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
    final colorScheme = Theme.of(context).colorScheme;
    final appState = BootaWorkoutApp.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome back,',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          '$_username 👋',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(fontSize: 36),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      shape: BoxShape.circle,
                      border: Border.all(color: colorScheme.outline),
                    ),
                    child: IconButton(
                      tooltip: appState.isDark
                          ? 'Switch to light theme'
                          : 'Switch to dark theme',
                      onPressed: () => appState.toggleTheme(),
                      icon: Icon(
                        appState.isDark
                            ? Icons.light_mode_rounded
                            : Icons.dark_mode_rounded,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ],
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
                    final type = dayWorkoutMap[day];
                    if (type == null) {
                      return const SizedBox.shrink();
                    }
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

  Color _accentFor(WorkoutType t, bool isDark) {
    switch (t) {
      case WorkoutType.legs:
        return const Color(0xFF7B61FF);
      case WorkoutType.cardio:
        return isDark ? const Color(0xFF00CFDD) : const Color(0xFF0091A0);
      case WorkoutType.chest:
        return isDark ? const Color(0xFFC6FF00) : const Color(0xFF6E8F00);
      case WorkoutType.abs:
        return const Color(0xFFFF6B35);
      case WorkoutType.fullBody:
        return isDark ? const Color(0xFFFFD600) : const Color(0xFFAD7E00);
      case WorkoutType.walk:
        return isDark ? const Color(0xFF4A9EFF) : const Color(0xFF1E6FD9);
    }
  }

  bool _isRestDay(WorkoutType t) =>
      t == WorkoutType.walk || t == WorkoutType.cardio;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = _accentFor(type, isDark);
    final isRest = _isRestDay(type);
    final colorScheme = Theme.of(context).colorScheme;
    final secondaryText = _secondaryText(context);
    final faintText = _faintText(context);

    final cardColor = isRest ? colorScheme.surfaceVariant : colorScheme.surface;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: _cardShadow(context),
      ),
      child: Material(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          splashColor: accent.withOpacity(0.15),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: colorScheme.outline, width: 1),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Colored stripe
                Container(
                  width: 4,
                  height: 60, // Fixed height instead of infinite
                  color: accent.withOpacity(isRest ? 0.35 : 0.9),
                ),
                const SizedBox(width: 12),
                // Emoji circle
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: accent.withOpacity(isRest ? 0.12 : 0.18),
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
                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        day,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(
                              color: isRest
                                  ? secondaryText
                                  : colorScheme.onSurface,
                            ),
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
                      const SizedBox(height: 2),
                      Text(
                        workoutSubtitle(type),
                        style: TextStyle(
                          fontSize: 11,
                          color: faintText,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Icon
                Icon(
                  isRest
                      ? Icons.bedtime_outlined
                      : Icons.chevron_right_rounded,
                  color: isRest ? accent.withOpacity(0.6) : faintText,
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}