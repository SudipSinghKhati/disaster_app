import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';


import '../config/router/app_route.dart';
import '../config/theme/app_theme.dart';
import '../fetures/home/data/model/proximity.dart';
import 'common/Provider/is_dark_theme.dart';


class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkTheme = ref.watch(isDarkThemeProvider);

    return ProximityBrightnessControl(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Disaster Management',
        theme: AppTheme.getApplicationTheme(isDarkTheme),
        initialRoute: AppRoute.splashRoute,
        routes: AppRoute.getApplicationRoute(),
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('es', 'ES'),
        ],
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale!.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }

          return supportedLocales.first;
        },
      ),
    );
  }
}

class AppLocalizations {
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  String signInToContinue() => Intl.message('Sign In to Continue');
  String email() => Intl.message('Email');
  String enterEmailAddress() => Intl.message('Enter Email Address');
  String password() => Intl.message('Password');
  String enterPassword() => Intl.message('Enter Password');
  String signIn() => Intl.message('Sign In');
  String haventSignInYet() => Intl.message("Haven't Signed In Yet");
  String signUp() => Intl.message('Sign Up');
  String here() => Intl.message('Here');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      Future(() => AppLocalizations());

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

