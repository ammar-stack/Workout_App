enum ExerciseCategory { cardio, strength }

class Exercise {
  final String name;
  final String imagePath;
  final int reps;
  final int sets;
  final ExerciseCategory category;
  final bool isDuration; // true => `reps` means minutes, not rep count
  final String? unitLabel; // overrides the default MIN/REPS chip label
  // (e.g. 'METERS', 'KM') for exercises measured in something else.

  const Exercise({
    required this.name,
    required this.imagePath,
    required this.reps,
    required this.sets,
    this.category = ExerciseCategory.strength,
    this.isDuration = false,
    this.unitLabel,
  });
}

// ── Shared warm-up block ─────────────────────────────────────────
// Used at the start of every "Morning Gym" day (Legs, Chest/Triceps/
// Shoulders, Back/Abs/Core) before the day's specific exercises.
const List<Exercise> cardioExercises = [
  Exercise(
    name: 'Jogging',
    imagePath: 'assets/images/jogging.jpg',
    reps: 10,
    sets: 1,
    category: ExerciseCategory.cardio,
    isDuration: true,
  ),
  Exercise(
    name: 'Jumping Jacks',
    imagePath: 'assets/images/jumping_jacks.jpg',
    reps: 30,
    sets: 2,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Alternate Knees',
    imagePath: 'assets/images/alternate_knees.jpg',
    reps: 30,
    sets: 2,
    category: ExerciseCategory.cardio,
  ),
];

