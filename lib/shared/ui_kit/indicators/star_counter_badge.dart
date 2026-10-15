import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_values.dart';

/// Tactile Star & Streak Counter Badge
class StarCounterBadge extends StatelessWidget {
  final int count;
  final bool isStreak;

  const StarCounterBadge({
    super.key,
    required this.count,
    this.isStreak = false,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = isStreak ? const Color(0xFFFFEDD5) : const Color(0xFFFEF3C7);
    final iconColor = isStreak ? const Color(0xFFEA580C) : AppColors.brandSecondary;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.space5,
        vertical: AppValues.space2,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(AppValues.radiusPill),
        border: Border.all(
          color: iconColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isStreak ? Icons.local_fire_department_rounded : Icons.star_rounded,
            color: iconColor,
            size: 20,
          ),
          const SizedBox(width: AppValues.space1),
          Text(
            '$count',
            style: TextStyle(
              color: iconColor,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
