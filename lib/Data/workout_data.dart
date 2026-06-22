class Exercise {
  final String name;
  final String imagePath;
  final int reps;
  final int sets;

  const Exercise({
    required this.name,
    required this.imagePath,
    required this.reps,
    required this.sets,
  });
}

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
  Exercise(
    name: 'Mountain Climbers',
    imagePath: 'assets/images/mountain_climbers.jpeg',
    reps: 15,
    sets: 3,
  ),
];
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
    name: 'Plank Shoulder Tap',
    imagePath: 'assets/images/plank_shoulder_tap.png',
    reps: 15,
    sets: 3,
  ),
  Exercise(
    name: 'Arm Circle',
    imagePath: 'assets/images/arm_circle.png',
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

enum WorkoutType { legs, abs, chest, running }

const Map<String, WorkoutType> dayWorkoutMap = {
  'Monday': WorkoutType.legs,
  'Tuesday': WorkoutType.abs,
  'Wednesday': WorkoutType.chest,
  'Thursday': WorkoutType.legs,
  'Friday': WorkoutType.abs,
  'Saturday': WorkoutType.chest,
  'Sunday': WorkoutType.running,
};

List<Exercise>? getExercisesFor(WorkoutType type) {
  switch (type) {
    case WorkoutType.legs:
      return legsExercises;
    case WorkoutType.abs:
      return absExercises;
    case WorkoutType.chest:
      return chestExercises;
    case WorkoutType.running:
      return null;
  }
}

String workoutLabel(WorkoutType type) {
  switch (type) {
    case WorkoutType.legs:
      return 'Legs';
    case WorkoutType.abs:
      return 'Abs';
    case WorkoutType.chest:
      return 'Chest';
    case WorkoutType.running:
      return 'Running';
  }
}

String workoutEmoji(WorkoutType type) {
  switch (type) {
    case WorkoutType.legs:
      return '🦵';
    case WorkoutType.abs:
      return '🔥';
    case WorkoutType.chest:
      return '💪';
    case WorkoutType.running:
      return '🏃';
  }
}