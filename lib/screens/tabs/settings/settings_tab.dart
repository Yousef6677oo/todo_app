import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/utilities/app_color.dart';
import '../../../provider/settings_provider.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  late SettingsProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                AppLocalizations.of(context)!.language,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: provider.currentTheme == ThemeMode.light
                        ? AppColors.black
                        : AppColors.white),
              ),
            ),
            InkWell(
                onTap: () {
                  onLanguageRowClicked();
                },
                child: getRowOption(
                    provider.currentLocal == "en" ? "English" : "العربية")),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                AppLocalizations.of(context)!.mode,
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: provider.currentTheme == ThemeMode.light
                        ? AppColors.black
                        : AppColors.white),
              ),
            ),
            InkWell(
                onTap: () {
                  onThemeRowClicked();
                },
                child: getRowOption(provider.currentTheme == ThemeMode.dark
                    ? AppLocalizations.of(context)!.dark
                    : AppLocalizations.of(context)!.light)),
          ],
        ),
      ),
    );
  }

  Widget getRowOption(String selectionOption) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 2, color: AppColors.primaryColorLight)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(selectionOption,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(color: const Color(0xff5D9CEC))),
          const Icon(Icons.arrow_drop_down)
        ],
      ),
    );
  }

  void onLanguageRowClicked() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalizations.of(context)!.change_current_language,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20, color: AppColors.primaryColorLight),
                  ),
                  const SizedBox(height: 22),
                  InkWell(
                      onTap: () {
                        provider.changeCurrentLocal(languageSelected: "en");
                        Navigator.pop(context);
                      },
                      child: getLanguageRow(
                          provider.currentLocal == "en", "English")),
                  const SizedBox(height: 16),
                  InkWell(
                      onTap: () {
                        provider.changeCurrentLocal(languageSelected: "ar");
                        Navigator.pop(context);
                      },
                      child: getLanguageRow(
                          provider.currentLocal == "ar", "العربية"))
                ],
              ),
            ));
  }

  void onThemeRowClicked() {
    showModalBottomSheet(
        context: context,
        builder: (context) => Container(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalizations.of(context)!.change_current_theme,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20, color: AppColors.primaryColorLight),
                  ),
                  const SizedBox(height: 22),
                  InkWell(
                      onTap: () {
                        provider.changeCurrentTheme(newTheme: ThemeMode.light);
                        Navigator.pop(context);
                      },
                      child: getThemeRow(
                          provider.currentTheme == ThemeMode.light,
                          AppLocalizations.of(context)!.light)),
                  const SizedBox(height: 16),
                  InkWell(
                      onTap: () {
                        provider.changeCurrentTheme(newTheme: ThemeMode.dark);
                        Navigator.pop(context);
                      },
                      child: getThemeRow(
                          provider.currentTheme == ThemeMode.dark,
                          AppLocalizations.of(context)!.dark))
                ],
              ),
            ));
  }
}

Widget getLanguageRow(bool isSelected, String language) {
  if (isSelected) {
    return Text(
      language,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 14, color: AppColors.primaryColorLight),
    );
  } else {
    return Text(
      language,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 14, color: AppColors.black),
    );
  }
}

Widget getThemeRow(bool isSelected, String language) {
  if (isSelected) {
    return Text(
      language,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 14, color: AppColors.primaryColorLight),
    );
  } else {
    return Text(
      language,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 14, color: AppColors.black),
    );
  }
}
