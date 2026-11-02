import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_values.dart';
import '../../../core/router/app_router.gr.dart';
import '../../../shared/ui_kit/buttons/clay_button.dart';
import '../../../shared/ui_kit/buttons/clay_icon_button.dart';
import 'controllers/course_detail_controller.dart';
import 'controllers/courses_controller.dart';
import 'widgets/course_feature_card.dart';

@RoutePage()
class CourseDetailScreen extends ConsumerWidget {
  final String courseId;

  const CourseDetailScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detailState = ref.watch(courseDetailControllerProvider(courseId));
    final coursesState = ref.watch(coursesControllerProvider);
    final isFavorite = coursesState.favoriteIds.contains(courseId);

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: detailState.course.when(
        data: (course) {
          final subtitle = course.subtitle ?? AppStrings.amazingAnimalsSubtitle;
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Top Hero Image with Back & Favorite Buttons
                      Stack(
                        children: [
                          Container(
                            height: AppValues.sizeGoalProgressBox,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: AppColors.blobLavender,
                            ),
                            alignment: Alignment.center,
                            child: Image.asset(
                              course.thumbnailUrl,
                              fit: BoxFit.contain,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.school_rounded,
                                size: AppValues.space11 * 2,
                                color: AppColors.brandPrimary,
                              ),
                            ),
                          ),
                          Positioned(
                            top: AppValues.space11,
                            left: AppValues.space7,
                            child: ClayIconButton(
                              size: AppValues.sizeCircleButtonXl,
                              backgroundColor: AppColors.surfaceContainer,
                              onPressed: () => Navigator.of(context).maybePop(),
                              icon: const Icon(
                                Icons.arrow_back_rounded,
                                color: AppColors.textPrimary,
                                size: AppValues.iconSizeMd,
                              ),
                            ),
                          ),
                          Positioned(
                            top: AppValues.space11,
                            right: AppValues.space7,
                            child: ClayIconButton(
                              size: AppValues.sizeCircleButtonXl,
                              backgroundColor: AppColors.surfaceContainer,
                              onPressed: () {
                                HapticFeedback.mediumImpact();
                                ref
                                    .read(coursesControllerProvider.notifier)
                                    .toggleFavorite(course.id);
                              },
                              icon: Icon(
                                isFavorite
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                color: isFavorite
                                    ? AppColors.favoriteHeartRed
                                    : AppColors.textPrimary,
                                size: AppValues.iconSizeMd,
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Content Body
                      Container(
                        transform: Matrix4.translationValues(
                          0.0,
                          -AppValues.radiusXl,
                          0.0,
                        ),
                        decoration: const BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(AppValues.radiusSheetTop),
                            topRight: Radius.circular(AppValues.radiusSheetTop),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppValues.space7,
                          vertical: AppValues.space6,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Title & Subtitle
                            Text(
                              course.title,
                              style: GoogleFonts.quicksand(
                                fontSize: AppValues.fontHeadlineLg,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: AppValues.space2),
                            Text(
                              subtitle,
                              style: GoogleFonts.quicksand(
                                fontSize: AppValues.fontBodySm,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const SizedBox(height: AppValues.space5),

                            // 3 Info Pills (Category, Age, Lessons)
                            Row(
                              children: [
                                _buildInfoPill(
                                  course.category.toUpperCase(),
                                  AppColors.blobPeriwinkle,
                                  AppColors.brandPrimary,
                                ),
                                const SizedBox(width: AppValues.space3),
                                _buildInfoPill(
                                  '${AppStrings.agesPrefix} ${course.minAge}–${course.maxAge}',
                                  AppColors.blobLavender,
                                  AppColors.textSecondary,
                                ),
                                const SizedBox(width: AppValues.space3),
                                _buildInfoPill(
                                  '${course.totalLessons} ${AppStrings.lessonsCountSuffix}',
                                  AppColors.blobPeach,
                                  AppColors.streakOrange,
                                ),
                              ],
                            ),
                            const SizedBox(height: AppValues.space5),

                            // Rating Row
                            Row(
                              children: [
                                for (int i = 0; i < 5; i++)
                                  const Icon(
                                    Icons.star_rounded,
                                    color: AppColors.ratingStarGold,
                                    size: AppValues.iconSizeMd,
                                  ),
                                const SizedBox(width: AppValues.space3),
                                Text(
                                  '${course.rating} (${course.reviewCount} ${AppStrings.reviewsCountSuffix})',
                                  style: GoogleFonts.quicksand(
                                    fontSize: AppValues.fontBodySm,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppValues.space6),

                            // About Section
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
                            const SizedBox(height: AppValues.space6),

                            // 4 Feature Cards (2x2 Grid)
                            GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              mainAxisSpacing: AppValues.space4,
                              crossAxisSpacing: AppValues.space4,
                              childAspectRatio: 1.5,
                              children: const [
                                CourseFeatureCard(
                                  title: AppStrings.featureFunVideos,
                                  icon: Icons.play_circle_fill_rounded,
                                  backgroundColor: AppColors.featureVideosBg,
                                  iconColor: AppColors.featureVideosIcon,
                                ),
                                CourseFeatureCard(
                                  title: AppStrings.featureInteractiveQuizzes,
                                  icon: Icons.quiz_rounded,
                                  backgroundColor: AppColors.featureQuizzesBg,
                                  iconColor: AppColors.featureQuizzesIcon,
                                ),
                                CourseFeatureCard(
                                  title: AppStrings.featureActivitySheets,
                                  icon: Icons.assignment_rounded,
                                  backgroundColor: AppColors.featureSheetsBg,
                                  iconColor: AppColors.featureSheetsIcon,
                                ),
                                CourseFeatureCard(
                                  title: AppStrings.featureEarnBadges,
                                  icon: Icons.military_tech_rounded,
                                  backgroundColor: AppColors.featureBadgesBg,
                                  iconColor: AppColors.featureBadgesIcon,
                                ),
                              ],
                            ),
                            const SizedBox(height: AppValues.space7),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bottom CTA Button
              Padding(
                padding: const EdgeInsets.all(AppValues.space7),
                child: ClayButton(
                  label: AppStrings.startLearning,
                  trailingIcon: const Icon(
                    Icons.arrow_forward_rounded,
                    color: AppColors.textInverse,
                    size: AppValues.iconSizeMd,
                  ),
                  onPressed: () {
                    context.router.push(CourseCurriculumRoute(courseId: course.id));
                  },
                ),
              ),
            ],
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
    );
  }

  Widget _buildInfoPill(String text, Color bg, Color textCol) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.space4,
        vertical: AppValues.space2,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppValues.radiusSm),
      ),
      child: Text(
        text,
        style: GoogleFonts.quicksand(
          fontSize: AppValues.fontCaptionSm,
          fontWeight: FontWeight.w700,
          color: textCol,
        ),
      ),
    );
  }
}
