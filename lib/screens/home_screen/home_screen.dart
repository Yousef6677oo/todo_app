import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/utilities/app_color.dart';

import '../../provider/settings_provider.dart';
import '../tabs/list/list_tab.dart';
import '../tabs/settings/settings_tab.dart';
import 'add_bottom_sheet/add_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "Home Screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTab = 0;
  List<Widget> tabs = [ListTab(), SettingsTab()];

  @override
  Widget build(BuildContext context) {
    SettingsProvider provider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: currentTab == 0
            ? MediaQuery.of(context).size.height * 0.12
            : MediaQuery.of(context).size.height * 0.25,
        title: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
              vertical: MediaQuery.of(context).size.height * 0.02),
          child: Text(
            currentTab == 0
                ? AppLocalizations.of(context)!.to_do_list
                : AppLocalizations.of(context)!.settings,
          ),
        ),
      ),
      body: tabs[currentTab],
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColorLight,
          onPressed: () {
            if (currentTab == 0) {
              addNewTask();
            }
          },
          shape: RoundedRectangleBorder(
              side: BorderSide(
                  width: 4,
                  color: provider.currentTheme == ThemeMode.light
                      ? AppColors.white
                      : AppColors.black),
              borderRadius: BorderRadius.circular(100)),
          child: currentTab == 0
              ? const ImageIcon(AssetImage("assets/icon_add.png"))
              : const ImageIcon(AssetImage("assets/icon_checked.png"))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        clipBehavior: Clip.hardEdge,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              currentTab = index;
            });
          },
          currentIndex: currentTab,
          iconSize: 35,
          items: const [
            BottomNavigationBarItem(
                label: "List",
                icon: ImageIcon(AssetImage("assets/icon_list.png"))),
            BottomNavigationBarItem(
                label: "Settings",
                icon: ImageIcon(AssetImage("assets/icon_settings.png"))),
          ],
        ),
      ),
    );
  }

  void addNewTask() {
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        context: context,
        builder: (context) {
          return AddBottomSheet();
        });
  }
}
