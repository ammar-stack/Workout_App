import 'dart:ui';
import 'package:FitnessJungle/Data/workout_data.dart';
import 'package:FitnessJungle/Screens/restscreen.dart';
import 'package:FitnessJungle/Screens/settingscreen.dart';
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

  // Lets us reach into _HomeTab and force a username reload when
  // Settings reports that it changed — needed because IndexedStack
  // keeps _HomeTab alive, so its initState() never runs again.
  final GlobalKey<_HomeTabState> _homeTabKey = GlobalKey<_HomeTabState>();

  // IndexedStack keeps both tabs alive so scroll position / state
  // isn't lost when switching back and forth.
  late final List<Widget> _tabs = [
    _HomeTab(key: _homeTabKey),
    SettingsScreen(
      onUsernameChanged: () => _homeTabKey.currentState?.reloadUsername(),
    ),
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

// Rotating hype lines for the greeting subtitle — cheap way to make the
// home screen feel alive without needing any new persistence.
const List<String> _hypeLines = [
  "Let's make today count 🔥",
  'One workout closer to your best self 💪',
  'Show up. That\'s the whole secret. 🚀',
  'Future you is already proud 🏆',
  'Small reps, big results. Let\'s go. ⚡',
  'No zero days, Boota. 👊',
  'Discipline beats motivation. Let\'s move. 🦁',
];

const List<String> _weekdayOrder = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

class _HomeTab extends StatefulWidget {
  const _HomeTab({super.key});

  @override
  State<_HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<_HomeTab> with TickerProviderStateMixin {
  String _username = '';
  late final String _todayName;
  late final String _hypeLine;

  late final AnimationController _heroPulse;
  late final AnimationController _entrance;

  @override
  void initState() {
    super.initState();
    _loadUsername();

    // DateTime.weekday: Monday = 1 ... Sunday = 7
    _todayName = _weekdayOrder[DateTime.now().weekday - 1];
    _hypeLine = _hypeLines[DateTime.now().day % _hypeLines.length];

    _heroPulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat(reverse: true);

    _entrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  Future<void> _loadUsername() async {
    final name = await PreferencesService.getUsername();
    if (!mounted) return;
    setState(() => _username = (name == null || name.isEmpty) ? 'there' : name);
  }

  /// Called from HomeScreen (via GlobalKey) after Settings saves a new
  /// name, since IndexedStack keeps this widget alive and initState()
  /// won't run again on its own.
  Future<void> reloadUsername() => _loadUsername();

  @override
  void dispose() {
    _heroPulse.dispose();
    _entrance.dispose();
    super.dispose();
  }

  String _greeting() {
    final hour = DateTime.now().hour;
    if (hour < 5) return 'Up late,';
    if (hour < 12) return 'Good morning,';
    if (hour < 17) return 'Good afternoon,';
    if (hour < 21) return 'Good evening,';
    return 'Night owl,';
  }

  void _onDayTap(BuildContext context, String day, WorkoutType type) {
    switch (type) {
      case WorkoutType.rest:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const RestScreen(),
          ),
        );
        break;
      default:
        final exercises = getExercisesFor(type);
        if (exercises == null) return;
        final isCardioOnly = type == WorkoutType.sprintCardio ||
            type == WorkoutType.enduranceCardio ||
            type == WorkoutType.lightCardio;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => WorkoutScreen(
              workoutTitle: workoutLabel(type),
              exercises: exercises,
              isCardioOnly: isCardioOnly,
              bodyweightCount: bodyweightBlockCount(type),
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
    final todayType = dayWorkoutMap[_todayName];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 28),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _greeting(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          '$_username 👋',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(fontSize: 34),
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

              const SizedBox(height: 6),
              Text(
                _hypeLine,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colorScheme.primary,
                    ),
              ),

              const SizedBox(height: 20),

              if (todayType != null)
                _TodayHeroCard(
                  dayName: _todayName,
                  type: todayType,
                  pulse: _heroPulse,
                  onTap: () => _onDayTap(context, _todayName, todayType),
                ),

              const SizedBox(height: 26),

              Text(
                'This Week',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(
                'Tap any day to preview or jump in',
                style: Theme.of(context).textTheme.bodyMedium,
              ),

              const SizedBox(height: 16),

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
                    final isToday = day == _todayName;
                    return AnimatedBuilder(
                      animation: _entrance,
                      builder: (context, child) {
                        // Staggered fade + slide-in, ~60ms apart per card.
                        final start = (index * 0.07).clamp(0.0, 0.9);
                        final end = (start + 0.5).clamp(0.0, 1.0);
                        final curved = CurvedAnimation(
                          parent: _entrance,
                          curve: Interval(start, end, curve: Curves.easeOutCubic),
                        );
                        return Opacity(
                          opacity: curved.value,
                          child: Transform.translate(
                            offset: Offset(0, (1 - curved.value) * 24),
                            child: child,
                          ),
                        );
                      },
                      child: _DayCard(
                        day: day,
                        type: type,
                        isToday: isToday,
                        onTap: () => _onDayTap(context, day, type),
                      ),
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

/// Big, glowing call-to-action for *today's* workout — this is the primary
/// thing that should get someone off the couch, so it gets a gradient,
/// a soft pulsing glow, and a punchy "start now" button.
class _TodayHeroCard extends StatelessWidget {
  final String dayName;
  final WorkoutType type;
  final AnimationController pulse;
  final VoidCallback onTap;

  const _TodayHeroCard({
    required this.dayName,
    required this.type,
    required this.pulse,
    required this.onTap,
  });

  List<Color> _gradientFor(WorkoutType t, ColorScheme scheme, bool isDark) {
    switch (t) {
      case WorkoutType.rest:
        return isDark
            ? [const Color(0xFF3A3A4A), const Color(0xFF23232E)]
            : [const Color(0xFFB9BED0), const Color(0xFF9096AC)];
      case WorkoutType.legs:
        return isDark
            ? [const Color(0xFF7B61FF), const Color(0xFF4A32C7)]
            : [const Color(0xFF8C6DFF), const Color(0xFF6A4CD6)];
      case WorkoutType.chestTricepsShoulders:
        return isDark
            ? [const Color(0xFFC6FF00), const Color(0xFF7BA300)]
            : [const Color(0xFF8FC400), const Color(0xFF4C7300)];
      case WorkoutType.backAbsCore:
        return isDark
            ? [const Color(0xFFFF8A5B), const Color(0xFFDB4B24)]
            : [const Color(0xFFFF8A5B), const Color(0xFFCE5423)];
      case WorkoutType.sprintCardio:
        return isDark
            ? [const Color(0xFF00E5D3), const Color(0xFF00838F)]
            : [const Color(0xFF00BFC7), const Color(0xFF00707A)];
      case WorkoutType.enduranceCardio:
        return isDark
            ? [const Color(0xFF6BB3FF), const Color(0xFF1E5FBF)]
            : [const Color(0xFF6BB3FF), const Color(0xFF1E5FBF)];
      case WorkoutType.lightCardio:
        return isDark
            ? [const Color(0xFFFFE066), const Color(0xFFC79A00)]
            : [const Color(0xFFFFD34D), const Color(0xFFAD7E00)];
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;
    final gradient = _gradientFor(type, scheme, isDark);
    final isRest = type == WorkoutType.rest;
    final exercises = getExercisesFor(type);
    final count = exercises?.length ?? 0;

    return AnimatedBuilder(
      animation: pulse,
      builder: (context, child) {
        final glow = 0.18 + (pulse.value * 0.18);
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: gradient.first.withOpacity(glow),
                blurRadius: 28,
                spreadRadius: 2,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        );
      },
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.22),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'TODAY',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.4,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      dayName,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(workoutEmoji(type), style: const TextStyle(fontSize: 40)),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            workoutLabel(type),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            isRest
                                ? workoutSubtitle(type)
                                : '$count exercises • ${workoutSubtitle(type)}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(0.85),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isRest ? 'View Recovery Tips' : 'Start Workout',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: gradient.last,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Icon(Icons.arrow_forward_rounded,
                                size: 18, color: gradient.last),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DayCard extends StatefulWidget {
  final String day;
  final WorkoutType type;
  final VoidCallback onTap;
  final bool isToday;

  const _DayCard({
    required this.day,
    required this.type,
    required this.onTap,
    this.isToday = false,
  });

  @override
  State<_DayCard> createState() => _DayCardState();
}

class _DayCardState extends State<_DayCard> {
  double _scale = 1.0;

  void _setPressed(bool pressed) {
    setState(() => _scale = pressed ? 0.97 : 1.0);
  }

  Color _accentFor(WorkoutType t, bool isDark) {
    switch (t) {
      case WorkoutType.legs:
        return const Color(0xFF7B61FF);
      case WorkoutType.chestTricepsShoulders:
        return isDark ? const Color(0xFFC6FF00) : const Color(0xFF6E8F00);
      case WorkoutType.backAbsCore:
        return const Color(0xFFFF6B35);
      case WorkoutType.sprintCardio:
        return isDark ? const Color(0xFF00CFDD) : const Color(0xFF0091A0);
      case WorkoutType.enduranceCardio:
        return isDark ? const Color(0xFF4A9EFF) : const Color(0xFF1E6FD9);
      case WorkoutType.lightCardio:
        return isDark ? const Color(0xFFFFD600) : const Color(0xFFAD7E00);
      case WorkoutType.rest:
        return isDark ? const Color(0xFF8A8A99) : const Color(0xFF5C5C6B);
    }
  }

  // Only Sunday's full rest day gets the muted "rest" card treatment now —
  // Tue/Thu/Sat are real (if lighter) cardio workouts, not rest days.
  bool _isRestDay(WorkoutType t) => t == WorkoutType.rest;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final accent = _accentFor(widget.type, isDark);
    final isRest = _isRestDay(widget.type);
    final colorScheme = Theme.of(context).colorScheme;
    final secondaryText = _secondaryText(context);
    final faintText = _faintText(context);

    final cardColor = isRest ? colorScheme.surfaceVariant : colorScheme.surface;

    return AnimatedScale(
      scale: _scale,
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: _cardShadow(context),
        ),
        child: Material(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: widget.onTap,
            onTapDown: (_) => _setPressed(true),
            onTapUp: (_) => _setPressed(false),
            onTapCancel: () => _setPressed(false),
            splashColor: accent.withOpacity(0.15),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: widget.isToday
                      ? accent.withOpacity(0.6)
                      : colorScheme.outline,
                  width: widget.isToday ? 1.6 : 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Colored stripe
                  Container(
                    width: 4,
                    height: 60,
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
                        workoutEmoji(widget.type),
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
                        Row(
                          children: [
                            Text(
                              widget.day,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: isRest
                                        ? secondaryText
                                        : colorScheme.onSurface,
                                  ),
                            ),
                            if (widget.isToday) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 7, vertical: 2),
                                decoration: BoxDecoration(
                                  color: accent.withOpacity(0.16),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  'TODAY',
                                  style: TextStyle(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.8,
                                    color: accent,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          workoutLabel(widget.type),
                          style: TextStyle(
                            fontSize: 13,
                            color: accent,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          workoutSubtitle(widget.type),
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
      ),
    );
  }
}