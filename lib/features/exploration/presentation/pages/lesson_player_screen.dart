import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiddora/core/constants/app_colors.dart';
import 'package:kiddora/core/constants/app_values.dart';
import 'package:kiddora/core/router/app_router.gr.dart';
import 'package:kiddora/shared/ui_kit/indicators/star_counter_badge.dart';
import '../controllers/lesson_player_controller.dart';
import '../widgets/exit_confirmation_dialog.dart';
import '../widgets/lesson_progress_dots.dart';
import '../widgets/lesson_stage_dispatcher.dart';

@RoutePage()
class LessonPlayerScreen extends ConsumerStatefulWidget {
  final String lessonId;
  final String? courseTitle;

  const LessonPlayerScreen({
    super.key,
    required this.lessonId,
    this.courseTitle,
  });

  @override
  ConsumerState<LessonPlayerScreen> createState() => _LessonPlayerScreenState();
}

class _LessonPlayerScreenState extends ConsumerState<LessonPlayerScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(lessonPlayerControllerProvider.notifier)
          .loadBlueprint(widget.lessonId);
    });
  }

  Future<void> _handleExit() async {
    final shouldExit = await ExitConfirmationDialog.show(context);
    if (shouldExit && mounted) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(lessonPlayerControllerProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _handleExit();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.surface,
        appBar: AppBar(
          backgroundColor: AppColors.surface,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.close_rounded,
              color: AppColors.textPrimary,
              size: 28,
            ),
            onPressed: _handleExit,
          ),
          centerTitle: true,
          title: state.blueprint.maybeWhen(
            data: (bp) => LessonProgressDots(
              totalStages: bp.stages.length,
              currentStageIndex: state.currentStageIndex,
            ),
            orElse: () => const SizedBox.shrink(),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: AppValues.space7),
              child: StarCounterBadge(count: state.starsEarned),
            ),
          ],
        ),
        body: SafeArea(
          child: state.blueprint.when(
            loading: () => const Center(
              child: CircularProgressIndicator(color: AppColors.brandPrimary),
            ),
            error: (err, _) => Center(
              child: Text(
                'Không thể tải bài học. Vui lòng thử lại!',
                style: const TextStyle(
                  fontSize: AppValues.fontBodyMd,
                  color: AppColors.feedbackError,
                ),
              ),
            ),
            data: (bp) {
              if (state.isCompleted) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    final hasRouter =
                        context.findAncestorWidgetOfExactType<RouterScope>() !=
                            null;
                    if (hasRouter) {
                      context.router.replace(
                        CourseCompletedCelebrationRoute(
                          courseId: bp.courseId,
                          courseTitle: widget.courseTitle,
                        ),
                      );
                    } else {
                      Navigator.of(context).pop(true);
                    }
                  }
                });
                return const SizedBox.shrink();
              }

              final stage = bp.stages[state.currentStageIndex];
              return AnimatedSwitcher(
                duration: const Duration(
                  milliseconds: AppValues.gameAnimDurationMs,
                ),
                child: KeyedSubtree(
                  key: ValueKey('stage_${stage.stepOrder}'),
                  child: LessonStageDispatcher(
                    lessonId: widget.lessonId,
                    stage: stage,
                    onNext: () {
                      ref
                          .read(lessonPlayerControllerProvider.notifier)
                          .nextStage();
                    },
                    onGameCompleted: (result) {
                      ref
                          .read(lessonPlayerControllerProvider.notifier)
                          .recordStageResult(result);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
