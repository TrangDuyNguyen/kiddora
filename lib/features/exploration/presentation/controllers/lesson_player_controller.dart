import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/datasources/lesson_datasource.dart';
import '../../domain/models/game_result.dart';
import '../../domain/models/lesson_blueprint.dart';

class LessonPlayerState {
  final AsyncValue<LessonBlueprint> blueprint;
  final int currentStageIndex;
  final bool isCompleted;
  final int starsEarned;
  final List<GameResult> stageResults;

  const LessonPlayerState({
    required this.blueprint,
    this.currentStageIndex = 0,
    this.isCompleted = false,
    this.starsEarned = 0,
    this.stageResults = const [],
  });

  LessonPlayerState copyWith({
    AsyncValue<LessonBlueprint>? blueprint,
    int? currentStageIndex,
    bool? isCompleted,
    int? starsEarned,
    List<GameResult>? stageResults,
  }) {
    return LessonPlayerState(
      blueprint: blueprint ?? this.blueprint,
      currentStageIndex: currentStageIndex ?? this.currentStageIndex,
      isCompleted: isCompleted ?? this.isCompleted,
      starsEarned: starsEarned ?? this.starsEarned,
      stageResults: stageResults ?? this.stageResults,
    );
  }
}

class LessonPlayerController extends StateNotifier<LessonPlayerState> {
  final ILessonDatasource _datasource;

  LessonPlayerController(this._datasource)
      : super(const LessonPlayerState(blueprint: AsyncValue.loading()));

  Future<void> loadBlueprint(String lessonId) async {
    state = state.copyWith(blueprint: const AsyncValue.loading());
    try {
      final bp = await _datasource.getLessonBlueprint(lessonId);
      state = state.copyWith(
        blueprint: AsyncValue.data(bp),
        currentStageIndex: 0,
        isCompleted: false,
        starsEarned: 0,
        stageResults: [],
      );
    } catch (e, st) {
      state = state.copyWith(blueprint: AsyncValue.error(e, st));
    }
  }

  void nextStage() {
    state.blueprint.whenData((bp) {
      if (state.currentStageIndex < bp.stages.length - 1) {
        state = state.copyWith(
          currentStageIndex: state.currentStageIndex + 1,
        );
      } else {
        state = state.copyWith(
          isCompleted: true,
          starsEarned: state.starsEarned + 10,
        );
      }
    });
  }

  void previousStage() {
    if (state.currentStageIndex > 0) {
      state = state.copyWith(
        currentStageIndex: state.currentStageIndex - 1,
      );
    }
  }

  void recordStageResult(GameResult result) {
    final updated = List<GameResult>.from(state.stageResults)..add(result);
    state = state.copyWith(
      stageResults: updated,
      starsEarned: state.starsEarned + result.starsEarned,
    );
    nextStage();
  }
}

final lessonDatasourceProvider = Provider<ILessonDatasource>((ref) {
  return const LessonDatasourceImpl();
});

final lessonPlayerControllerProvider =
    StateNotifierProvider.autoDispose<LessonPlayerController, LessonPlayerState>(
  (ref) {
    final ds = ref.watch(lessonDatasourceProvider);
    return LessonPlayerController(ds);
  },
);

