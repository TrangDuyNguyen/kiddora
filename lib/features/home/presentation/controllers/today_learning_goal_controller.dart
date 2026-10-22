import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DailyGoalTask {
  final String id;
  final String title;
  final String subtitle;
  final bool isCompleted;

  const DailyGoalTask({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.isCompleted,
  });

  DailyGoalTask copyWith({bool? isCompleted}) {
    return DailyGoalTask(
      id: id,
      title: title,
      subtitle: subtitle,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

class DailyGoalState {
  final List<DailyGoalTask> tasks;

  const DailyGoalState({required this.tasks});

  int get completedCount => tasks.where((t) => t.isCompleted).length;
  int get totalCount => tasks.length;
  double get progressRatio => totalCount > 0 ? completedCount / totalCount : 0.0;
}

class TodayLearningGoalController extends StateNotifier<DailyGoalState> {
  TodayLearningGoalController()
      : super(
          const DailyGoalState(
            tasks: [
              DailyGoalTask(
                id: 'task_1',
                title: 'Watch a lesson',
                subtitle: 'Amazing Animals',
                isCompleted: true,
              ),
              DailyGoalTask(
                id: 'task_2',
                title: 'Complete a quiz',
                subtitle: 'Animal Facts Quiz',
                isCompleted: true,
              ),
              DailyGoalTask(
                id: 'task_3',
                title: 'Join a live session',
                subtitle: 'Math Fun with Numbers',
                isCompleted: true,
              ),
              DailyGoalTask(
                id: 'task_4',
                title: 'Read a story',
                subtitle: 'The Mystery of Space',
                isCompleted: false,
              ),
              DailyGoalTask(
                id: 'task_5',
                title: 'Earn 10 points',
                subtitle: 'Keep going!',
                isCompleted: false,
              ),
            ],
          ),
        );

  void toggleTask(String id) {
    HapticFeedback.mediumImpact();
    state = DailyGoalState(
      tasks: state.tasks.map((task) {
        if (task.id == id) {
          return task.copyWith(isCompleted: !task.isCompleted);
        }
        return task;
      }).toList(),
    );
  }
}

final todayLearningGoalControllerProvider =
    StateNotifierProvider<TodayLearningGoalController, DailyGoalState>((ref) {
  return TodayLearningGoalController();
});
