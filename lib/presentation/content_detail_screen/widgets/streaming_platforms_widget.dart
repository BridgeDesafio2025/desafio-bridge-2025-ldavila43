import 'package:flutter/material.dart';
import 'package:movies__series_app/core/model/streaming_platform.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/app_export.dart';

class StreamingPlatformsWidget extends StatelessWidget {
  final List<StreamingPlatform> platforms;

  const StreamingPlatformsWidget({
    super.key,
    required this.platforms,
  });

  @override
  Widget build(BuildContext context) {
    if (platforms.isEmpty) {
      return const SizedBox.shrink();
    }
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Disponível em',
            style: AppTheme.darkTheme.textTheme.titleLarge?.copyWith(
              color: AppTheme.contentWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 2.h),
          Wrap(
            spacing: 3.w,
            runSpacing: 2.h,
            children: platforms.map((platform) {
              Widget imageToShow;

              final bool hasValidUrl = platform.logoUrl != null &&
                  platform.logoUrl!.isNotEmpty &&
                  !platform.logoUrl!.contains('placeholder.com');

              if (hasValidUrl) {
                imageToShow = Image.network(
                  platform.logoUrl!,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) =>
                      progress == null
                          ? child
                          : const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                  errorBuilder: (context, error, stackTrace) => Image.asset(
                      platform.logoAsset,
                      errorBuilder: (c, e, s) =>
                          const Icon(Icons.image_not_supported, color: Colors.grey)),
                );
              } else {
                imageToShow = Image.asset(
                  platform.logoAsset,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.image_not_supported, color: Colors.grey),
                );
              }

              return GestureDetector(
                onTap: () => _openPlatformApp(context, platform),
                child: Container(
                  width: 42.w,
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryDark,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppTheme.borderColor.withOpacity(0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10.w,
                        height: 10.w,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: imageToShow,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              platform.name,
                              style: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                                color: AppTheme.contentWhite,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 0.5.h),
                            Text(
                              platform.type,
                              style: AppTheme.darkTheme.textTheme.bodySmall?.copyWith(
                                color: AppTheme.mutedText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        Icons.open_in_new,
                        color: AppTheme.accentColor,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.redAccent : AppTheme.accentColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  void _openPlatformApp(BuildContext context, StreamingPlatform platform) async {
    if (platform.deepLink != null && platform.deepLink!.isNotEmpty) {
      final Uri url = Uri.parse(platform.deepLink!);
      try {
        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
          _showSnackBar(context, 'Não foi possível abrir o link.', isError: true);
        }
      } catch (_) {
        _showSnackBar(context, 'Não foi possível encontrar o aplicativo.', isError: true);
      }
    } else {
      _showSnackBar(context, 'Nenhum link disponível para esta plataforma.', isError: true);
    }
  }
}