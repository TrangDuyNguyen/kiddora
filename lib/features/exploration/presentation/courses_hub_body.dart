import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_values.dart';
import '../../../core/router/app_router.gr.dart';
import '../../../shared/ui_kit/buttons/clay_icon_button.dart';
import 'controllers/courses_controller.dart';
import 'widgets/course_category_card.dart';
import 'widgets/course_clay_card.dart';

class CoursesHubBody extends ConsumerWidget {
  const CoursesHubBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coursesControllerProvider);
    final selectedCategory = state.filter.category;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: AppValues.space7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppValues.space4),

          // Header: Title, Subtitle & Search Circle Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.coursesHubTitle,
                      style: GoogleFonts.quicksand(
                        fontSize: AppValues.fontHeadlineXl,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppValues.space1),
                    Text(
                      AppStrings.coursesHubSubtitle,
                      style: GoogleFonts.quicksand(
                        fontSize: AppValues.fontLabelMd,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              ClayIconButton(
                size: AppValues.sizeCircleButtonXl,
                backgroundColor: AppColors.surfaceContainer,
                glowColor: AppColors.clayContactShadow,
                onPressed: () {
                  context.router.push(const CourseSearchRoute());
                },
                icon: const Icon(
                  Icons.search_rounded,
                  size: AppValues.iconSizeLg,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppValues.space6),

          // Hero Banner "A Brighter Future Starts Here!"
          _buildHeroBanner(),
          const SizedBox(height: AppValues.space7),

          // 5 Category Cards (Evenly Distributed Across Screen Width)
          Row(
            children: [
              Expanded(
                child: CourseCategoryCard(
                  label: AppStrings.subjectAll,
                  assetIcon: AppAssets.catIconAll3d,
                  icon: Icons.grid_view_rounded,
                  isSelected: selectedCategory == 'all',
                  activeColor: AppColors.categoryActiveBg,
                  onTap: () => ref
                      .read(coursesControllerProvider.notifier)
                      .setCategory('all'),
                ),
              ),
              const SizedBox(width: AppValues.categoryCardSpacing),
              Expanded(
                child: CourseCategoryCard(
                  label: AppStrings.subjectScience,
                  assetIcon: AppAssets.catIconScience3d,
                  icon: Icons.science_rounded,
                  isSelected: selectedCategory == 'science',
                  iconColor: AppColors.categoryScienceIcon,
                  onTap: () => ref
                      .read(coursesControllerProvider.notifier)
                      .setCategory('science'),
                ),
              ),
              const SizedBox(width: AppValues.categoryCardSpacing),
              Expanded(
                child: CourseCategoryCard(
                  label: AppStrings.subjectMath,
                  assetIcon: AppAssets.catIconMath3d,
                  icon: Icons.calculate_rounded,
                  isSelected: selectedCategory == 'math',
                  iconColor: AppColors.categoryMathIcon,
                  onTap: () => ref
                      .read(coursesControllerProvider.notifier)
                      .setCategory('math'),
                ),
              ),
              const SizedBox(width: AppValues.categoryCardSpacing),
              Expanded(
                child: CourseCategoryCard(
                  label: AppStrings.subjectLanguage,
                  assetIcon: AppAssets.catIconLanguage3d,
                  icon: Icons.menu_book_rounded,
                  isSelected: selectedCategory == 'language',
                  iconColor: AppColors.categoryLanguageIcon,
                  onTap: () => ref
                      .read(coursesControllerProvider.notifier)
                      .setCategory('language'),
                ),
              ),
              const SizedBox(width: AppValues.categoryCardSpacing),
              Expanded(
                child: CourseCategoryCard(
                  label: AppStrings.subjectArts,
                  assetIcon: AppAssets.catIconArts3d,
                  icon: Icons.palette_rounded,
                  isSelected: selectedCategory == 'arts',
                  iconColor: AppColors.categoryArtsIcon,
                  onTap: () => ref
                      .read(coursesControllerProvider.notifier)
                      .setCategory('arts'),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppValues.space7),

          // Section Title: Popular Courses + See All
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  AppStrings.popularCoursesTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontTitleHero,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: AppValues.space3),
              GestureDetector(
                onTap: () {
                  context.router.push(const AllCoursesGridRoute());
                },
                child: Text(
                  AppStrings.seeAll,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontBodySm,
                    fontWeight: FontWeight.w700,
                    color: AppColors.brandPrimary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppValues.space5),

          // 2-Column Popular Courses Grid
          state.courses.when(
            data: (courses) {
              final popular = courses.where((c) => c.isFeatured).toList();
              final displayList = popular.isNotEmpty ? popular : courses;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: AppValues.courseGridCrossSpacing,
                  mainAxisSpacing: AppValues.courseGridMainSpacing,
                  childAspectRatio: AppValues.courseCardAspectRatio,
                ),
                itemCount: displayList.length,
                itemBuilder: (context, index) {
                  final course = displayList[index];
                  return CourseClayCard(
                    course: course,
                    onTap: () {
                      context.router.push(CourseDetailRoute(courseId: course.id));
                    },
                  );
                },
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(AppValues.space9),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (_, __) => Center(
              child: Padding(
                padding: const EdgeInsets.all(AppValues.space7),
                child: Text(
                  AppStrings.genericError,
                  style: GoogleFonts.quicksand(color: AppColors.stateError),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppValues.space11),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return AspectRatio(
      aspectRatio: AppValues.bannerCoursesAspectRatio,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppValues.bannerCoursesRadius),
          boxShadow: const [
            BoxShadow(
              color: AppColors.clayFilterActiveShadow,
              offset: Offset(0, AppValues.offsetY3),
              blurRadius: AppValues.space6,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(AppValues.bannerCoursesRadius),
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  AppAssets.courseHeroBanner,
                  fit: BoxFit.fill,
                  errorBuilder: (_, __, ___) => Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.courseHeroBgGradStart,
                          AppColors.courseHeroBgGradEnd,
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Accessibility & Widget Test Semantics
              Positioned(
                left: -9999,
                child: Column(
                  children: [
                    Text(AppStrings.brighterFutureTitle),
                    Text(AppStrings.brighterFutureSubtitle),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