// ── Monday: Morning Gym (Legs + Glutes + Plyometrics) ────────────
// Bodyweight / plyometric block, in the order given in the weekly plan.
const List<Exercise> legsCardioExercises = [
  Exercise(
    name: 'Lunges (Weighted)',
    imagePath: 'assets/images/lunges.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Reverse Lunges',
    imagePath: 'assets/images/reverse_lunges.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Side Lunges',
    imagePath: 'assets/images/side_lunges.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Wall Sit',
    imagePath: 'assets/images/wall_sit.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Calf Raises',
    imagePath: 'assets/images/calf_raises.jpg',
    reps: 20,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Glutes Bridge',
    imagePath: 'assets/images/glutes_bridge.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Alternating Step-Ups (Weighted)',
    imagePath: 'assets/images/alternating_step_ups.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Box Jumps',
    imagePath: 'assets/images/box_jumps.jpg',
    reps: 10,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Squat Jumps',
    imagePath: 'assets/images/squat_jumps.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
];

// Gym (weighted) block for Legs + Glutes — sourced from the head-to-toe
// reference document's QUADS, HAMSTRINGS, and GLUTES sections.
const List<Exercise> legsGymExercises = [
  Exercise(
    name: 'Barbell Back Squat',
    imagePath: 'assets/images/barbell_back_squat.jpg',
    reps: 8,
    sets: 4,
  ),
  Exercise(
    name: 'Romanian Deadlift (Barbell)',
    imagePath: 'assets/images/romanian_deadlift.jpg',
    reps: 10,
    sets: 3,
  ),
  Exercise(
    name: 'Leg Press (Machine)',
    imagePath: 'assets/images/leg_press_vertical.jpg',
    reps: 12,
    sets: 3,
  ),
  Exercise(
    name: 'Leg Extension (Machine)',
    imagePath: 'assets/images/leg_extension_machine.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Barbell Hip Thrust',
    imagePath: 'assets/images/hip_thrusts.jpg',
    reps: 10,
    sets: 4,
  ),
  Exercise(
    name: 'Dumbbell Bulgarian Split Squat',
    imagePath: 'assets/images/dumbbell_bulgarian_split_squat.jpg',
    reps: 12,
    sets: 3,
  ),
];

// ── Wednesday: Morning Gym (Chest + Triceps + Shoulders) ─────────
// Bodyweight block, in the exact order given in the weekly plan.
const List<Exercise> chestCardioExercises = [
  Exercise(
    name: 'Pushup (Weighted)',
    imagePath: 'assets/images/pushup.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Wide Grip Pushup',
    imagePath: 'assets/images/wide_grip_pushup.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Decline Pushup',
    imagePath: 'assets/images/decline_pushup.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Incline Pushup',
    imagePath: 'assets/images/incline_pushup.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Pike Pushup',
    imagePath: 'assets/images/pike_pushup.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Diamond Pushup',
    imagePath: 'assets/images/diamond_pushup.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Tricep Dip (Weighted if possible)',
    imagePath: 'assets/images/tricep_dip.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Arm Circle',
    imagePath: 'assets/images/arm_circle.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Plank Shoulder Tap',
    imagePath: 'assets/images/plank_shoulder_tap.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
];

// Gym (weighted) block for Chest + Triceps + Shoulders — sourced from the
// reference document's CHEST, SHOULDERS & TRAPS, and TRICEPS sections.
const List<Exercise> chestShoulderTricepGymExercises = [
  Exercise(
    name: 'Barbell Flat Bench Press',
    imagePath: 'assets/images/barbell_bench_press.jpg',
    reps: 8,
    sets: 4,
  ),
  Exercise(
    name: 'Dumbbell Incline Press',
    imagePath: 'assets/images/incline_dumbbell_press.jpg',
    reps: 12,
    sets: 3,
  ),
  Exercise(
    name: 'Dumbbell Flyes',
    imagePath: 'assets/images/dumbbell_flyes.jpg',
    reps: 15,
    sets: 2,
  ),
  Exercise(
    name: 'Barbell Overhead Press',
    imagePath: 'assets/images/barbell_overhead_press.jpg',
    reps: 8,
    sets: 4,
  ),
  Exercise(
    name: 'Dumbbell Lateral Raises',
    imagePath: 'assets/images/dumbbell_lateral_raise.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Seated Dumbbell Shoulder Press',
    imagePath: 'assets/images/seated_dumbbell_shoulder_press.jpg',
    reps: 10,
    sets: 3,
  ),
  Exercise(
    name: 'Cable Triceps Pushdown',
    imagePath: 'assets/images/cable_triceps_pushdown.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Overhead Dumbbell Triceps Extension',
    imagePath: 'assets/images/overhead_dumbbell_tricep_extension.jpg',
    reps: 12,
    sets: 2,
  ),
];

// ── Friday: Morning Gym (Back + Abs + Core) ──────────────────────
// Bodyweight/core block. The weekly plan trims the old ab list down to
// 5 moves (Crunches, Leg Raise, Bicycle Crunch, Plank, Russian Twists —
// Toe Touch Crunch, Flutter Kicks, Hanging Leg Raise, and Weighted
// Russian Twist were removed "to avoid overkill") and adds Pull-Ups and
// Inverted Rows for the back component.
const List<Exercise> backAbsCoreExercises = [
  Exercise(
    name: 'Pull-Ups',
    imagePath: 'assets/images/pull_ups.jpg',
    reps: 8,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Inverted Rows (or Dumbbell Rows)',
    imagePath: 'assets/images/inverted_rows.jpg',
    reps: 12,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Crunches',
    imagePath: 'assets/images/crunches.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Leg Raise',
    imagePath: 'assets/images/leg_raise.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Bicycle Crunch',
    imagePath: 'assets/images/bicycle_crunch.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Plank',
    imagePath: 'assets/images/plank.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Russian Twists',
    imagePath: 'assets/images/russian_twists.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
];

// Gym (weighted) block for Back — sourced from the reference document's
// BACK section.
const List<Exercise> backGymExercises = [
  Exercise(
    name: 'Barbell Deadlift',
    imagePath: 'assets/images/deadlift.jpg',
    reps: 6,
    sets: 4,
  ),
  Exercise(
    name: 'Barbell Bent-Over Row',
    imagePath: 'assets/images/barbell_bent_over_row.jpg',
    reps: 10,
    sets: 4,
  ),
  Exercise(
    name: 'Lat Pulldown (Cable)',
    imagePath: 'assets/images/lat_pulldown.jpg',
    reps: 12,
    sets: 3,
  ),
  Exercise(
    name: 'Seated Cable Row',
    imagePath: 'assets/images/seated_cable_row.jpg',
    reps: 12,
    sets: 3,
  ),
  Exercise(
    name: 'T-Bar Row',
    imagePath: 'assets/images/t_bar_row.jpg',
    reps: 10,
    sets: 3,
  ),
  Exercise(
    name: 'Single-Arm Dumbbell Row',
    imagePath: 'assets/images/one_arm_dumbbell_rows.jpg',
    reps: 12,
    sets: 3,
  ),
];

// ── Tuesday: Cardio ONLY — Sprint Session ────────────────────────
const List<Exercise> sprintCardioExercises = [
  Exercise(
    name: '100m Sprints',
    imagePath: 'assets/images/sprint_100m.jpg',
    reps: 100,
    sets: 10,
    category: ExerciseCategory.cardio,
    unitLabel: 'METERS',
  ),
];

// ── Thursday: Cardio ONLY — Endurance Jog ────────────────────────
const List<Exercise> enduranceCardioExercises = [
  Exercise(
    name: 'Endurance Jog (Steady Pace)',
    imagePath: 'assets/images/endurance_jog.jpg',
    reps: 5,
    sets: 1,
    category: ExerciseCategory.cardio,
    unitLabel: 'KM',
  ),
];

// ── Saturday: Cardio ONLY — Light Mix (Jog + Few Sprints) ────────
const List<Exercise> lightCardioExercises = [
  Exercise(
    name: 'Light Jog',
    imagePath: 'assets/images/jogging.jpg',
    reps: 15,
    sets: 1,
    category: ExerciseCategory.cardio,
    isDuration: true,
  ),
  Exercise(
    name: 'A Few Sprints',
    imagePath: 'assets/images/sprint_100m.jpg',
    reps: 100,
    sets: 4,
    category: ExerciseCategory.cardio,
    unitLabel: 'METERS',
  ),
];

enum WorkoutType {
  legs,
  chestTricepsShoulders,
  backAbsCore,
  sprintCardio,
  enduranceCardio,
  lightCardio,
  rest,
}

// Weekly schedule, matching the updated training plan:
// Mon: Legs + Glutes + Plyometrics (gym)
// Tue: Cardio only — Sprint Session
// Wed: Chest + Triceps + Shoulders (gym)
// Thu: Cardio only — Endurance Jog
// Fri: Back + Abs + Core (gym)
// Sat: Cardio only — Light Mix
// Sun: Full Rest
const Map<String, WorkoutType> dayWorkoutMap = {
  'Monday': WorkoutType.legs,
  'Tuesday': WorkoutType.sprintCardio,
  'Wednesday': WorkoutType.chestTricepsShoulders,
  'Thursday': WorkoutType.enduranceCardio,
  'Friday': WorkoutType.backAbsCore,
  'Saturday': WorkoutType.lightCardio,
  'Sunday': WorkoutType.rest,
};

/// Returns the full exercise flow for a given day.
/// Every "Morning Gym" day starts with the shared cardio warm-up block,
/// followed by that day's bodyweight/plyometric moves, then that day's
/// gym (weighted) exercises pulled from the reference document.
/// Pure cardio days return just their own single-focus list.
/// Rest day (Sunday) has no exercise list — handled by its own screen.
List<Exercise>? getExercisesFor(WorkoutType type) {
  switch (type) {
    case WorkoutType.legs:
      return [...cardioExercises, ...legsCardioExercises, ...legsGymExercises];
    case WorkoutType.chestTricepsShoulders:
      return [
        ...cardioExercises,
        ...chestCardioExercises,
        ...chestShoulderTricepGymExercises,
      ];
    case WorkoutType.backAbsCore:
      return [
        ...cardioExercises,
        ...backAbsCoreExercises,
        ...backGymExercises,
      ];
    case WorkoutType.sprintCardio:
      return sprintCardioExercises;
    case WorkoutType.enduranceCardio:
      return enduranceCardioExercises;
    case WorkoutType.lightCardio:
      return lightCardioExercises;
    case WorkoutType.rest:
      return null;
  }
}

String workoutLabel(WorkoutType type) {
  switch (type) {
    case WorkoutType.legs:
      return 'Leg Day';
    case WorkoutType.chestTricepsShoulders:
      return 'Chest, Triceps & Shoulders';
    case WorkoutType.backAbsCore:
      return 'Back, Abs & Core';
    case WorkoutType.sprintCardio:
      return 'Sprint Session';
    case WorkoutType.enduranceCardio:
      return 'Endurance Jog';
    case WorkoutType.lightCardio:
      return 'Light Cardio Mix';
    case WorkoutType.rest:
      return 'Full Rest';
  }
}

String workoutEmoji(WorkoutType type) {
  switch (type) {
    case WorkoutType.legs:
      return '🦵';
    case WorkoutType.chestTricepsShoulders:
      return '💪';
    case WorkoutType.backAbsCore:
      return '🚣';
    case WorkoutType.sprintCardio:
      return '⚡';
    case WorkoutType.enduranceCardio:
      return '🏃';
    case WorkoutType.lightCardio:
      return '🎽';
    case WorkoutType.rest:
      return '😴';
  }
}

String workoutSubtitle(WorkoutType type) {
  switch (type) {
    case WorkoutType.legs:
      return 'Cardio + Bodyweight/Plyo + Gym Weights';
    case WorkoutType.chestTricepsShoulders:
      return 'Cardio + Bodyweight + Gym Weights';
    case WorkoutType.backAbsCore:
      return 'Cardio + Bodyweight/Core + Gym Weights';
    case WorkoutType.sprintCardio:
      return '10x 100m Sprints';
    case WorkoutType.enduranceCardio:
      return '5K Steady-Pace Jog';
    case WorkoutType.lightCardio:
      return 'Light Jog + a Few Sprints';
    case WorkoutType.rest:
      return 'Recover & recharge, Boota';
  }
}