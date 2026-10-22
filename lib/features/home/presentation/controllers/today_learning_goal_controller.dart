import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_strings.dart';

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
                title: AppStrings.taskWatchLesson,
                subtitle: AppStrings.courseAmazingAnimals,
                isCompleted: true,
              ),
              DailyGoalTask(
                id: 'task_2',
                title: AppStrings.taskCompleteQuiz,
                subtitle: AppStrings.taskAnimalFactsQuiz,
                isCompleted: true,
              ),
              DailyGoalTask(
                id: 'task_3',
                title: AppStrings.taskJoinLiveSession,
                subtitle: AppStrings.mathFunWithNumbers,
                isCompleted: true,
              ),
              DailyGoalTask(
                id: 'task_4',
                title: AppStrings.taskReadStory,
                subtitle: AppStrings.taskMysteryOfSpace,
                isCompleted: false,
              ),
              DailyGoalTask(
                id: 'task_5',
                title: AppStrings.taskEarnPoints,
                subtitle: AppStrings.taskKeepGoing,
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
