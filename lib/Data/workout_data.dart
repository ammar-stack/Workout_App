enum ExerciseCategory { cardio, strength }

class Exercise {
  final String name;
  final String imagePath;
  final int reps;
  final int sets;
  final ExerciseCategory category;
  final bool isDuration; // true => `reps` means minutes, not rep count

  const Exercise({
    required this.name,
    required this.imagePath,
    required this.reps,
    required this.sets,
    this.category = ExerciseCategory.strength,
    this.isDuration = false,
  });
}

// ── Cardio block (Jog + Jumping Jacks + Alternate Knees) ────────
// Used as the warm-up on every training day, and alone on pure cardio days.
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

// ── Monday: Leg Day — bodyweight block (no equipment) ───────────
// From your gym sheet's "Legs" bodyweight rows. Tagged as cardio so it
// groups with the warm-up under the 🏃 CARDIO WARM-UP section.
const List<Exercise> legsCardioExercises = [
  Exercise(
    name: 'Lunges',
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
    name: 'Alternating Step-Ups',
    imagePath: 'assets/images/alternating_step_ups.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
];

// ── Monday: Leg Day — gym block (barbell / machine) ──────────────
const List<Exercise> legsGymExercises = [
  Exercise(
    name: 'Barbell Back Squat',
    imagePath: 'assets/images/barbell_back_squat.jpg',
    reps: 8,
    sets: 4,
  ),
  Exercise(
    name: 'Deadlift',
    imagePath: 'assets/images/deadlift.jpg',
    reps: 8,
    sets: 4,
  ),
  Exercise(
    name: 'Leg Extension (Machine)',
    imagePath: 'assets/images/leg_extension_machine.jpg',
    reps: 15,
    sets: 3,
  ),
  
  Exercise(
    name: 'Romanian Deadlift (RDL)',
    imagePath: 'assets/images/romanian_deadlift.jpg',
    reps: 10,
    sets: 4,
  ),
  Exercise(
    name: 'Leg Press (Vertical)',
    imagePath: 'assets/images/leg_press_vertical.jpg',
    reps: 12,
    sets: 4,
  ),
  Exercise(
    name: 'Hip Thrusts',
    imagePath: 'assets/images/hip_thrusts.jpg',
    reps: 12,
    sets: 4,
  ),
  
];

// ── Wednesday: Chest Day — bodyweight block (no equipment) ───────
// From your gym sheet's "Chest" bodyweight rows. Tagged as cardio so it
// groups with the warm-up under the 🏃 CARDIO WARM-UP section.
const List<Exercise> chestCardioExercises = [
  Exercise(
    name: 'Pushup',
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
    name: 'Plank Shoulder Tap',
    imagePath: 'assets/images/plank_shoulder_tap.jpg',
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
    name: 'Diamond Pushup',
    imagePath: 'assets/images/diamond_pushup.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Tricep Dip',
    imagePath: 'assets/images/tricep_dip.jpg',
    reps: 15,
    sets: 3,
    category: ExerciseCategory.cardio,
  ),
];

// ── Wednesday: Chest Day — gym block (barbell / dumbbell / cable) ─
const List<Exercise> chestGymExercises = [
  Exercise(
    name: 'Barbell Flat Bench Press',
    imagePath: 'assets/images/barbell_bench_press.jpg',
    reps: 8,
    sets: 4,
  ),
  Exercise(
    name: 'Barbell Incline Bench Press',
    imagePath: 'assets/images/barbell_incline_bench_press.jpg',
    reps: 8,
    sets: 4,
  ),
  Exercise(
    name: 'Dumbbell Flat Bench Press',
    imagePath: 'assets/images/dumbbell_flat_bench_press.jpg',
    reps: 10,
    sets: 3,
  ),
  Exercise(
    name: 'Dumbbell Incline Bench Press',
    imagePath: 'assets/images/incline_dumbbell_press.jpg',
    reps: 10,
    sets: 3,
  ),
  Exercise(
    name: 'Cable Fly',
    imagePath: 'assets/images/cable_fly.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Machine Fly',
    imagePath: 'assets/images/pec_deck_machine.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Dumbbell Lateral Raise',
    imagePath: 'assets/images/dumbbell_lateral_raise.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Dumbbell Bench Press',
    imagePath: 'assets/images/dumbbell_bench_press.jpg',
    reps: 10,
    sets: 3,
  ),
  Exercise(
    name: 'Standing Dumbbell Press',
    imagePath: 'assets/images/standing_dumbbell_press.jpg',
    reps: 10,
    sets: 3,
  ),
  Exercise(
    name: 'Dumbbell Tricep Kickback',
    imagePath: 'assets/images/dumbbell_tricep_kickback.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'One Arm Dumbbell Rows',
    imagePath: 'assets/images/one_arm_dumbbell_rows.jpg',
    reps: 12,
    sets: 3,
  ),
  Exercise(
    name: 'Dumbbell Arnold Press',
    imagePath: 'assets/images/dumbbell_arnold_press.jpg',
    reps: 10,
    sets: 3,
  ),
  Exercise(
    name: 'Overhead Dumbbell Tricep Extension',
    imagePath: 'assets/images/overhead_dumbbell_tricep_extension.jpg',
    reps: 15,
    sets: 3,
  ),
];

// ── Friday: Core & Abs Day ────────────────────────────────────
// No replacement list was given for this day, so the original
// bodyweight + gym core exercises are kept.
const List<Exercise> absExercises = [
  Exercise(
    name: 'Crunches',
    imagePath: 'assets/images/crunches.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Toe Touch Crunch',
    imagePath: 'assets/images/toe_touch_crunch.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Leg Raise',
    imagePath: 'assets/images/leg_raise.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Flutter Kicks',
    imagePath: 'assets/images/flutter_kicks.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Bicycle Crunch',
    imagePath: 'assets/images/bicycle_crunch.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Russian Twists',
    imagePath: 'assets/images/russian_twists.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Plank',
    imagePath: 'assets/images/plank.jpg',
    reps: 15,
    sets: 3,
  ),
  
  Exercise(
    name: 'Hanging Leg Raise',
    imagePath: 'assets/images/hanging_leg_raise.jpg',
    reps: 12,
    sets: 3,
  ),
  
  Exercise(
    name: 'Weighted Russian Twist',
    imagePath: 'assets/images/weighted_russian_twist.jpg',
    reps: 20,
    sets: 3,
  ),
];

// ── Saturday: Full Body Burn ──────────────────────────────────
// No replacement list was given for this day, so the original moves are kept.
const List<Exercise> fullBodyExercises = [
  Exercise(
    name: 'Mountain Climbers',
    imagePath: 'assets/images/mountain_climbers.jpeg',
    reps: 20,
    sets: 3,
  ),
  Exercise(
    name: 'Plank Shoulder Tap',
    imagePath: 'assets/images/plank_shoulder_tap.png',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Arm Circle',
    imagePath: 'assets/images/arm_circle.png',
    reps: 20,
    sets: 3,
  ),
  Exercise(
    name: 'Plank',
    imagePath: 'assets/images/plank.jpg',
    reps: 15,
    sets: 3,
  ),
];

enum WorkoutType { legs, cardio, chest, abs, fullBody, walk }

const Map<String, WorkoutType> dayWorkoutMap = {
  'Monday': WorkoutType.legs,
  'Tuesday': WorkoutType.cardio,
  'Wednesday': WorkoutType.chest,
  'Thursday': WorkoutType.cardio,
  'Friday': WorkoutType.abs,
  'Saturday': WorkoutType.fullBody,
  'Sunday': WorkoutType.walk,
};

/// Returns the full exercise flow for a given day.
/// Every strength day starts with the shared cardio warm-up block,
/// followed by that day's specific exercise list.
/// - cardio (Tue/Thu): jog + jumping jacks + alternate knees only
/// - walk (Sunday): no exercise list — handled by its own screen
List<Exercise>? getExercisesFor(WorkoutType type) {
  switch (type) {
    case WorkoutType.legs:
      return [...cardioExercises, ...legsCardioExercises, ...legsGymExercises];
    case WorkoutType.chest:
      return [...cardioExercises, ...chestCardioExercises, ...chestGymExercises];
    case WorkoutType.abs:
      return [...cardioExercises, ...absExercises];
    case WorkoutType.fullBody:
      return [...cardioExercises, ...fullBodyExercises];
    case WorkoutType.cardio:
      return cardioExercises;
    case WorkoutType.walk:
      return null;
  }
}

String workoutLabel(WorkoutType type) {
  switch (type) {
    case WorkoutType.legs:
      return 'Leg Day';
    case WorkoutType.cardio:
      return 'Cardio';
    case WorkoutType.chest:
      return 'Chest Day';
    case WorkoutType.abs:
      return 'Core & Abs Day';
    case WorkoutType.fullBody:
      return 'Full Body Burn';
    case WorkoutType.walk:
      return 'Slow Walk';
  }
}

String workoutEmoji(WorkoutType type) {
  switch (type) {
    case WorkoutType.legs:
      return '🦵';
    case WorkoutType.cardio:
      return '🏃';
    case WorkoutType.chest:
      return '💪';
    case WorkoutType.abs:
      return '🔥';
    case WorkoutType.fullBody:
      return '⚡';
    case WorkoutType.walk:
      return '🚶';
  }
}

String workoutSubtitle(WorkoutType type) {
  switch (type) {
    case WorkoutType.legs:
      return 'Cardio + Bodyweight + Gym Weights';
    case WorkoutType.cardio:
      return 'Jog + Jumping Jacks + Alternate Knees';
    case WorkoutType.chest:
      return 'Cardio + Bodyweight + Gym Weights';
    case WorkoutType.abs:
      return 'Cardio + Core & Ab Exercises';
    case WorkoutType.fullBody:
      return 'Cardio + 4 full body moves';
    case WorkoutType.walk:
      return 'Just a long, steady walk';
  }
}