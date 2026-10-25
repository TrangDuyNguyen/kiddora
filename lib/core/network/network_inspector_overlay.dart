import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_values.dart';
import 'network_inspector_sheet.dart';

/// Floating debug overlay that opens the Network Inspector sheet in debug mode
class NetworkInspectorOverlay extends StatefulWidget {
  final Widget child;

  const NetworkInspectorOverlay({
    super.key,
    required this.child,
  });

  @override
  State<NetworkInspectorOverlay> createState() =>
      _NetworkInspectorOverlayState();
}

class _NetworkInspectorOverlayState extends State<NetworkInspectorOverlay> {
  double _bottom = AppValues.space11;
  double _right = AppValues.space7;
  bool _isOpen = false;

  void _closeSheet() {
    setState(() => _isOpen = false);
  }

  void _openSheet() {
    setState(() => _isOpen = true);
  }

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      return widget.child;
    }

    final screenHeight = MediaQuery.of(context).size.height;

    return PopScope(
      canPop: !_isOpen,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && _isOpen) {
          _closeSheet();
        }
      },
      child: Stack(
        children: [
          widget.child,
          if (!_isOpen)
            Positioned(
              bottom: _bottom,
              right: _right,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    _bottom -= details.delta.dy;
                    _right -= details.delta.dx;
                  });
                },
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    key: const Key('network_inspector_floating_button'),
                    borderRadius: BorderRadius.circular(AppValues.radiusPill),
                    onTap: _openSheet,
                    child: Container(
                      width: AppValues.minTouchTarget,
                      height: AppValues.minTouchTarget,
                      decoration: BoxDecoration(
                        color: AppColors.brandPrimary,
                        shape: BoxShape.circle,
                        boxShadow: const [
                          BoxShadow(
                            color: AppColors.clayShadow,
                            blurRadius: AppValues.space4,
                            offset: Offset(0, 3),
                          ),
                        ],
                        border: Border.all(
                          color: AppColors.clayHighlightPure,
                          width: AppValues.borderWidthDefault,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.wifi_tethering_rounded,
                          color: AppColors.textInverse,
                          size: AppValues.iconSizeLg,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (_isOpen) ...[
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeSheet,
                child: Container(
                  color: AppColors.clayShade.withValues(alpha: 0.5),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: screenHeight * 0.78,
              child: Material(
                color: AppColors.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppValues.radiusXl),
                ),
                elevation: AppValues.borderWidthFocus,
                child: NetworkInspectorSheet(onClose: _closeSheet),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
