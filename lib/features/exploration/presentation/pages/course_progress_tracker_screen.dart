import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../core/router/app_router.gr.dart';
import '../../../../shared/ui_kit/ui_kit.dart';
import '../../domain/models/course.dart';
import '../../domain/models/lesson.dart';
import '../controllers/course_detail_controller.dart';
import '../widgets/course_progress_summary_card.dart';
import '../widgets/progress_timeline_node.dart';

@RoutePage()
class CourseProgressTrackerScreen extends ConsumerWidget {
  final String courseId;
  final String? courseTitle;

  const CourseProgressTrackerScreen({
    super.key,
    required this.courseId,
    this.courseTitle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(courseDetailControllerProvider(courseId));

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: state.course.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.brandPrimary),
                ),
                error: (e, _) => Center(
                  child: ClayErrorText(e.toString()),
                ),
                data: (course) => _buildBody(context, course),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.space6,
        vertical: AppValues.space4,
      ),
      child: Row(
        children: [
          ClayIconButton(
            size: AppValues.minTouchTarget,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.brandPrimary,
            ),
            onPressed: () {
              if (context.findAncestorWidgetOfExactType<RouterScope>() != null) {
                context.router.maybePop();
              } else {
                Navigator.of(context).maybePop();
              }
            },
          ),
          const SizedBox(width: AppValues.space4),
          Expanded(
            child: Text(
              courseTitle ?? AppStrings.progressTrackerTitle,
              style: GoogleFonts.quicksand(
                fontSize: AppValues.fontTitleHero,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const StarCounterBadge(count: 3, isStreak: true),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, Course course) {
    final lessons = course.lessons;
    final totalLessons = lessons.length;
    final completedCount = lessons.where((l) => l.isCompleted).length;
    final progress = totalLessons == 0 ? 0.0 : completedCount / totalLessons;
    final starsEarned = completedCount * 10;

    final currentIndex = lessons.indexWhere((l) => l.isUnlocked && !l.isCompleted);
    final activeIndex = currentIndex != -1 ? currentIndex : completedCount - 1;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.space6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CourseProgressSummaryCard(
            progress: progress,
            completed: completedCount,
            total: totalLessons,
            stars: starsEarned,
          ),
          const SizedBox(height: AppValues.space7),
          Text(
            'Lộ trình các bài học',
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontBodyMd,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppValues.space5),
          for (int i = 0; i < lessons.length; i++)
            ProgressTimelineNode(
              lesson: lessons[i],
              isCurrent: i == activeIndex,
              isFirst: i == 0,
              isLast: i == lessons.length - 1,
              onTap: () => _handleLessonTap(context, lessons[i], course.title),
            ),
          const SizedBox(height: AppValues.space9),
        ],
      ),
    );
  }

  void _handleLessonTap(BuildContext context, Lesson lesson, String courseTitle) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    if (lesson.isUnlocked) {
      final hasRouter =
          context.findAncestorWidgetOfExactType<RouterScope>() != null;
      if (hasRouter) {
        context.router.push(
          LessonPlayerRoute(
            lessonId: lesson.id,
            courseTitle: courseTitle,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${lesson.title} - ${lesson.id}')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.lessonLockedAlert)),
      );
    }
  }
}
