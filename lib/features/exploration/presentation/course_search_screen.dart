import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_values.dart';
import '../../../core/router/app_router.gr.dart';
import '../../../shared/ui_kit/navigation/clay_screen_header.dart';
import 'controllers/course_search_controller.dart';
import 'widgets/course_search_card.dart';

@RoutePage()
class CourseSearchScreen extends ConsumerStatefulWidget {
  const CourseSearchScreen({super.key});

  @override
  ConsumerState<CourseSearchScreen> createState() => _CourseSearchScreenState();
}

class _CourseSearchScreenState extends ConsumerState<CourseSearchScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(courseSearchControllerProvider);

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
                title: AppStrings.searchCoursesTitle,
                subtitle: AppStrings.searchCoursesSubtitle,
                onBackPressed: () => Navigator.of(context).maybePop(),
              ),
              const SizedBox(height: AppValues.space5),

              // Search Text Field
              _buildSearchBar(ref),
              const SizedBox(height: AppValues.space6),

              // Results Count / Status Header
              searchState.results.when(
                data: (courses) => Padding(
                  padding: const EdgeInsets.only(bottom: AppValues.space4),
                  child: Text(
                    '${AppStrings.searchResultsTitle} (${courses.length})',
                    style: GoogleFonts.quicksand(
                      fontSize: AppValues.fontTitleMd,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
              ),

              // Results List / Empty State
              Expanded(
                child: searchState.results.when(
                  data: (courses) {
                    if (courses.isEmpty) {
                      return _buildEmptyState(ref);
                    }
                    return ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        final course = courses[index];
                        return CourseSearchCard(
                          course: course,
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

  Widget _buildSearchBar(WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceInputPill,
        borderRadius: BorderRadius.circular(AppValues.radiusPill),
        border: Border.all(
          color: AppColors.borderInputPill,
          width: AppValues.borderWidthHairline,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: AppValues.space5),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            color: AppColors.brandPrimary,
            size: AppValues.iconSizeLg,
          ),
          const SizedBox(width: AppValues.space3),
          Expanded(
            child: TextField(
              controller: _textController,
              onChanged: (val) {
                ref.read(courseSearchControllerProvider.notifier).onQueryChanged(val);
              },
              style: GoogleFonts.quicksand(
                fontSize: AppValues.fontBodyMd,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              decoration: InputDecoration(
                hintText: AppStrings.searchCoursesTitle,
                hintStyle: GoogleFonts.quicksand(
                  fontSize: AppValues.fontBodyMd,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMuted,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(vertical: AppValues.space5),
              ),
            ),
          ),
          if (_textController.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _textController.clear();
                ref.read(courseSearchControllerProvider.notifier).clearQuery();
              },
              child: const Icon(
                Icons.close_rounded,
                color: AppColors.textMuted,
                size: AppValues.iconSizeMd,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off_rounded,
            size: AppValues.space11 + AppValues.space6,
            color: AppColors.textMuted,
          ),
          const SizedBox(height: AppValues.space4),
          Text(
            AppStrings.noCoursesFoundTitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontTitleHero,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppValues.space2),
          Text(
            AppStrings.noCoursesFoundSubtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.quicksand(
              fontSize: AppValues.fontBodySm,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
