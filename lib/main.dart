import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/settings_provider.dart';
import 'package:todo/screens/home_screen/home_screen.dart';
import 'package:todo/utilities/app_theme.dart';
main()  {
  runApp(ChangeNotifierProvider(
      create: (_) => SettingsProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsProvider provider = Provider.of(context);
    return Theme(
      data: ThemeData.light(),
      child: MaterialApp(
        themeMode: ThemeMode.light,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        localizationsDelegates: const [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          AppLocalizations.delegate
        ],
        supportedLocales: const [
          Locale('en'), // English
        ],
        locale: const Locale("en"),
        title: 'To Do',
        debugShowCheckedModeBanner: false,
        routes: {
          HomeScreen.routeName: (_) => HomeScreen(),
        },
        initialRoute: HomeScreen.routeName,
      ),
    );
  }
}
