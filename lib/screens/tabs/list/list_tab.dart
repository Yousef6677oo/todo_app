import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/provider/settings_provider.dart';
import 'package:todo/screens/tabs/todo/todo_widget.dart';
import 'package:todo/utilities/app_color.dart';

class ListTab extends StatefulWidget {
  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  @override
  Widget build(BuildContext context) {
    SettingsProvider provider = Provider.of(context);
    provider.refreshTodosFromFirestore();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          color: AppColors.primaryColorLight,
          child: CalendarTimeline(
            initialDate: provider.selectedDate,
            firstDate: DateTime.now().subtract(const Duration(days: 365)),
            lastDate: DateTime.now().add(const Duration(days: 365)),
            onDateSelected: (date) {
              provider.selectedDate = date;
            },
            leftMargin: 0,
            monthColor: AppColors.white,
            dayColor: AppColors.white,
            activeDayColor: AppColors.primaryColorLight,
            activeBackgroundDayColor: provider.currentTheme == ThemeMode.light
                ? AppColors.white
                : AppColors.accentColorDark,
            dotsColor: Colors.transparent,
            locale: 'en_ISO',
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: provider.todosList.length,
              itemBuilder: (_, index) => TodoWidget(
                    todo: provider.todosList[index],
                    index: index,
                  )),
        )
      ],
    );
  }
}
