import 'package:FitnessJungle/Screens/HomeScreen.dart';
import 'package:FitnessJungle/Screens/usernamescreen.dart';
import 'package:FitnessJungle/main.dart';
import 'package:flutter/material.dart';
import 'package:FitnessJungle/services/preference_services.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback? onUsernameChanged;
  const SettingsScreen({super.key, this.onUsernameChanged});
 
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}
 
class _SettingsScreenState extends State<SettingsScreen> {
  final _nameController = TextEditingController();
  bool _loading = true;
  bool _haptics = true;
  bool _reminders = false;
  bool _nameDirty = false;
 
  @override
  void initState() {
    super.initState();
    _load();
    _nameController.addListener(() {
      if (!_nameDirty) setState(() => _nameDirty = true);
    });
  }
 
  Future<void> _load() async {
    final name = await PreferencesService.getUsername();
    final haptics = await PreferencesService.getHapticFeedback();
    final reminders = await PreferencesService.getReminders();
    if (!mounted) return;
    setState(() {
      _nameController.text = name ?? '';
      _haptics = haptics;
      _reminders = reminders;
      _loading = false;
      _nameDirty = false;
    });
  }
 
  Future<void> _saveName() async {
    final trimmed = _nameController.text.trim();
    if (trimmed.isEmpty) return;
    await PreferencesService.setUsername(trimmed);
    setState(() => _nameDirty = false);
    widget.onUsernameChanged?.call();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Name updated ✅'), duration: Duration(seconds: 1)),
    );
  }
 
  Future<void> _resetApp() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reset app?'),
        content: const Text(
          'This clears your name and preferences. You\'ll be asked to '
          'set up your profile again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
 
    if (confirmed != true || !mounted) return;
 
    await PreferencesService.clearAll();
    if (!mounted) return;
 
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const UsernameScreen()),
      (route) => false,
    );
  }
 
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final appState = BootaWorkoutApp.of(context);
 
    return Scaffold(
      body: SafeArea(
        child: _loading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                children: [
                  Text(
                    'Settings',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 24),
 
                  _SectionLabel('Profile'),
                  const SizedBox(height: 10),
                  _SettingsCard(
                    child: TextField(
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      style: TextStyle(color: colorScheme.onSurface, fontSize: 16),
                      decoration: InputDecoration(
                        labelText: 'Your name',
                        labelStyle: TextStyle(
                          color: context.appText.secondary,
                        ),
                        border: InputBorder.none,
                        suffixIcon: _nameDirty
                            ? IconButton(
                                icon: Icon(Icons.check_circle_rounded,
                                    color: colorScheme.primary),
                                onPressed: _saveName,
                              )
                            : null,
                      ),
                      onSubmitted: (_) => _saveName(),
                    ),
                  ),
 
                  const SizedBox(height: 28),
 
                  _SectionLabel('Appearance'),
                  const SizedBox(height: 10),
                  _SettingsCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Theme',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: context.appText.secondary,
                          ),
                        ),
                        const SizedBox(height: 12),
                        SegmentedButton<ThemeMode>(
                          segments: const [
                            ButtonSegment(
                              value: ThemeMode.light,
                              icon: Icon(Icons.light_mode_rounded, size: 18),
                              label: Text('Light'),
                            ),
                            ButtonSegment(
                              value: ThemeMode.dark,
                              icon: Icon(Icons.dark_mode_rounded, size: 18),
                              label: Text('Dark'),
                            ),
                            ButtonSegment(
                              value: ThemeMode.system,
                              icon: Icon(Icons.smartphone_rounded, size: 18),
                              label: Text('Auto'),
                            ),
                          ],
                          selected: {appState.themeMode},
                          onSelectionChanged: (selection) {
                            appState.setThemeMode(selection.first);
                          },
                        ),
                      ],
                    ),
                  ),
 
                  const SizedBox(height: 28),
 
                  _SectionLabel('Preferences'),
                  const SizedBox(height: 10),
                  _SettingsCard(
                    child: Column(
                      children: [
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Haptic feedback'),
                          subtitle: Text(
                            'Vibrate on button taps',
                            style: TextStyle(
                              fontSize: 12,
                              color: context.appText.secondary,
                            ),
                          ),
                          value: _haptics,
                          onChanged: (value) async {
                            setState(() => _haptics = value);
                            await PreferencesService.setHapticFeedback(value);
                          },
                        ),
                        Divider(color: colorScheme.outline, height: 1),
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: const Text('Workout reminders'),
                          subtitle: Text(
                            'Daily nudge to complete your workout',
                            style: TextStyle(
                              fontSize: 12,
                              color: context.appText.secondary,
                            ),
                          ),
                          value: _reminders,
                          onChanged: (value) async {
                            setState(() => _reminders = value);
                            await PreferencesService.setReminders(value);
                          },
                        ),
                      ],
                    ),
                  ),
 
                  const SizedBox(height: 28),
 
                  _SectionLabel('About'),
                  const SizedBox(height: 10),
                  _SettingsCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'App version',
                              style: TextStyle(color: colorScheme.onSurface),
                            ),
                            Text(
                              '1.0.0',
                              style: TextStyle(
                                color: context.appText.secondary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
 
                  const SizedBox(height: 16),
 
                  TextButton.icon(
                    onPressed: _resetApp,
                    icon: Icon(Icons.restart_alt_rounded,
                        color: colorScheme.error),
                    label: Text(
                      'Reset app data',
                      style: TextStyle(color: colorScheme.error),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
 
class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);
 
  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.2,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
 
class _SettingsCard extends StatelessWidget {
  final Widget child;
  const _SettingsCard({required this.child});
 
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outline, width: 1),
        boxShadow: appCardShadow(context),
      ),
      child: child,
    );
  }
}