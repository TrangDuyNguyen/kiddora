import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiddora/app.dart';

void main() {
  testWidgets('KiddoraApp renders home screen with greeting and subject worlds', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: KiddoraApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Chào Alex! 🚀'), findsOneWidget);
    expect(find.text('Thế Giới Khám Phá'), findsOneWidget);
    expect(find.text('Toán Tư Duy'), findsOneWidget);
    expect(find.text('Khoa Học STEM'), findsOneWidget);
    expect(find.text('Vào lớp ngay'), findsOneWidget);
  });
}
