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
// Used on every training day, and alone on pure cardio days.
const List<Exercise> cardioExercises = [
  Exercise(
    name: 'Jogging',
    imagePath: 'assets/images/jogging.png',
    reps: 10,
    sets: 1,
    category: ExerciseCategory.cardio,
    isDuration: true,
  ),
  Exercise(
    name: 'Jumping Jacks',
    imagePath: 'assets/images/jumping_jacks.png',
    reps: 30,
    sets: 2,
    category: ExerciseCategory.cardio,
  ),
  Exercise(
    name: 'Alternate Knees',
    imagePath: 'assets/images/alternate_knees.png',
    reps: 30,
    sets: 2,
    category: ExerciseCategory.cardio,
  ),
];

// ── Monday: Legs Day (bodyweight) ────────────────────────────
const List<Exercise> legsExercises = [
  Exercise(
    name: 'Lunges',
    imagePath: 'assets/images/lunges.png',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Reverse Lunges',
    imagePath: 'assets/images/reverse_lunges.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Side Lunges',
    imagePath: 'assets/images/side_lunges.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Wall Sit',
    imagePath: 'assets/images/wall_sit.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Calf Raises',
    imagePath: 'assets/images/calf_raises.jpg',
    reps: 20,
    sets: 3,
  ),
  Exercise(
    name: 'Glutes Bridge',
    imagePath: 'assets/images/glutes_bridge.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Alternating Step-Ups',
    imagePath: 'assets/images/alternating_step_ups.jpg',
    reps: 15,
    sets: 3,
  ),
];

// ── Monday: Legs Day (gym equipment / weighted) ─────────────────
const List<Exercise> legsGymExercises = [
  Exercise(
    name: 'Barbell Back Squat',
    imagePath: 'assets/images/barbell_back_squat.jpg',
    reps: 10,
    sets: 4,
  ),
  Exercise(
    name: 'Leg Press Machine',
    imagePath: 'assets/images/leg_press_machine.jpg',
    reps: 12,
    sets: 4,
  ),
  Exercise(
    name: 'Romanian Deadlift',
    imagePath: 'assets/images/romanian_deadlift.jpg',
    reps: 10,
    sets: 3,
  ),
  Exercise(
    name: 'Leg Extension Machine',
    imagePath: 'assets/images/leg_extension_machine.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Seated Leg Curl Machine',
    imagePath: 'assets/images/seated_leg_curl_machine.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Bulgarian Split Squat (Dumbbell)',
    imagePath: 'assets/images/bulgarian_split_squat.jpg',
    reps: 10,
    sets: 3,
  ),
  Exercise(
    name: 'Standing Calf Raise Machine',
    imagePath: 'assets/images/standing_calf_raise_machine.jpg',
    reps: 20,
    sets: 3,
  ),
];

// ── Wednesday: Chest Day (bodyweight) ────────────────────────
const List<Exercise> chestExercises = [
  Exercise(
    name: 'Pushup',
    imagePath: 'assets/images/pushup.jpeg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Wide Grip Pushup',
    imagePath: 'assets/images/wide_grip_pushup.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Decline Pushup',
    imagePath: 'assets/images/decline_pushup.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Incline Pushup',
    imagePath: 'assets/images/incline_pushup.png',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Pike Pushup',
    imagePath: 'assets/images/pike_pushup.png',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Diamond Pushup',
    imagePath: 'assets/images/diamond_pushup.png',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Tricep Dip',
    imagePath: 'assets/images/tricep_dip.png',
    reps: 15,
    sets: 3,
  ),
];

// ── Wednesday: Chest Day (gym equipment / weighted) ──────────────
const List<Exercise> chestGymExercises = [
  Exercise(
    name: 'Barbell Bench Press',
    imagePath: 'assets/images/barbell_bench_press.jpg',
    reps: 10,
    sets: 4,
  ),
  Exercise(
    name: 'Incline Dumbbell Press',
    imagePath: 'assets/images/incline_dumbbell_press.jpg',
    reps: 10,
    sets: 4,
  ),
  Exercise(
    name: 'Flat Dumbbell Fly',
    imagePath: 'assets/images/flat_dumbbell_fly.jpg',
    reps: 12,
    sets: 3,
  ),
  Exercise(
    name: 'Cable Crossover',
    imagePath: 'assets/images/cable_crossover.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Chest Press Machine',
    imagePath: 'assets/images/chest_press_machine.jpg',
    reps: 12,
    sets: 3,
  ),
  Exercise(
    name: 'Pec Deck Machine',
    imagePath: 'assets/images/pec_deck_machine.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Weighted Dip',
    imagePath: 'assets/images/weighted_dip.jpg',
    reps: 10,
    sets: 3,
  ),
];

// ── Friday: Core & Abs Day (bodyweight) ──────────────────────
const List<Exercise> absExercises = [
  Exercise(
    name: 'Crunches',
    imagePath: 'assets/images/crunches.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Toe Touch Crunch',
    imagePath: 'assets/images/toe_touch_crunch.png',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Leg Raise',
    imagePath: 'assets/images/leg_raise.png',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Flutter Kicks',
    imagePath: 'assets/images/flutter_kicks.png',
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
];

// ── Friday: Core & Abs Day (gym equipment / weighted) ────────────
const List<Exercise> absGymExercises = [
  Exercise(
    name: 'Cable Crunch',
    imagePath: 'assets/images/cable_crunch.jpg',
    reps: 15,
    sets: 4,
  ),
  Exercise(
    name: 'Hanging Leg Raise',
    imagePath: 'assets/images/hanging_leg_raise.jpg',
    reps: 12,
    sets: 3,
  ),
  Exercise(
    name: 'Ab Wheel Rollout',
    imagePath: 'assets/images/ab_wheel_rollout.jpg',
    reps: 10,
    sets: 3,
  ),
  Exercise(
    name: 'Weighted Decline Sit-up',
    imagePath: 'assets/images/weighted_decline_situp.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Machine Crunch',
    imagePath: 'assets/images/machine_crunch.jpg',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Cable Woodchopper',
    imagePath: 'assets/images/cable_woodchopper.jpg',
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

// ── Saturday: Cardio + Full Body Burn ─────────────────────────
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
/// - legs / chest / abs: cardio warm-up + bodyweight + gym/weighted exercises
/// - cardio (Tue/Thu): jog + jumping jacks + alternate knees only
/// - fullBody (Saturday): cardio block + the 4 full body burn moves
/// - walk (Sunday): no exercise list — handled by its own screen
List<Exercise>? getExercisesFor(WorkoutType type) {
  switch (type) {
    case WorkoutType.legs:
      return [...cardioExercises, ...legsExercises, ...legsGymExercises];
    case WorkoutType.chest:
      return [...cardioExercises, ...chestExercises, ...chestGymExercises];
    case WorkoutType.abs:
      return [...cardioExercises, ...absExercises, ...absGymExercises];
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
      return 'Legs Day';
    case WorkoutType.cardio:
      return 'Cardio';
    case WorkoutType.chest:
      return 'Chest Day';
    case WorkoutType.abs:
      return 'Core & Abs Day';
    case WorkoutType.fullBody:
      return 'Full Body Burn';
    case WorkoutType.walk:
      return 'Long Walk';
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
      return 'Cardio + Bodyweight + Gym Weights';
    case WorkoutType.fullBody:
      return 'Cardio + 4 full body moves';
    case WorkoutType.walk:
      return 'Just a long, steady walk';
  }
}