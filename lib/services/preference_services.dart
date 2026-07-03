import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Central place for everything the app persists on-device.
/// Keeps SharedPreferences key names in one spot so screens
/// never touch raw string keys directly.
class PreferencesService {
  static const _keyUsername = 'username';
  static const _keyThemeMode = 'theme_mode'; // 'light' | 'dark' | 'system'
  static const _keyHapticFeedback = 'haptic_feedback';
  static const _keyReminders = 'workout_reminders';
 
  // ── Username ─────────────────────────────────────────────
  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyUsername);
  }
 
  static Future<bool> hasUsername() async {
    final name = await getUsername();
    return name != null && name.trim().isNotEmpty;
  }
 
  static Future<void> setUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyUsername, username.trim());
  }
 
  // ── Theme ────────────────────────────────────────────────
  static Future<ThemeMode> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    switch (prefs.getString(_keyThemeMode)) {
      case 'light':
        return ThemeMode.light;
      case 'system':
        return ThemeMode.system;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.dark; // app's original default look
    }
  }
 
  static Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.system => 'system',
      ThemeMode.dark => 'dark',
    };
    await prefs.setString(_keyThemeMode, value);
  }
 
  // ── Misc preferences (extra features) ───────────────────
  static Future<bool> getHapticFeedback() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyHapticFeedback) ?? true;
  }
 
  static Future<void> setHapticFeedback(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyHapticFeedback, value);
  }
 
  static Future<bool> getReminders() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyReminders) ?? false;
  }
 
  static Future<void> setReminders(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyReminders, value);
  }
 
  /// Wipes everything (used by "Reset App" in Settings).
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
 