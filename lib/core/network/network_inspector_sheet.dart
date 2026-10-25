import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_values.dart';
import 'network_log_entry.dart';
import 'network_log_manager.dart';

/// Modal sheet displaying recent network logs with copy buttons
class NetworkInspectorSheet extends StatefulWidget {
  final VoidCallback? onClose;

  const NetworkInspectorSheet({super.key, this.onClose});

  static void show(BuildContext context) {
    final nav = Navigator.maybeOf(context);
    if (nav == null) return;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppValues.radiusXl),
        ),
      ),
      builder: (_) => const NetworkInspectorSheet(),
    );
  }

  @override
  State<NetworkInspectorSheet> createState() => _NetworkInspectorSheetState();
}

class _NetworkInspectorSheetState extends State<NetworkInspectorSheet> {
  String? _selectedEntryId;
  String? _toastMessage;
  Timer? _toastTimer;

  @override
  void dispose() {
    _toastTimer?.cancel();
    super.dispose();
  }

  void _copy(String text, String label) {
    NetworkLogManager.instance.copyToClipboard(text);
    final sm = ScaffoldMessenger.maybeOf(context);
    if (sm != null) {
      sm.showSnackBar(
        SnackBar(
          content: Text('$label: ${AppStrings.copiedToClipboard}'),
          duration: AppValues.durationFeedback,
          backgroundColor: AppColors.brandPrimary,
        ),
      );
    }
    setState(() {
      _toastMessage = '$label: ${AppStrings.copiedToClipboard}';
    });
    _toastTimer?.cancel();
    _toastTimer = Timer(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _toastMessage = null;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<NetworkLogEntry>>(
      valueListenable: NetworkLogManager.instance.logsNotifier,
      builder: (context, logs, _) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppValues.space7,
            vertical: AppValues.space5,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_toastMessage != null) _buildToast(),
              _buildHeader(context, logs.length),
              const SizedBox(height: AppValues.space4),
              Expanded(
                child: logs.isEmpty
                    ? const Center(
                        child: Text(
                          AppStrings.noNetworkLogs,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: AppValues.fontBodyMd,
                          ),
                        ),
                      )
                    : ListView.separated(
                        itemCount: logs.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: AppValues.space4),
                        itemBuilder: (context, index) {
                          final entry = logs[index];
                          final isExpanded = _selectedEntryId == entry.id;
                          return _buildLogCard(entry, isExpanded);
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildToast() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: AppValues.space2),
        padding: const EdgeInsets.symmetric(
          horizontal: AppValues.space6,
          vertical: AppValues.space2,
        ),
        decoration: BoxDecoration(
          color: AppColors.brandPrimary,
          borderRadius: BorderRadius.circular(AppValues.radiusPill),
        ),
        child: Text(
          _toastMessage!,
          style: const TextStyle(
            color: AppColors.textInverse,
            fontSize: AppValues.fontCaptionSm,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, int count) {
    return Row(
      children: [
        const Icon(
          Icons.wifi_tethering_rounded,
          color: AppColors.brandPrimary,
          size: AppValues.iconSizeLg,
        ),
        const SizedBox(width: AppValues.space4),
        Expanded(
          child: Text(
            '${AppStrings.networkInspectorTitle} ($count)',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: AppValues.fontTitleMd,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        TextButton(
          onPressed: () => NetworkLogManager.instance.clear(),
          child: const Text(
            AppStrings.clearLogs,
            style: TextStyle(color: AppColors.feedbackError),
          ),
        ),
        IconButton(
          key: const Key('network_inspector_close_button'),
          icon: const Icon(Icons.close_rounded),
          onPressed: () {
            if (widget.onClose != null) {
              widget.onClose!();
            } else {
              Navigator.maybeOf(context)?.pop();
            }
          },
        ),
      ],
    );
  }

  Widget _buildLogCard(NetworkLogEntry entry, bool isExpanded) {
    final statusColor = entry.isSuccess
        ? AppColors.brandMint
        : (entry.statusCode == null
            ? AppColors.brandSecondary
            : AppColors.feedbackError);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppValues.radiusLg),
        border: Border.all(
          color: isExpanded ? AppColors.brandPrimary : AppColors.borderDefault,
          width: AppValues.borderWidthDefault,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              setState(() {
                _selectedEntryId = isExpanded ? null : entry.id;
              });
            },
            title: Row(
              children: [
                _buildBadge(entry.method, AppColors.brandPrimary),
                const SizedBox(width: AppValues.space2),
                _buildBadge(
                  entry.statusCode?.toString() ?? '...',
                  statusColor,
                ),
                const SizedBox(width: AppValues.space4),
                Text(
                  '${entry.durationMs}ms',
                  style: const TextStyle(
                    fontSize: AppValues.fontCaptionSm,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: AppValues.space2),
              child: Text(
                entry.url,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: AppValues.fontBodySm,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            trailing: Icon(
              isExpanded
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded,
              color: AppColors.textSecondary,
            ),
          ),
          if (isExpanded) _buildExpandedContent(entry),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppValues.space2,
        vertical: AppValues.space1,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppValues.radiusSm),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: AppValues.fontCaptionSm,
        ),
      ),
    );
  }

  Widget _buildExpandedContent(NetworkLogEntry entry) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppValues.space6,
        0,
        AppValues.space6,
        AppValues.space6,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(color: AppColors.borderDefault),
          Wrap(
            spacing: AppValues.space4,
            runSpacing: AppValues.space2,
            children: [
              OutlinedButton.icon(
                icon: const Icon(Icons.copy_rounded, size: AppValues.iconSizeSm),
                label: const Text(AppStrings.copyResponse),
                onPressed: () =>
                    _copy(entry.formattedResponseBody, AppStrings.responseTab),
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.terminal_rounded,
                    size: AppValues.iconSizeSm),
                label: const Text(AppStrings.copyCurl),
                onPressed: () => _copy(entry.curlCommand, 'cURL'),
              ),
              if (entry.requestBody != null)
                OutlinedButton.icon(
                  icon:
                      const Icon(Icons.send_rounded, size: AppValues.iconSizeSm),
                  label: const Text(AppStrings.copyRequestBody),
                  onPressed: () =>
                      _copy(entry.formattedRequestBody, AppStrings.requestTab),
                ),
            ],
          ),
          const SizedBox(height: AppValues.space4),
          _buildCodeBox(AppStrings.responseTab, entry.formattedResponseBody),
          if (entry.requestBody != null) ...[
            const SizedBox(height: AppValues.space4),
            _buildCodeBox(AppStrings.requestTab, entry.formattedRequestBody),
          ],
        ],
      ),
    );
  }

  Widget _buildCodeBox(String label, String code) {
    return Container(
      padding: const EdgeInsets.all(AppValues.space4),
      decoration: BoxDecoration(
        color: AppColors.surfaceRaised,
        borderRadius: BorderRadius.circular(AppValues.radiusMd),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: AppValues.fontCaptionSm,
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: AppValues.space1),
          SelectableText(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: AppValues.fontBodySm,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
