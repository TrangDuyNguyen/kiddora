import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ClayPageIndicator extends StatelessWidget {
  const ClayPageIndicator({
    super.key,
    required this.currentPage,
    this.pageCount = 3,
  });

  final int currentPage;
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(pageCount, (index) {
        final isActive = index == currentPage;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: isActive ? 24 : 8,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.brandPrimary
                : AppColors.brandPrimary.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(4),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.brandPrimary.withValues(alpha: 0.35),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
        );
      }),
    );
  }
}
