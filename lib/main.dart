import 'package:flutter/material.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:task_tejas/generated/l10n/app_localizations.dart';

import 'package:provider/provider.dart';

import 'core/services/localization_service.dart';

import 'core/theme/app_theme.dart';

import 'di/injection.dart';

import 'routes/app_router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        /// Localization
        ChangeNotifierProvider(create: (_) => localizationService),

        /// App Providers
        ...providers,
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localizationService = context.watch<LocalizationService>();

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,

      routerConfig: appRouter,

      locale: context.watch<LocalizationService>().locale,

      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
