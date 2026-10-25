import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiddora/core/constants/app_strings.dart';
import 'package:kiddora/core/network/network_inspector_overlay.dart';
import 'package:kiddora/core/network/network_log_entry.dart';
import 'package:kiddora/core/network/network_log_manager.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
      'NetworkInspectorOverlay opens sheet and allows copying without Navigator error',
      (tester) async {
    // Add sample log entry
    NetworkLogManager.instance.clear();
    NetworkLogManager.instance.addRequest(
      NetworkLogEntry(
        id: 'test_1',
        timestamp: DateTime.now(),
        method: 'POST',
        url: 'http://127.0.0.1:8000/api/v1/auth/login',
        statusCode: 200,
        durationMs: 120,
        requestHeaders: {'Content-Type': 'application/json'},
        requestBody: {'email': 'test@kiddora.com', 'password': 'secret'},
        responseBody: {'access_token': 'token123'},
      ),
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: NetworkInspectorOverlay(
          child: Scaffold(
            body: Center(child: Text('App Content')),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify floating button exists
    final floatingBtn =
        find.byKey(const Key('network_inspector_floating_button'));
    expect(floatingBtn, findsOneWidget);

    // Tap floating button to open inspector
    await tester.tap(floatingBtn);
    await tester.pumpAndSettle();

    // Verify sheet title and log entry rendered
    expect(find.textContaining(AppStrings.networkInspectorTitle), findsOneWidget);
    expect(find.text('http://127.0.0.1:8000/api/v1/auth/login'), findsOneWidget);
    expect(find.text('POST'), findsOneWidget);
    expect(find.text('200'), findsOneWidget);

    // Tap log card to expand
    await tester.tap(find.text('http://127.0.0.1:8000/api/v1/auth/login'));
    await tester.pumpAndSettle();

    // Verify copy buttons are visible
    expect(find.text(AppStrings.copyResponse), findsOneWidget);
    expect(find.text(AppStrings.copyCurl), findsOneWidget);
    expect(find.text(AppStrings.copyRequestBody), findsOneWidget);

    // Tap copy response
    await tester.tap(find.text(AppStrings.copyResponse));
    await tester.pump(const Duration(milliseconds: 1600));
    await tester.pumpAndSettle();

    // Verify close button closes the inspector
    await tester.tap(find.byKey(const Key('network_inspector_close_button')));
    await tester.pumpAndSettle();

    // Floating button should be visible again
    expect(floatingBtn, findsOneWidget);
  });
}
