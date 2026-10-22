import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/constants/app_values.dart';
import '../../../../core/router/app_router.gr.dart';
import '../../../../shared/ui_kit/buttons/clay_button.dart';
import '../../../../shared/ui_kit/buttons/clay_icon_button.dart';
import '../../../../shared/ui_kit/surfaces/clay_card.dart';
import '../../domain/models/avatar_presets.dart';
import '../controllers/onboarding_controller.dart';
import '../widgets/avatar_clay_pedestal.dart';
import '../widgets/clay_age_wheel_spinner.dart';
import '../widgets/onboarding_pastel_blobs.dart';
import '../widgets/quick_nickname_chips.dart';

@RoutePage()
class KidProfileSetupScreen extends ConsumerStatefulWidget {
  const KidProfileSetupScreen({super.key});

  @override
  ConsumerState<KidProfileSetupScreen> createState() =>
      _KidProfileSetupScreenState();
}

class _KidProfileSetupScreenState extends ConsumerState<KidProfileSetupScreen> {
  late final TextEditingController _nameController;
  int _selectedCategory = 0; // 0: 12 Con Giáp, 1: Bạn Nhỏ

  static List<Map<String, dynamic>> get _classicAvatars =>
      AvatarPresets.classicAvatars;
  static List<Map<String, dynamic>> get _zodiacAvatars =>
      AvatarPresets.zodiacAvatars;
  static String _suggestedZodiacForAge(int age) =>
      AvatarPresets.suggestedZodiacForAge(age);

