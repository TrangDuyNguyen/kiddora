import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_values.dart';
import '../../../core/router/app_router.gr.dart';
import '../../../shared/ui_kit/buttons/clay_icon_button.dart';
import '../../../shared/ui_kit/inputs/clay_filter_bar.dart';
import '../../../shared/ui_kit/navigation/clay_screen_header.dart';
import 'controllers/courses_controller.dart';
import 'widgets/course_clay_card.dart';

@RoutePage()
class AllCoursesGridScreen extends ConsumerWidget {
  const AllCoursesGridScreen({super.key});

  static const List<String> _categories = [
    'all',
    'science',
    'math',
    'arts',
  ];

  static const List<String> _categoryLabels = [
    AppStrings.subjectAll,
    AppStrings.subjectScience,
    AppStrings.subjectMath,
    AppStrings.subjectArts,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coursesControllerProvider);
    final selectedCategory = state.filter.category;
    final selectedIndex = _categories.indexOf(selectedCategory);
    final activeIndex = selectedIndex >= 0 ? selectedIndex : 0;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppValues.space7),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: AppValues.space4),
              ClayScreenHeader(
                title: AppStrings.allCoursesTitle,
                subtitle: AppStrings.allCoursesSubtitle,
                onBackPressed: () => Navigator.of(context).maybePop(),
                trailing: ClayIconButton(
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
              ),
              const SizedBox(height: AppValues.space5),

              // Filter Bar
              ClayFilterBar(
                items: _categoryLabels,
                selectedIndex: activeIndex,
                onSelected: (idx) {
                  ref
                      .read(coursesControllerProvider.notifier)
                      .setCategory(_categories[idx]);
                },
              ),
              const SizedBox(height: AppValues.space6),

              // 2-Column Grid
              Expanded(
                child: state.courses.when(
                  data: (courses) {
                    if (courses.isEmpty) {
                      return Center(
                        child: Text(
                          AppStrings.noCoursesFoundTitle,
                          style: GoogleFonts.quicksand(
                            fontSize: AppValues.fontTitleMd,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      );
                    }
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: AppValues.space4,
                        mainAxisSpacing: AppValues.space5,
                        childAspectRatio: 0.72,
                      ),
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final course = courses[index];
                        return CourseClayCard(
                          course: course,
                          showFavoriteButton: true,
                          onFavoriteTap: () {
                            ref
                                .read(coursesControllerProvider.notifier)
                                .toggleFavorite(course.id);
                          },
                          onTap: () {
                            context.router.push(CourseDetailRoute(courseId: course.id));
                          },
                        );
                      },
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
            ],
          ),
        ),
      ),
    );
  }
}
