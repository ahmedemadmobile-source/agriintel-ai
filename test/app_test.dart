import 'package:agriintel_ai/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Drives the real app the way a user would, on a phone-sized surface.
void main() {
  setUp(() {
    final TestWidgetsFlutterBinding binding =
        TestWidgetsFlutterBinding.ensureInitialized();
    binding.window.physicalSizeTestValue = const Size(1170, 2532);
    binding.window.devicePixelRatioTestValue = 3.0;
  });

  Future<void> openApp(WidgetTester tester) async {
    await tester.pumpWidget(const AgriIntelApp());
    await tester.pumpAndSettle();
    await tester.tap(find.text('يلا نبدأ'));
    await tester.pumpAndSettle();
  }

  testWidgets('onboarding opens the dashboard', (WidgetTester tester) async {
    await openApp(tester);
    expect(find.textContaining('صباح الخير'), findsOneWidget);
    expect(find.text('مهام النهارده'), findsOneWidget);
  });

  testWidgets('language toggle flips the whole UI to English',
      (WidgetTester tester) async {
    await openApp(tester);
    await tester.tap(find.text('English').first);
    await tester.pumpAndSettle();
    expect(find.textContaining('Good morning'), findsOneWidget);
    expect(find.text("Today's actions"), findsOneWidget);
    expect(Directionality.of(tester.element(find.text('Home').last)),
        TextDirection.ltr);
  });

  testWidgets('wheat diagnosis surfaces the low-confidence expert path',
      (WidgetTester tester) async {
    await openApp(tester);
    await tester.tap(find.text('التشخيص').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('قمح'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('الكاميرا'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('حلّل الصورة'));
    await tester.pumpAndSettle();

    expect(find.text('نتيجة التشخيص'), findsOneWidget);
    expect(find.text('58%'), findsOneWidget);
    expect(find.text('نتيجة ثقتها منخفضة'), findsOneWidget);
    expect(find.text('اطلب مراجعة خبير'), findsOneWidget);
  });

  testWidgets('saving a diagnosis adds it to the dashboard history',
      (WidgetTester tester) async {
    await openApp(tester);
    await tester.tap(find.text('التشخيص').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('الكاميرا'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('حلّل الصورة'));
    await tester.pumpAndSettle();

    expect(find.text('اللفحة المبكرة'), findsOneWidget);

    // The save button sits below the fold of a lazily-built ListView.
    await tester.dragUntilVisible(
      find.text('احفظ في السجل'),
      find.byType(ListView).last,
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('احفظ في السجل'));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(BackButton));
    await tester.pumpAndSettle();
    await tester.tap(find.text('الرئيسية').last);
    await tester.pumpAndSettle();

    // The history section is further down the dashboard.
    await tester.dragUntilVisible(
      find.text('آخر التشخيصات'),
      find.byType(ListView).first,
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();
    expect(find.text('اللفحة المبكرة'), findsOneWidget);
    expect(find.text('لسه مفيش تشخيصات — صوّر أول ورقة.'), findsNothing);
  });

  testWidgets('assistant answers from the knowledge base',
      (WidgetTester tester) async {
    await openApp(tester);
    await tester.tap(find.text('المساعد').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('أسقي الطماطم إمتى؟'));
    await tester.pumpAndSettle();

    expect(find.textContaining('كل ٣ أيام'), findsOneWidget);
  });

  testWidgets('assistant escalates when it has no grounded answer',
      (WidgetTester tester) async {
    await openApp(tester);
    await tester.tap(find.text('المساعد').last);
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'عايز أشتري جرار زراعي');
    await tester.testTextInput.receiveAction(TextInputAction.send);
    await tester.pumpAndSettle();

    expect(find.text('كلّم مهندس زراعي'), findsOneWidget);
  });
}
