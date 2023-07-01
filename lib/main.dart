import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/provider/settings_provider.dart';
import 'package:todo/screens/edit_task_screen/edit_task_screen.dart';
import 'package:todo/screens/home_screen/home_screen.dart';
import 'package:todo/screens/login_screen/login_screen.dart';
import 'package:todo/screens/register_screen/register_screen.dart';
import 'package:todo/utilities/app_theme.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (_) => SettingsProvider(
          currentLocal: prefs.getString("isLanguageEnglish") ?? "en",
          isDarkMode: prefs.getBool("isDarkMode") ?? false,
          currentTheme: prefs.getBool("isDarkMode") ?? false
              ? ThemeMode.dark
              : ThemeMode.light),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SettingsProvider providerSettings = Provider.of(context);
    return Theme(
      data: ThemeData.light(),
      child: MaterialApp(
        themeMode: providerSettings.currentTheme,
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
          Locale("en"),
          Locale("ar"), // English
        ],
        locale: Locale(providerSettings.currentLocal),
        title: 'To Do',
        debugShowCheckedModeBanner: false,
        routes: {
          HomeScreen.routeName: (_) => HomeScreen(),
          SettingsScreen.routeName: (_) => SettingsScreen(),
          LoginScreen.routeName: (_) => LoginScreen(),
          RegisterScreen.routeName: (_) => RegisterScreen()
        },
        initialRoute: LoginScreen.routeName,
      ),
    );
  }
}
