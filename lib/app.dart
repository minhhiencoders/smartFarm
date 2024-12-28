import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_farm_application/page/home/navigation.dart';
import 'router/routing_app.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'services/auth_services.dart';
import 'services/navigation_service.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(builder: (context, constraints) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        locale: const Locale('en', 'US'),
        // supportedLocales: const [
        //   Locale('vi', 'VN'),
        //   Locale('en', 'US'),
        // ],
        // localizationsDelegates: const [
        //   AppLocalizations.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        initialRoute: AppRouter.onboarding,
        routes: {
          AppRouter.onboarding: (context) => const AuthWidget(),
          AppRouter.navigation: (context) => const NavigationScreen(),
        },
        // home: const SafeArea(child: NavigationScreen()),
        onGenerateRoute: AppRouter.onGenerateRoute,
        navigatorKey: AppRouter.navigatorKey,
        navigatorObservers: [NavigationService().navigatorObserver],
      );
    });
  }
}
