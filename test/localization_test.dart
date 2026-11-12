import 'package:dompet/configure/get_translate.dart';
import 'package:dompet/service/locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('loads and switches English, Chinese, and Turkish', (
    tester,
  ) async {
    final translations = JsonTranslations();
    await translations.init();

    await tester.pumpWidget(
      GetMaterialApp(
        translations: translations,
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'US'),
        home: Builder(
          builder: (context) => Scaffold(body: Text('Language'.tr)),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Language'), findsOneWidget);

    Get.updateLocale(const Locale('zh', 'CN'));
    await tester.pumpAndSettle();
    expect(find.text('语言'), findsOneWidget);

    final localeController = LocaleController();
    localeController.update(const Locale('tr'));
    await tester.pumpAndSettle();

    expect(localeController.locale.value, const Locale('tr', 'TR'));
    expect(find.text('Dil'), findsOneWidget);
  });
}
