import 'package:FitnessJungle/Screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:FitnessJungle/services/preference_services.dart';

void main() {
  runApp(const BootaWorkoutApp());
}
 
class BootaWorkoutApp extends StatefulWidget {
  const BootaWorkoutApp({super.key});
 
  /// Lets any descendant do `BootaWorkoutApp.of(context).toggleTheme()`
  /// or `.setThemeMode(ThemeMode.light)` without any extra package.
  static BootaWorkoutAppState of(BuildContext context) {
    final state = context.findAncestorStateOfType<BootaWorkoutAppState>();
    assert(state != null, 'BootaWorkoutApp not found in context');
    return state!;
  }
 
  @override
  State<BootaWorkoutApp> createState() => BootaWorkoutAppState();
}
 
class BootaWorkoutAppState extends State<BootaWorkoutApp> {
  ThemeMode _themeMode = ThemeMode.dark;
 
  ThemeMode get themeMode => _themeMode;
 
  @override
  void initState() {
    super.initState();
    _loadTheme();
  }
 
  Future<void> _loadTheme() async {
    final mode = await PreferencesService.getThemeMode();
    if (!mounted) return;
    setState(() => _themeMode = mode);
  }
 
  Future<void> setThemeMode(ThemeMode mode) async {
    setState(() => _themeMode = mode);
    await PreferencesService.setThemeMode(mode);
  }
 
  /// Quick toggle used by the icon button on the Home screen.
  /// Flips between light/dark regardless of "system".
  Future<void> toggleTheme() async {
    final resolvedBrightness = _themeMode == ThemeMode.system
        ? WidgetsBinding.instance.platformDispatcher.platformBrightness
        : (_themeMode == ThemeMode.dark ? Brightness.dark : Brightness.light);
    final next =
        resolvedBrightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(next);
  }
 
  bool get isDark {
    final resolved = _themeMode == ThemeMode.system
        ? WidgetsBinding.instance.platformDispatcher.platformBrightness
        : (_themeMode == ThemeMode.dark ? Brightness.dark : Brightness.light);
    return resolved == Brightness.dark;
  }
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boota Workout',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      home: const SplashScreen(),
    );
  }
}
 
/// Two extra text-color tokens that every screen uses instead of
/// hand-rolled `onSurface.withOpacity(x)`. Low-alpha black on a light
/// background barely renders, so each theme defines concrete, tested
/// colors instead of a shared opacity fraction.
@immutable
class AppTextColors extends ThemeExtension<AppTextColors> {
  final Color secondary; // subtitles, counters, labels
  final Color faint; // chevrons, disabled-looking icons, least emphasis
 
  const AppTextColors({required this.secondary, required this.faint});
 
  @override
  AppTextColors copyWith({Color? secondary, Color? faint}) {
    return AppTextColors(
      secondary: secondary ?? this.secondary,
      faint: faint ?? this.faint,
    );
  }
 
  @override
  AppTextColors lerp(ThemeExtension<AppTextColors>? other, double t) {
    if (other is! AppTextColors) return this;
    return AppTextColors(
      secondary: Color.lerp(secondary, other.secondary, t)!,
      faint: Color.lerp(faint, other.faint, t)!,
    );
  }
}
 
extension AppTextColorsX on BuildContext {
  AppTextColors get appText => Theme.of(this).extension<AppTextColors>()!;
}
 
/// Consistent card elevation used by every "card" container in the app
/// (day cards, settings cards, exercise cards). Dark mode gets no shadow
/// (borders alone read fine on a near-black background); light mode gets
/// a real, visible drop shadow so cards actually separate from the page.
List<BoxShadow> appCardShadow(BuildContext context) {
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
 
/// Holds both theme variants. Both are built off the same shape so
/// every screen that reads `Theme.of(context).colorScheme` just works
/// no matter which mode is active.
class AppTheme {
  AppTheme._();
 
  static final ColorScheme _darkScheme = const ColorScheme.dark(
    primary: Color(0xFFC6FF00),
    onPrimary: Colors.black,
    secondary: Color(0xFF7B61FF),
    onSecondary: Colors.white,
    surface: Color(0xFF1E1E28),
    onSurface: Colors.white,
    surfaceVariant: Color(0xFF2A2A35),
    outline: Color(0xFF2E2E3A),
    background: Color(0xFF0F0F13),
    onBackground: Colors.white,
    error: Color(0xFFFF6B6B),
    onError: Colors.black,
  );
 
  // Redesigned for real contrast: a visibly darker/greyer page background
  // than the white cards (so cards actually "lift" off the page instead of
  // blending into it), a stronger outline, a clearly distinct surfaceVariant
  // for rest-day cards, and a primary green dark enough to read as text
  // on white.
  static final ColorScheme _lightScheme = const ColorScheme.light(
    primary: Color(0xFF4C7300),
    onPrimary: Colors.white,
    secondary: Color(0xFF6C4FFF),
    onSecondary: Colors.white,
    surface: Colors.white,
    onSurface: Color(0xFF14141B),
    surfaceVariant: Color(0xFFDEE0E8),
    outline: Color(0xFFC7C9D3),
    background: Color(0xFFE8E9EF),
    onBackground: Color(0xFF14141B),
    error: Color(0xFFD32F2F),
    onError: Colors.white,
  );
 
  static final ThemeData dark = _build(
    brightness: Brightness.dark,
    colorScheme: _darkScheme,
    mutedText: const Color(0xFFAAAAAA),
    textColors: const AppTextColors(
      secondary: Color(0xFFB6B6C0),
      faint: Color(0xFF7C7C87),
    ),
  );
 
  static final ThemeData light = _build(
    brightness: Brightness.light,
    colorScheme: _lightScheme,
    mutedText: const Color(0xFF57575F),
    textColors: const AppTextColors(
      secondary: Color(0xFF4D4D57),
      faint: Color(0xFF83838D),
    ),
  );
 
  static ThemeData _build({
    required Brightness brightness,
    required ColorScheme colorScheme,
    required Color mutedText,
    required AppTextColors textColors,
  }) {
    return ThemeData(
      brightness: brightness,
      scaffoldBackgroundColor: colorScheme.background,
      colorScheme: colorScheme,
      useMaterial3: true,
      extensions: [textColors],
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 48,
          fontWeight: FontWeight.w900,
          letterSpacing: -1,
          color: colorScheme.onBackground,
        ),
        headlineMedium: TextStyle(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
          color: colorScheme.onBackground,
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: colorScheme.onBackground,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          color: mutedText,
        ),
      ),
      iconTheme: IconThemeData(color: colorScheme.onBackground),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.background,
        foregroundColor: colorScheme.onBackground,
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          minimumSize: const Size.fromHeight(56),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: mutedText,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? colorScheme.primary
              : null,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (states) => states.contains(WidgetState.selected)
              ? colorScheme.primary.withOpacity(0.4)
              : null,
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? colorScheme.primary
                : colorScheme.surfaceVariant,
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) => states.contains(WidgetState.selected)
                ? colorScheme.onPrimary
                : colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}