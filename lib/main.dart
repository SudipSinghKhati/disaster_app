import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/app.dart';

final selectedLocaleProvider = StateProvider<Locale>((ref) {
  return const Locale('en', 'US');
});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [Locale('en', 'US'), Locale('es', 'ES')],
        path: 'lib/l10n',
        fallbackLocale: const Locale('en', 'US'),
        child: const App(),
      ),
    ),
  );
}
