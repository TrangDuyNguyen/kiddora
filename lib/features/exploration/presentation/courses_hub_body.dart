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
                        fontSize: AppValues.fontHeadlineMid,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: AppValues.space1),
                    Text(
                      AppStrings.coursesHubSubtitle,
                      style: GoogleFonts.quicksand(
                        fontSize: AppValues.fontBodySm,
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
                  color: AppColors.brandPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppValues.space6),

          // Hero Banner "A Brighter Future Starts Here!"
          _buildHeroBanner(),
          const SizedBox(height: AppValues.space7),

          // 5 Category Cards
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            child: Row(
              children: [
                CourseCategoryCard(
                  label: AppStrings.subjectAll,
                  icon: Icons.auto_awesome_rounded,
                  isSelected: selectedCategory == 'all',
                  onTap: () => ref
                      .read(coursesControllerProvider.notifier)
                      .setCategory('all'),
                ),
                const SizedBox(width: AppValues.space4),
                CourseCategoryCard(
                  label: AppStrings.subjectScience,
                  icon: Icons.science_rounded,
                  isSelected: selectedCategory == 'science',
                  onTap: () => ref
                      .read(coursesControllerProvider.notifier)
                      .setCategory('science'),
                ),
                const SizedBox(width: AppValues.space4),
                CourseCategoryCard(
                  label: AppStrings.subjectMath,
                  icon: Icons.calculate_rounded,
                  isSelected: selectedCategory == 'math',
                  onTap: () => ref
                      .read(coursesControllerProvider.notifier)
                      .setCategory('math'),
                ),
                const SizedBox(width: AppValues.space4),
                CourseCategoryCard(
                  label: AppStrings.subjectLanguage,
                  icon: Icons.translate_rounded,
                  isSelected: selectedCategory == 'language',
                  onTap: () => ref
                      .read(coursesControllerProvider.notifier)
                      .setCategory('language'),
                ),
                const SizedBox(width: AppValues.space4),
                CourseCategoryCard(
                  label: AppStrings.subjectArts,
                  icon: Icons.palette_rounded,
                  isSelected: selectedCategory == 'arts',
                  onTap: () => ref
                      .read(coursesControllerProvider.notifier)
                      .setCategory('arts'),
                ),
              ],
            ),
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
                  crossAxisSpacing: AppValues.space4,
                  mainAxisSpacing: AppValues.space5,
                  childAspectRatio: 0.72,
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
          const SizedBox(height: AppValues.space9),
        ],
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            AppColors.courseHeroGradTop,
            AppColors.courseHeroGradBottom,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppValues.radiusCardLg),
        boxShadow: const [
          BoxShadow(
            color: AppColors.clayFilterActiveShadow,
            offset: Offset(0, AppValues.offsetY3),
            blurRadius: AppValues.space6,
          ),
        ],
      ),
      padding: const EdgeInsets.all(AppValues.space6),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.brighterFutureTitle,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontTitleHero,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textInverse,
                    height: AppValues.lineHeightTight,
                  ),
                ),
                const SizedBox(height: AppValues.space2),
                Text(
                  AppStrings.brighterFutureSubtitle,
                  style: GoogleFonts.quicksand(
                    fontSize: AppValues.fontCaptionSm,
                    fontWeight: FontWeight.w600,
                    color: AppColors.ringTrackLavender,
                  ),
                ),
              ],
            ),
          ),
          Image.asset(
            AppAssets.mascotBoyWaving,
            width: AppValues.sizeLoginHeroMascotH * 0.52,
            height: AppValues.sizeLoginHeroMascotH * 0.52,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
