import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

/// Soft organic pastel clay blobs matching Dribbble reference background
/// precisely calibrated from pixel color sampling:
/// - Top-Right: Warm Peach/Apricot (#FFEFE6 / #FFE6D2)
/// - Mid-Left & Center: Soft Periwinkle/Lavender Cloud (#E5EFFE / #ECE7FE)
/// - Mid-Right: Soft Sky/Periwinkle (#E7F0FD / #E0F2FE)
/// - Bottom-Left: Soft Violet Lobe peeking behind card (#E9EAFD / #ECE1FE)
/// - Bottom-Right: Soft Rose/Blush Lobe peeking behind card (#FBECF9 / #FCE7F3)
class OnboardingPastelBlobs extends StatelessWidget {
  const OnboardingPastelBlobs({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Base warm porcelain canvas
          Container(color: AppColors.surface),

          // 1. Top-Right: Warm Peach / Apricot Blob (prominent from reference)
          Positioned(
            top: -40,
            right: -30,
            child: Container(
              width: 330,
              height: 320,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: Alignment(0.4, -0.4),
                  radius: 0.95,
                  colors: [
                    AppColors.blobApricot, // Warm apricot core
                    AppColors.blobPeach, // Soft peach transition
                    AppColors.blobPeachFade, // Fade to canvas
                  ],
                  stops: [0.0, 0.65, 1.0],
                ),
              ),
            ),
          ),

          // 2. Mid-Left: Soft Periwinkle / Lavender Cloud (behind mascot & text)
          Positioned(
            top: 150,
            left: -70,
            child: Container(
              width: 360,
              height: 400,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: Alignment(-0.3, 0.0),
                  radius: 0.95,
                  colors: [
                    AppColors.blobPeriwinkle, // Soft periwinkle core
                    AppColors.blobLavender, // Soft lavender tint
                    AppColors.blobLavenderFade, // Fade
                  ],
                  stops: [0.0, 0.68, 1.0],
                ),
              ),
            ),
          ),

          // 3. Mid-Right: Soft Sky / Periwinkle Glow (behind star character)
          Positioned(
            top: 270,
            right: -60,
            child: Container(
              width: 310,
              height: 340,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: Alignment(0.3, 0.0),
                  radius: 0.95,
                  colors: [
                    AppColors.blobSky, // Soft sky tint
                    AppColors.blobSkyMist, // Delicate blue mist
                    AppColors.blobSkyFade, // Fade
                  ],
                  stops: [0.0, 0.65, 1.0],
                ),
              ),
            ),
          ),

          // 4. Bottom-Left: Soft Violet Lobe peeking behind card
          Positioned(
            bottom: 40,
            left: -50,
            child: Container(
              width: 270,
              height: 270,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: Alignment.bottomLeft,
                  radius: 0.9,
                  colors: [
                    AppColors.blobViolet, // Soft violet
                    AppColors.blobVioletTint,
                    AppColors.blobVioletFade,
                  ],
                  stops: [0.0, 0.65, 1.0],
                ),
              ),
            ),
          ),

          // 5. Bottom-Right: Soft Rose / Blush Lobe peeking behind card
          Positioned(
            bottom: 20,
            right: -40,
            child: Container(
              width: 260,
              height: 260,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  center: Alignment.bottomRight,
                  radius: 0.9,
                  colors: [
                    AppColors.blobRose, // Soft rose blush
                    AppColors.blobRoseTint,
                    AppColors.blobRoseFade,
                  ],
                  stops: [0.0, 0.65, 1.0],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
