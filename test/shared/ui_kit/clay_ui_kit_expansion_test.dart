import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiddora/core/constants/app_assets.dart';
import 'package:kiddora/core/constants/app_colors.dart';
import 'package:kiddora/core/constants/app_strings.dart';
import 'package:kiddora/core/constants/app_values.dart';
import 'package:kiddora/shared/ui_kit/ui_kit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ClayDialog 3 Variants & 1.5x Text Scale Overflow Audit', () {
    testWidgets('showNetworkError renders 3D cloud, retry icon, and returns choice',
        (tester) async {
      bool? result;
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (ctx) => Scaffold(
              body: Center(
                child: ClayButton(
                  label: AppStrings.modalRetry,
                  onPressed: () async {
                    result = await ClayDialog.showNetworkError(ctx);
                  },
                ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text(AppStrings.modalRetry));
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.modalErrorTitle), findsOneWidget);
      expect(find.text(AppStrings.modalErrorBody), findsOneWidget);
      expect(find.byIcon(Icons.refresh_rounded), findsOneWidget);
      expect(find.text(AppStrings.modalGoOffline), findsOneWidget);

      // Verify Close button hit area >= 48x48dp inside ClayDialog
      final closeFinder = find.descendant(
        of: find.byType(ClayDialog),
        matching: find.bySemanticsLabel(AppStrings.closeDialogLabel),
      );
      expect(closeFinder, findsOneWidget);
      final closeSize = tester.getSize(closeFinder);
      expect(closeSize.width, greaterThanOrEqualTo(AppValues.minTouchTarget));
      expect(closeSize.height, greaterThanOrEqualTo(AppValues.minTouchTarget));

      // Tap Go Offline secondary button -> returns false
      await tester.tap(find.text(AppStrings.modalGoOffline));
      await tester.pumpAndSettle();
      expect(result, isFalse);
    });

    testWidgets('survives 360x640 compact viewport with 1.5x textScaler (0 overflow)',
        (tester) async {
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MaterialApp(
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: const TextScaler.linear(1.5),
            ),
            child: child!,
          ),
          home: Scaffold(
            body: ClayDialog(
              illustration:
                  ClayDialog.assetIllustration(AppAssets.modalLogoutDoor),
              title: AppStrings.modalLogoutTitle,
              description: AppStrings.modalLogoutBody,
              primaryLabel: AppStrings.modalLogoutConfirm,
              onPrimaryPressed: () {},
              secondaryLabel: AppStrings.modalCancel,
              onSecondaryPressed: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.text(AppStrings.modalLogoutTitle), findsOneWidget);
      expect(find.text(AppStrings.modalLogoutConfirm), findsOneWidget);
    });
  });

  group('Phase 2 Shared UI Kit Components (Header, FilterBar, ListTile, Badges)', () {
    testWidgets('ClayFilterBar switches active pill and handles 1.5x text without overflow',
        (tester) async {
      int selected = 0;
      const filters = ['All', 'Practice', 'Mock Test', 'Completed'];

      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(textScaler: TextScaler.linear(1.5)),
            child: Scaffold(
              body: StatefulBuilder(
                builder: (ctx, setState) => Padding(
                  padding: const EdgeInsets.all(AppValues.space7),
                  child: ClayFilterBar(
                    items: filters,
                    selectedIndex: selected,
                    onSelected: (i) => setState(() => selected = i),
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      expect(tester.takeException(), isNull);
      await tester.tap(find.text('Mock Test'));
      await tester.pumpAndSettle();
      expect(selected, 2);
    });

    testWidgets('ClayScreenHeader, ClayListTile, ClayButton.compact, and StarCounterBadge.custom work cleanly',
        (tester) async {
      bool backTapped = false;
      bool tileTapped = false;
      bool startTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(AppValues.space7),
              child: Column(
                children: [
                  ClayScreenHeader(
                    title: 'My Profile',
                    subtitle: 'Your learning journey, all in one place!',
                    onBackPressed: () => backTapped = true,
                    trailing: ClayIconButton(
                      size: AppValues.sizeCircleButtonXl,
                      backgroundColor: Colors.white,
                      onPressed: () {},
                      icon: const Icon(Icons.settings_outlined),
                    ),
                  ),
                  const SizedBox(height: AppValues.space7),
                  Row(
                    children: [
                      StarCounterBadge.custom(
                        label: 'Level 5',
                        isPrimary: true,
                        icon: Image.asset(
                          AppAssets.iconCrown3d,
                          width: AppValues.sizeBadgeMicroIcon,
                          height: AppValues.sizeBadgeMicroIcon,
                        ),
                      ),
                      const SizedBox(width: AppValues.space4),
                      StarCounterBadge.custom(
                        label: '1200 Points',
                        icon: Image.asset(
                          AppAssets.iconStarCoin3d,
                          width: AppValues.sizeBadgeMicroIcon,
                          height: AppValues.sizeBadgeMicroIcon,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppValues.space7),
                  ClayCard(
                    child: ClayListTile(
                      leading: Image.asset(
                        AppAssets.iconTestBag3d,
                        width: AppValues.sizeMenuIconCircle,
                        height: AppValues.sizeMenuIconCircle,
                      ),
                      title: 'Mock Test',
                      subtitle: '15 Questions • 15 Mins',
                      trailing: ClayButton.compact(
                        label: 'Start',
                        onPressed: () => startTapped = true,
                      ),
                    ),
                  ),
                  ClayListTile(
                    title: 'Help & Support',
                    showChevron: true,
                    onTap: () => tileTapped = true,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      await tester.tap(find.bySemanticsLabel(AppStrings.backButtonLabel));
      expect(backTapped, isTrue);

      await tester.tap(find.text('Start'));
      expect(startTapped, isTrue);

      await tester.tap(find.text('Help & Support'));
      expect(tileTapped, isTrue);
    });

    testWidgets('Full Tactile Clay UI Kit Showcase with 3D RGBA Assets & Modal',
        (tester) async {
      await tester.pumpWidget(const MaterialApp(home: SizedBox.shrink()));
      final rootCtx = tester.element(find.byType(SizedBox));
      await tester.runAsync(() async {
        await precacheImage(const AssetImage(AppAssets.modalEmptySessions), rootCtx);
        await precacheImage(const AssetImage(AppAssets.iconCrown3d), rootCtx);
        await precacheImage(const AssetImage(AppAssets.iconStarCoin3d), rootCtx);
        await precacheImage(const AssetImage(AppAssets.iconTestBag3d), rootCtx);
      });

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            backgroundColor: AppColors.surface,
            body: Stack(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(AppValues.space7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClayScreenHeader(
                          title: 'My Sessions',
                          subtitle: 'View and manage your learning sessions.',
                          onBackPressed: () {},
                        ),
                        const SizedBox(height: AppValues.space6),
                        ClayFilterBar(
                          items: const ['Upcoming', 'Completed', 'Cancelled'],
                          selectedIndex: 0,
                          onSelected: (_) {},
                        ),
                        const SizedBox(height: AppValues.space6),
                        Row(
                          children: [
                            StarCounterBadge.custom(
                              label: 'Level 5',
                              isPrimary: true,
                              icon: Image.asset(
                                AppAssets.iconCrown3d,
                                width: AppValues.sizeBadgeMicroIcon,
                                height: AppValues.sizeBadgeMicroIcon,
                              ),
                            ),
                            const SizedBox(width: AppValues.space4),
                            StarCounterBadge.custom(
                              label: '1200 Points',
                              icon: Image.asset(
                                AppAssets.iconStarCoin3d,
                                width: AppValues.sizeBadgeMicroIcon,
                                height: AppValues.sizeBadgeMicroIcon,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        ClayCard(
                          child: ClayListTile(
                            leading: Image.asset(
                              AppAssets.iconTestBag3d,
                              width: AppValues.sizeMenuIconCircle,
                              height: AppValues.sizeMenuIconCircle,
                            ),
                            title: 'Science Live Class',
                            subtitle: '22 Sep 2026, 10:00 AM',
                            trailing: ClayButton.compact(
                              label: AppStrings.join,
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ColoredBox(
                  color: AppColors.modalScrim,
                  child: ClayDialog(
                    illustration: Image.asset(
                      AppAssets.modalEmptySessions,
                      width: AppValues.modalIllustrationSize,
                      height: AppValues.modalIllustrationSize,
                      fit: BoxFit.contain,
                    ),
                    title: AppStrings.modalNoSessionsTitle,
                    description: AppStrings.modalNoSessionsBody,
                    primaryLabel: AppStrings.modalExploreCourses,
                    onPrimaryPressed: () {},
                    secondaryLabel: AppStrings.modalMaybeLater,
                    onSecondaryPressed: () {},
                  ),
                ),
              ],
            ),
            bottomNavigationBar: ClayBottomNav(
              selectedIndex: ClayNavTab.sessions.index,
              onIndexChanged: (_) {},
            ),
          ),
        ),
      );
      await tester.pump();
      expect(tester.takeException(), isNull);
    });
  });
}
