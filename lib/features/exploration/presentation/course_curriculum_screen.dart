import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_values.dart';
import '../../../core/router/app_router.gr.dart';
import '../../../shared/ui_kit/buttons/clay_icon_button.dart';
import 'controllers/course_detail_controller.dart';
import 'widgets/course_badge_banner.dart';
import 'widgets/course_lesson_tile.dart';

@RoutePage()
class CourseCurriculumScreen extends ConsumerWidget {
  final String courseId;

  const CourseCurriculumScreen({super.key, required this.courseId});

  void _showSnack(BuildContext context, String msg) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg), duration: AppValues.durationSnackBar),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(courseDetailControllerProvider(courseId));
    final activeTab = detailState.activeTabIndex;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: detailState.course.when(
          data: (course) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppValues.space7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppValues.space4),

                  // Compact Header
                  Row(
                    children: [
                      ClayIconButton(
                        size: AppValues.sizeCircleButtonXl,
                        backgroundColor: AppColors.surfaceContainer,
                        onPressed: () => Navigator.of(context).maybePop(),
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: AppColors.textPrimary,
                          size: AppValues.iconSizeMd,
                        ),
                      ),
                      const SizedBox(width: AppValues.space4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(AppValues.radiusMd),
                        child: Image.asset(
                          course.thumbnailUrl,
                          width: AppValues.sizeCourseDetailThumb,
                          height: AppValues.sizeCourseDetailThumb,
                          fit: BoxFit.contain,
                          errorBuilder: (_, __, ___) => const Icon(
                            Icons.school_rounded,
                            size: AppValues.sizeCircleButtonXl,
                            color: AppColors.brandPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppValues.space4),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              course.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.quicksand(
                                fontSize: AppValues.fontTitleHero,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: AppValues.space1),
                            Text(
                              '${course.totalLessons} ${AppStrings.lessonsCountSuffix} • ${course.category.toUpperCase()}',
                              style: GoogleFonts.quicksand(
                                fontSize: AppValues.fontBodySm,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppValues.space6),

                  // 3 Tab Pill Selector
                  _buildTabBar(ref, activeTab),
                  const SizedBox(height: AppValues.space6),

                  // Tab Contents
                  Expanded(
                    child: activeTab == 0
                        ? _buildLessonsTab(context, course)
                        : (activeTab == 1
                            ? _buildAboutTab(course)
                            : _buildReviewsTab(course)),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => Center(
            child: Text(
              AppStrings.genericError,
              style: GoogleFonts.quicksand(color: AppColors.stateError),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(WidgetRef ref, int activeTab) {
    const tabs = [
      AppStrings.tabLessons,
      AppStrings.tabAbout,
      AppStrings.tabReviews,
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppValues.radiusPill),
      ),
      padding: const EdgeInsets.all(AppValues.space2),
      child: Row(
        children: [
          for (int i = 0; i < tabs.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () {
                  HapticFeedback.selectionClick();
                  ref
                      .read(courseDetailControllerProvider(courseId).notifier)
                      .setTabIndex(i);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: AppValues.space4),
                  decoration: BoxDecoration(
                    color: activeTab == i
                        ? AppColors.brandPrimary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(AppValues.radiusPill),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    tabs[i],
                    style: GoogleFonts.quicksand(
                      fontSize: AppValues.fontBodySm,
                      fontWeight:
                          activeTab == i ? FontWeight.w700 : FontWeight.w600,
                      color: activeTab == i
                          ? AppColors.textInverse
                          : AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLessonsTab(BuildContext context, dynamic course) {
    final lessons = course.lessons;
    return SingleChildScrollView(
      child: Column(
        children: [
          for (final lesson in lessons)
            CourseLessonTile(
              lesson: lesson,
              onTap: () {
                final hasRouter =
                    context.findAncestorWidgetOfExactType<RouterScope>() != null;
                if (hasRouter) {
                  context.router.push(
                    LessonPlayerRoute(
                      lessonId: lesson.id,
                      courseTitle: course.title,
                    ),
                  );
                } else {
                  _showSnack(context, AppStrings.lessonDemoNotice);
                }
              },
              onLockedTap: () => _showSnack(context, AppStrings.lessonLockedAlert),
            ),
          const SizedBox(height: AppValues.space5),
          const CourseBadgeBanner(),
          const SizedBox(height: AppValues.space9),
        ],
      ),
    );
  }

  Widget _buildAboutTab(dynamic course) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.aboutThisCourseHeader,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontTitleHero,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppValues.space3),
          Text(
            course.description,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontBodyMd,
              fontWeight: FontWeight.w500,
              color: AppColors.textSlateDark,
              height: AppValues.lineHeightNormal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsTab(dynamic course) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 5; i++)
                const Icon(
                  Icons.star_rounded,
                  color: AppColors.ratingStarGold,
                  size: AppValues.iconSizeLg,
                ),
            ],
          ),
          const SizedBox(height: AppValues.space3),
          Text(
            '${course.rating} / 5.0',
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontHeadlineLg,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppValues.space1),
          Text(
            '${course.reviewCount} ${AppStrings.reviewsCountSuffix}',
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontBodyMd,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
