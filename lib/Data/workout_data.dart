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
// Bodyweight / cardio block — the full "Legs workout" list.
// Note: the source list included "Wall Sit" twice (once mid-list, once
// at the end as "Wallsit"); it's kept here as a single entry to avoid
// showing the exact same exercise back-to-back in the flow.
const List<Exercise> legsCardioExercises = [
  Exercise(
    name: 'Bodyweight Squat',
    imagePath: 'assets/images/bodyweight_squat.jpg',
    reps: 20,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Sumo Squat',
    imagePath: 'assets/images/sumo_squat.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Jump Squat',
    imagePath: 'assets/images/jump_squat.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Wall Sit',
    imagePath: 'assets/images/wall_sit.jpg',
    reps: 30,
    sets: 3,
    category: ExerciseCategory.cardio,
    unitLabel: 'SEC',
  ),
  Exercise(
    name: 'Forward Lunge',
    imagePath: 'assets/images/forward_lunge.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Reverse Lunge',
    imagePath: 'assets/images/reverse_lunge.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Side Lunge',
    imagePath: 'assets/images/side_lunge.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Bulgarian Split Squat',
    imagePath: 'assets/images/bulgarian_split_squat_bodyweight.jpg',
    reps: 12,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Single Leg Glute Bridge',
    imagePath: 'assets/images/single_leg_glute_bridge.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Donkey Kicks',
    imagePath: 'assets/images/donkey_kicks.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Fire Hydrant',
    imagePath: 'assets/images/fire_hydrant.jpg',
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
    name: 'Single Leg Calf Raises',
    imagePath: 'assets/images/single_leg_calf_raises.jpg',
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
// Bodyweight / cardio block — the full "Chest for Arm and shoulder" list.
// Note: "Bear" in the source list is treated as "Bear Crawl", the
// standard bodyweight move that name refers to.
const List<Exercise> chestCardioExercises = [
  Exercise(
    name: 'Pushup',
    imagePath: 'assets/images/pushup.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Wide Arm Pushup',
    imagePath: 'assets/images/wide_grip_pushup.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Diamond Pushup',
    imagePath: 'assets/images/diamond_pushup.jpg',
    reps: 12,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Decline Pushup',
    imagePath: 'assets/images/decline_pushup.jpg',
    reps: 12,
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
    name: 'Pause Pushup',
    imagePath: 'assets/images/pause_pushup.jpg',
    reps: 10,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Pike Pushup',
    imagePath: 'assets/images/pike_pushup.jpg',
    reps: 12,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Plank Shoulder Taps',
    imagePath: 'assets/images/plank_shoulder_tap.jpg',
    reps: 20,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Superman Holds',
    imagePath: 'assets/images/superman_hold.jpg',
    reps: 30,
    sets: 3,
    category: ExerciseCategory.cardio,
    unitLabel: 'SEC',
  ),
  Exercise(
    name: 'Wrist Rotation',
    imagePath: 'assets/images/wrist_rotation.jpg',
    reps: 10,
    sets: 2,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Fist Pushups',
    imagePath: 'assets/images/fist_pushups.jpg',
    reps: 10,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Back of Hand Pushups',
    imagePath: 'assets/images/back_of_hand_pushups.jpg',
    reps: 10,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Wrist Stretch',
    imagePath: 'assets/images/wrist_stretch.jpg',
    reps: 20,
    sets: 2,
    category: ExerciseCategory.cardio,
    unitLabel: 'SEC',
  ),
  Exercise(
    name: 'Burpees',
    imagePath: 'assets/images/burpees.jpg',
    reps: 12,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Bear Crawl',
    imagePath: 'assets/images/bear_crawl.jpg',
    reps: 30,
    sets: 3,
    category: ExerciseCategory.cardio,
    unitLabel: 'SEC',
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
// Bodyweight / cardio block — the full "ABS Cardio Exercises" list.
// Pull-Ups and Inverted Rows were dropped from this bodyweight block
// since the back component is already fully covered by backGymExercises
// below (Deadlift, Bent-Over Row, Lat Pulldown, Seated Cable Row,
// T-Bar Row, Single-Arm Row) — nothing from the weighted back day is
// missing, it's just not duplicated here as bodyweight too.
const List<Exercise> backAbsCoreExercises = [
  Exercise(
    name: 'Basic Crunch',
    imagePath: 'assets/images/basic_crunch.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Reverse Crunch',
    imagePath: 'assets/images/reverse_crunch.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Bicycle Crunch',
    imagePath: 'assets/images/bicycle_crunch.jpg',
    reps: 20,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Forearm Plank',
    imagePath: 'assets/images/forearm_plank.jpg',
    reps: 30,
    sets: 3,
    category: ExerciseCategory.cardio,
    unitLabel: 'SEC',
  ),
  Exercise(
    name: 'Straight Arm Plank',
    imagePath: 'assets/images/straight_arm_plank.jpg',
    reps: 30,
    sets: 3,
    category: ExerciseCategory.cardio,
    unitLabel: 'SEC',
  ),
  Exercise(
    name: 'Side Plank',
    imagePath: 'assets/images/side_plank.jpg',
    reps: 20,
    sets: 3,
    category: ExerciseCategory.cardio,
    unitLabel: 'SEC',
  ),
  Exercise(
    name: 'Plank Shoulder Tap',
    imagePath: 'assets/images/plank_shoulder_tap.jpg',
    reps: 20,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Plank Hip Dips',
    imagePath: 'assets/images/plank_hip_dips.jpg',
    reps: 20,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Leg Raises',
    imagePath: 'assets/images/leg_raise.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Hanging Leg Raise',
    imagePath: 'assets/images/hanging_leg_raise.jpg',
    reps: 12,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Flutter Kicks',
    imagePath: 'assets/images/flutter_kicks.jpg',
    reps: 30,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Scissor Kicks',
    imagePath: 'assets/images/scissor_kicks.jpg',
    reps: 30,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Heel Taps',
    imagePath: 'assets/images/heel_taps.jpg',
    reps: 20,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'V-Ups',
    imagePath: 'assets/images/v_ups.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Russian Twists',
    imagePath: 'assets/images/russian_twists.jpg',
    reps: 20,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Side Bends',
    imagePath: 'assets/images/side_bends.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Standing Knee to Elbow Crunch',
    imagePath: 'assets/images/standing_knee_to_elbow_crunch.jpg',
    reps: 20,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Burpees',
    imagePath: 'assets/images/burpees.jpg',
    reps: 12,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Mountain Climbers',
    imagePath: 'assets/images/mountain_climbers.jpg',
    reps: 30,
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

/// Number of exercises in the shared warm-up block (Jogging, Jumping
/// Jacks, Alternate Knees) that every "Morning Gym" day starts with.
/// WorkoutScreen uses this — instead of a hardcoded number — to know
/// where the warm-up ends and the day's own bodyweight block begins.
final int warmupExerciseCount = cardioExercises.length;

/// Number of exercises in the day's own bodyweight/cardio block, i.e.
/// everything in getExercisesFor() between the shared warm-up and the
/// gym (weighted) block. Each "Morning Gym" day has a different-length
/// bodyweight block, so this can't be a single constant — WorkoutScreen
/// asks for it per WorkoutType instead of assuming a fixed size.
/// Returns 0 for cardio-only days and rest, since there's no separate
/// bodyweight block to distinguish from warm-up/gym on those days.
int bodyweightBlockCount(WorkoutType type) {
  switch (type) {
    case WorkoutType.legs:
      return legsCardioExercises.length;
    case WorkoutType.chestTricepsShoulders:
      return chestCardioExercises.length;
    case WorkoutType.backAbsCore:
      return backAbsCoreExercises.length;
    case WorkoutType.sprintCardio:
    case WorkoutType.enduranceCardio:
    case WorkoutType.lightCardio:
    case WorkoutType.rest:
      return 0;
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