import 'dart:io';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:dompet/configure/get_translate.dart';
import 'package:dompet/routes/navigator.dart';
import 'package:dompet/routes/router.dart';
import 'package:dompet/logger/logger.dart';
import 'package:dompet/service/bind.dart';
import 'package:dompet/theme/index.dart';

final translations = JsonTranslations();
const fallbackLocale = Locale('en', 'US');

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    final stack = details.stack;
    final exception = details.exception;

    if (exception is DioException || exception is WebSocketException) {
      return;
    }

    if (exception is Exception || exception is Error) {
      logger.error('App FlutterError.onError...', exception, stack);
      return;
    }
  };

  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    if (error is DioException || error is WebSocketException) {
      return true;
    }

    if (error is Exception || error is Error) {
      logger.error('App PlatformDispatcher.onError...', error, stack);
      return true;
    }

    return true;
  };

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  FirebaseAuth.instanceFor(app: await Firebase.initializeApp());

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
      systemStatusBarContrastEnforced: false,
      statusBarColor: Colors.transparent,
    ),
  );

  await initializeDateFormatting('en_US');
  await initializeDateFormatting('zh_CN');
  await initializeDateFormatting('tr_TR');
  await GetStorage.init('dompet.store');
  await translations.init();
  await logger.init;

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Locale? get locale =>
      storeController.locale.value ?? localeController.locale.value;

  late final mediaQueryController = Get.put(MediaQueryController());
  late final localeController = Get.put(LocaleController());
  late final storeController = Get.put(StoreController());
  late final getPages = GetRouter.pages();

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void initState() {
    super.initState();

    localeController.update(storeController.locale.value ?? Get.deviceLocale);

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      mediaQueryController.update(mediaQuery: MediaQuery.of(context));
    });
  }

  @override
  void didChangeLocales(List<Locale>? locales) {
    if (locales != null &&
        locales.isNotEmpty &&
        storeController.locale.value == null) {
      localeController.update(locales.first);
    }
  }

  @override
  void didChangeAppLifecycleState(state) {
    if (state == AppLifecycleState.resumed) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        mediaQueryController.update(mediaQuery: MediaQuery.of(context));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryController.update(mediaQuery: MediaQuery.of(context));

    return GetMaterialApp.router(
      builder: (context, child) {
        final brightness = Theme.of(context).brightness;
        final systemUiOverlayStyle = SystemUiOverlayStyle(
          statusBarIconBrightness: brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
          systemNavigationBarIconBrightness: brightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
          systemNavigationBarDividerColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarContrastEnforced: false,
          systemStatusBarContrastEnforced: false,
          statusBarColor: Colors.transparent,
        );

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: systemUiOverlayStyle,
          child: Obx(() {
            final mediaQuery = mediaQueryController;
            final textScaler = mediaQuery.textScaler.value;

            Widget overlayBuilder(context) => child!;

            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: textScaler),
              child: Overlay(
                initialEntries: [OverlayEntry(builder: overlayBuilder)],
              ),
            );
          }),
        );
      },
      supportedLocales: [
        // supports
        Locale('en', 'US'),
        Locale('zh', 'CN'),
        Locale('tr', 'TR'),
      ],
      localizationsDelegates: [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      logWriterCallback: GetRouter.logWriter,
      defaultTransition: Transition.rightToLeft,
      routerDelegate: AppDelegate(pages: getPages),
      fallbackLocale: fallbackLocale,
      translations: translations,
      enableLog: kDebugMode,
      getPages: getPages,
      locale: locale,
      title: 'Dompet',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      binds: binds,
    );
  }
}
