import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_values.dart';

/// Tactile Claymorphic Input Field — DESIGN.md Level 1 Inset Porcelain
///
/// Provides a soft, pillow-like inset text input surface with specular highlight,
/// custom prefix/suffix icons, and high-visibility focus indicator.
class ClayTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;

  const ClayTextField({
    super.key,
    this.controller,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.onSubmitted,
    this.validator,
  });

  @override
  State<ClayTextField> createState() => _ClayTextFieldState();
}

class _ClayTextFieldState extends State<ClayTextField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _isFocused = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppValues.durationBounce,
      decoration: BoxDecoration(
        color: AppColors.surfaceField,
        borderRadius: BorderRadius.circular(AppValues.radiusInput),
        border: Border.all(
          color: _isFocused ? AppColors.brandPrimary : AppColors.borderLight,
          width: _isFocused
              ? AppValues.borderWidthFocus
              : AppValues.borderWidthHairline,
        ),
        boxShadow: [
          const BoxShadow(
            color: Colors.white,
            offset: Offset(-2, -2),
            blurRadius: AppValues.radiusXs,
          ),
          BoxShadow(
            color: AppColors.clayShadeSubtle,
            offset: const Offset(2, 3),
            blurRadius: AppValues.space1,
          ),
          if (_isFocused)
            BoxShadow(
              color: AppColors.brandPrimary.withValues(alpha: 0.15),
              offset: Offset.zero,
              blurRadius: AppValues.space4,
              spreadRadius: AppValues.borderWidthThin,
            ),
        ],
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmitted,
        validator: widget.validator,
        style: GoogleFonts.quicksand(
          fontSize: AppValues.fontTitleMd,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: GoogleFonts.quicksand(
            fontSize: AppValues.fontBodyMd,
            fontWeight: FontWeight.w500,
            color: AppColors.textMuted,
          ),
          prefixIcon: widget.prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppValues.space6,
                  ),
                  child: widget.prefixIcon,
                )
              : null,
          prefixIconConstraints: const BoxConstraints(
            minWidth: AppValues.minTouchTarget,
            minHeight: AppValues.minTouchTarget,
          ),
          suffixIcon: widget.suffixIcon != null
              ? Padding(
                  padding: const EdgeInsets.only(
                    right: AppValues.space5,
                  ),
                  child: widget.suffixIcon,
                )
              : null,
          suffixIconConstraints: const BoxConstraints(
            minWidth: AppValues.actionButtonSmall,
            minHeight: AppValues.actionButtonSmall,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppValues.space7,
            vertical: AppValues.space7,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