  @override
  void initState() {
    super.initState();
    final state = ref.read(onboardingControllerProvider);
    _nameController = TextEditingController(text: state.nickname);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _onComplete() async {
    HapticFeedback.mediumImpact();
    final controller = ref.read(onboardingControllerProvider.notifier);
    final success = await controller.completeOnboarding();
    if (success && mounted) {
      try {
        context.router.replace(const HomeRoute());
      } catch (_) {
        // Ignored in test environment without router ancestor
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(onboardingControllerProvider);
    final controller = ref.read(onboardingControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: AppValues.radiusLg),
          child: ClayIconButton(
            size: AppValues.actionButtonSmall,
            backgroundColor: Colors.white,
            extrusionColor: AppColors.clayExtrusionNeutral,
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.textPrimary,
              size: AppValues.iconSizeSm,
            ),
            onPressed: () => context.router.maybePop(),
          ),
        ),
        title: Text(
          AppStrings.setupProfileTitle,
          style: GoogleFonts.quicksand(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w800,
            fontSize: AppValues.fontTitleLg,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          const OnboardingPastelBlobs(),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppValues.space7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              const SizedBox(height: AppValues.space4),
              // Section 1: Nickname Input in Sculpted Clay Capsule
              Text(
                AppStrings.nicknameLabel,
                style: GoogleFonts.quicksand(
                  fontSize: AppValues.fontTitleLg,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppValues.space6),
              ClayCard(
                borderRadius: AppValues.radiusPill,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppValues.space7,
                  vertical: AppValues.radiusXs,
                ),
                child: Row(
                  children: [
                    Container(
                      width: AppValues.inputIconSize,
                      height: AppValues.inputIconSize,
                      decoration: BoxDecoration(
                        color: AppColors.brandPrimary.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.brandPrimary.withValues(alpha: 0.25),
                          width: AppValues.borderWidthHairline,
                        ),
                      ),
                      child: const Icon(
                        Icons.edit_rounded,
                        color: AppColors.brandPrimary,
                        size: AppValues.iconSizeMd,
                      ),
                    ),
                    const SizedBox(width: AppValues.space5),
                    Expanded(
                      child: TextField(
                        controller: _nameController,
                        maxLength: AppValues.nicknameMaxLength,
                        textCapitalization: TextCapitalization.words,
                        onChanged: controller.updateNickname,
                        style: GoogleFonts.quicksand(
                          fontSize: AppValues.fontTitleMd,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        decoration: InputDecoration(
                          hintText: AppStrings.nicknameHint,
                          hintStyle: GoogleFonts.quicksand(
                            color: AppColors.textSecondary,
                            fontWeight: FontWeight.w500,
                            fontSize: AppValues.fontBodyMd,
                          ),
                          border: InputBorder.none,
                          counterText: '',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppValues.space6),
              QuickNicknameChips(
                currentNickname: state.nickname,
                onSelectNickname: (name) {
                  _nameController.text = name;
                  _nameController.selection = TextSelection.fromPosition(
                    TextPosition(offset: name.length),
                  );
                  controller.updateNickname(name);
                },
              ),
              const SizedBox(height: AppValues.space10),

              // Section 2: Tactile Clay Age Wheel Spinner
              Text(
                AppStrings.ageQuestion,
                style: GoogleFonts.quicksand(
                  fontSize: AppValues.fontTitleLg,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppValues.space6),
              ClayAgeWheelSpinner(
                selectedAge: state.selectedAge,
                onAgeChanged: controller.selectAge,
              ),
              const SizedBox(height: AppValues.space10),

              // Section 3: 3D Mascot Pedestal Grid
              Text(
                AppStrings.selectCompanion,
                style: GoogleFonts.quicksand(
                  fontSize: AppValues.fontTitleLg,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppValues.space3),

              // Tactile Segmented Category Switcher
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(AppValues.radiusPill),
                  border: Border.all(color: AppColors.borderDefault),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildCategoryTab(
                      title: AppStrings.zodiacTabTitle,
                      isSelected: _selectedCategory == 0,
                      onTap: () => setState(() => _selectedCategory = 0),
                    ),
                    _buildCategoryTab(
                      title: AppStrings.classicTabTitle,
                      isSelected: _selectedCategory == 1,
                      onTap: () => setState(() => _selectedCategory = 1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppValues.space4),

              // Smart Age-to-Zodiac Hint (When in 12 Zodiac tab)
              if (_selectedCategory == 0) ...[
                Builder(
                  builder: (context) {
                    final suggestedId =
                        _suggestedZodiacForAge(state.selectedAge);
                    final suggestedZodiac = _zodiacAvatars.firstWhere(
                      (item) => item['id'] == suggestedId,
                      orElse: () => _zodiacAvatars[0],
                    );
                    final isAlreadySelected =
                        state.selectedAvatarId == suggestedId;

                    return GestureDetector(
                      onTap: () {
                        HapticFeedback.lightImpact();
                        controller.selectAvatar(suggestedId);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppValues.space6,
                          vertical: AppValues.space2,
                        ),
                        decoration: BoxDecoration(
                          color: isAlreadySelected
                              ? AppColors.brandIndigoContainer
                              : Colors.white,
                          borderRadius:
                              BorderRadius.circular(AppValues.radiusPill),
                          border: Border.all(
                            color: isAlreadySelected
                                ? AppColors.brandPrimary
                                : AppColors.borderDefault,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.auto_awesome_rounded,
                              size: 16,
                              color: isAlreadySelected
                                  ? AppColors.brandPrimary
                                  : AppColors.brandSecondary,
                            ),
                            const SizedBox(width: AppValues.space2),
                            Text(
                              'Bé ${state.selectedAge} tuổi hợp bạn: ',
                              style: GoogleFonts.quicksand(
                                fontSize: AppValues.fontBodySm,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            Text(
                              suggestedZodiac['name'] as String,
                              style: GoogleFonts.quicksand(
                                fontSize: AppValues.fontBodySm,
                                fontWeight: FontWeight.w800,
                                color: AppColors.brandPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppValues.space4),
              ],

              // Avatar Grid (12 Zodiacs or 4 Classic Companions)
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: AppValues.space6,
                mainAxisSpacing: AppValues.space6,
                childAspectRatio: 0.88,
                children: (_selectedCategory == 0
                        ? _zodiacAvatars
                        : _classicAvatars)
                    .map((item) {
                  final isSelected = state.selectedAvatarId == item['id'];
                  return AvatarClayPedestal(
                    name: item['name'] as String,
                    path: item['path'] as String,
                    auraColor: item['auraColor'] as Color?,
                    isSelected: isSelected,
                    onTap: () {
                      HapticFeedback.selectionClick();
                      controller.selectAvatar(item['id'] as String);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: AppValues.space10),

              // Section 4: Primary CTA Button
              SizedBox(
                width: double.infinity,
                child: ClayButton(
                  label: AppStrings.readyToExplore,
                  backgroundColor: AppColors.brandPrimary,
                  isLoading: state.isLoading,
                  onPressed: state.isProfileValid ? _onComplete : null,
                ),
              ),
              const SizedBox(height: AppValues.space9),
            ],
          ),
        ),
      ),
    ],
  ),
);
}

  Widget _buildCategoryTab({
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: AnimatedContainer(
        duration: AppValues.durationFast,
        padding: const EdgeInsets.symmetric(
          horizontal: AppValues.space4,
          vertical: AppValues.space1,
        ),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.brandPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(AppValues.radiusPill),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.brandPrimary.withValues(alpha: 0.25),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                  ),
                ]
              : null,
        ),
        child: Text(
          title,
          style: GoogleFonts.quicksand(
            fontSize: AppValues.fontBodySm,
            fontWeight: FontWeight.w800,
            color: isSelected ? Colors.white : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
