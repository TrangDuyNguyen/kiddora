import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiddora/core/constants/app_strings.dart';
import 'package:kiddora/features/exploration/presentation/pages/mini_game_playground_screen.dart';
import 'package:kiddora/shared/ui_kit/ui_kit.dart';

void main() {
  testWidgets('MiniGamePlaygroundScreen renders all 5 game tabs and switches views',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: MiniGamePlaygroundScreen(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // 1. Header and 5 game tabs
    expect(find.text(AppStrings.playgroundTitle), findsOneWidget);
    expect(find.text(AppStrings.gameTabSorter), findsOneWidget);
    expect(find.text(AppStrings.gameTabBalancer), findsOneWidget);
    expect(find.text(AppStrings.gameTabPopper), findsOneWidget);
    expect(find.text(AppStrings.gameTabTracer), findsOneWidget);
    expect(find.text(AppStrings.gameTabFlipper), findsOneWidget);

    // Default is Sorter
    expect(find.byType(ClayDragDropSorter), findsOneWidget);
    expect(find.text(AppStrings.dragDropInstruction), findsOneWidget);

    // 2. Switch to Balancer tab
    await tester.tap(find.text(AppStrings.gameTabBalancer));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byType(ClayScaleBalancer), findsOneWidget);
    expect(find.text(AppStrings.scaleBalanceInstruction), findsWidgets);

    // 3. Switch to Popper tab
    await tester.tap(find.text(AppStrings.gameTabPopper));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byType(ClayBubblePopper), findsOneWidget);
    expect(find.text(AppStrings.bubblePopInstruction), findsOneWidget);

    // 4. Switch to Tracer tab
    await tester.tap(find.text(AppStrings.gameTabTracer));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byType(MagicStrokeTracer), findsOneWidget);
    expect(find.text(AppStrings.strokeTraceInstruction), findsOneWidget);

    // 5. Switch to Flipper tab
    await tester.tap(find.text(AppStrings.gameTabFlipper));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    expect(find.byType(ClayCardFlipper), findsOneWidget);
    expect(find.text(AppStrings.cardFlipInstruction), findsOneWidget);
  });
}
