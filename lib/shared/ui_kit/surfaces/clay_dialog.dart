import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/constants/app_values.dart';
import '../buttons/clay_button.dart';
import '../buttons/clay_icon_button.dart';
import '../painters/clay_inset_painter.dart';

/// Tactile Claymorphic Modal Dialog — DESIGN.md §2.5 Level 3 Clay Modal
class ClayDialog extends StatelessWidget {
  final Widget illustration;
  final String title;
  final String description;
  final String primaryLabel;
  final VoidCallback? onPrimaryPressed;
  final Widget? primaryIcon;
  final bool isPrimaryLoading;
  final String? secondaryLabel;
  final VoidCallback? onSecondaryPressed;
  final VoidCallback? onClose;

  const ClayDialog({
    super.key,
    required this.illustration,
    required this.title,
    required this.description,
    required this.primaryLabel,
    required this.onPrimaryPressed,
    this.primaryIcon,
    this.isPrimaryLoading = false,
    this.secondaryLabel,
    this.onSecondaryPressed,
    this.onClose,
  });

  static Widget assetIllustration(String path) => Image.asset(
        path,
        width: AppValues.modalIllustrationSize,
        height: AppValues.modalIllustrationSize,
        cacheWidth: AppValues.modalImageCachePx,
        fit: BoxFit.contain,
      );

  static Future<T?> show<T>(
    BuildContext context, {
    bool barrierDismissible = true,
    required WidgetBuilder builder,
  }) =>
      showGeneralDialog<T>(
        context: context,
        barrierDismissible: barrierDismissible,
        barrierLabel: AppStrings.closeDialogLabel,
        barrierColor: AppColors.modalScrim,
        transitionDuration: AppValues.durationSwitch,
        pageBuilder: (ctx, _, __) => builder(ctx),
        transitionBuilder: (_, anim, __, child) => FadeTransition(
          opacity: anim,
          child: ScaleTransition(
            scale: Tween<double>(begin: AppValues.modalScaleStart, end: 1.0)
                .animate(CurvedAnimation(
              parent: anim,
              curve: Curves.easeOutBack,
              reverseCurve: Curves.easeInCubic,
            )),
            child: child,
          ),
        ),
      );

  static Future<bool?> _showConfirm(
    BuildContext context,
    String asset,
    String title,
    String desc,
    String primary,
    String secondary, [
    Widget? icon,
  ]) =>
      show<bool>(
        context,
        builder: (ctx) => ClayDialog(
          illustration: assetIllustration(asset),
          title: title,
          description: desc,
          primaryLabel: primary,
          primaryIcon: icon,
          onPrimaryPressed: () => Navigator.of(ctx).pop(true),
          secondaryLabel: secondary,
          onSecondaryPressed: () => Navigator.of(ctx).pop(false),
        ),
      );

  static Future<bool?> showLogout(BuildContext ctx) => _showConfirm(
        ctx,
        AppAssets.modalLogoutDoor,
        AppStrings.modalLogoutTitle,
        AppStrings.modalLogoutBody,
        AppStrings.modalLogoutConfirm,
        AppStrings.modalCancel,
      );

  static Future<bool?> showEmptySessions(BuildContext ctx) => _showConfirm(
        ctx,
        AppAssets.modalEmptySessions,
        AppStrings.modalNoSessionsTitle,
        AppStrings.modalNoSessionsBody,
        AppStrings.modalExploreCourses,
        AppStrings.modalMaybeLater,
      );

  static Future<bool?> showNetworkError(BuildContext ctx) => _showConfirm(
        ctx,
        AppAssets.modalErrorOffline,
        AppStrings.modalErrorTitle,
        AppStrings.modalErrorBody,
        AppStrings.modalRetry,
        AppStrings.modalGoOffline,
        const Icon(
          Icons.refresh_rounded,
          size: AppValues.iconSizeMd,
          color: AppColors.textInverse,
        ),
      );

  Widget _buildBodyAndActions(BuildContext context) => Padding(
        padding: const EdgeInsets.all(AppValues.space9),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: AppValues.space4),
                    illustration,
                    const SizedBox(height: AppValues.space7),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        fontSize: AppValues.fontHeadlineMid,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                        letterSpacing: AppValues.letterSpacingCondensed,
                      ),
                    ),
                    const SizedBox(height: AppValues.space5),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.quicksand(
                        fontSize: AppValues.fontBodyMd,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSlateDark,
                        height: AppValues.lineHeightRelaxed,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppValues.space9),
            ClayButton(
              width: double.infinity,
              label: primaryLabel,
              icon: primaryIcon,
              isLoading: isPrimaryLoading,
              onPressed: onPrimaryPressed,
            ),
            if (secondaryLabel != null) ...[
              const SizedBox(height: AppValues.radiusLg),
              ClayButton.secondary(
                width: double.infinity,
                label: secondaryLabel!,
                onPressed: onSecondaryPressed ??
                    () => Navigator.of(context).maybePop(),
              ),
            ],
          ],
        ),
      );

  Widget _buildCloseBtn(VoidCallback close) => Positioned(
        top: AppValues.modalCloseOffset,
        right: AppValues.modalCloseOffset,
        child: Semantics(
          button: true,
          label: AppStrings.closeDialogLabel,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: close,
            child: Container(
              width: AppValues.minTouchTarget,
              height: AppValues.minTouchTarget,
              alignment: Alignment.center,
              child: ClayIconButton(
                size: AppValues.sizeCircleButtonMd,
                backgroundColor: AppColors.surfaceContainer,
                onPressed: close,
                icon: const Icon(
                  Icons.close_rounded,
                  size: AppValues.iconSizeSm,
                  color: AppColors.textDarkIndigo,
                ),
              ),
            ),
          ),
        ),
      );

  Widget _buildModalSurface(
    BuildContext context,
    double maxH,
    VoidCallback close,
  ) =>
      Container(
        constraints: BoxConstraints(
          maxWidth: AppValues.modalMaxWidth,
          maxHeight: maxH,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppValues.radiusModal),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.surfaceContainer,
              AppColors.clayCardGradMid,
              AppColors.clayCardSurfaceTint,
            ],
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.clayModalShadow,
              offset: Offset(0, AppValues.modalShadowOffsetY),
              blurRadius: AppValues.modalShadowBlur,
              spreadRadius: AppValues.spreadModal,
            ),
          ],
        ),
        child: CustomPaint(
          painter: const ClayInsetPainter(
            borderRadius: AppValues.radiusModal,
            highlightColor: AppColors.clayHighlightStrong,
            shadeColor: AppColors.clayModalShade,
            highlightOffset: Offset(
              AppValues.modalInsetOffset,
              AppValues.modalInsetOffset,
            ),
            shadeOffset: Offset(
              -AppValues.modalInsetOffset,
              -AppValues.modalInsetOffset,
            ),
            highlightBlur: AppValues.modalInsetBlur,
            shadeBlur: AppValues.modalInsetBlur,
          ),
          child: Stack(
            children: [
              _buildBodyAndActions(context),
              _buildCloseBtn(close),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final maxH =
        MediaQuery.sizeOf(context).height * AppValues.modalMaxHeightFactor;
    final close = onClose ?? () => Navigator.of(context).maybePop();
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppValues.space9),
        child: Material(
          type: MaterialType.transparency,
          child: RepaintBoundary(
            child: _buildModalSurface(context, maxH, close),
          ),
        ),
      ),
    );
  }
}
