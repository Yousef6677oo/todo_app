import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo/model/todo_dm.dart';
import 'package:todo/utilities/app_color.dart';

import '../../../model/edit_task_dm.dart';
import '../../../provider/settings_provider.dart';
import '../../edit_task_screen/edit_task_screen.dart';

class TodoWidget extends StatefulWidget {
  TodoDM todo;
  int index;

  TodoWidget({super.key, required this.todo, required this.index});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    SettingsProvider provider = Provider.of(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, SettingsScreen.routeName,
            arguments:
                EditTaskDM(id: widget.todo.id, selectedDay: widget.todo.time));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        child: Dismissible(
          movementDuration: const Duration(milliseconds: 500),
          resizeDuration: const Duration(milliseconds: 500),
          background: Container(
            decoration: BoxDecoration(
                color: AppColors.red, borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageIcon(
                    const AssetImage("assets/icon_delete.png"),
                    color: AppColors.white,
                    size: 45,
                  ),
                  Text(
                    AppLocalizations.of(context)!.delete,
                    style: TextStyle(fontSize: 14, color: AppColors.white),
                  )
                ],
              ),
            ),
          ),
          key: Key(widget.todo.id),
          onDismissed: (direction) {
            provider.todosList.removeAt(widget.index);
            provider.deleteTodosFromFirestore(widget.todo.id);
          },
          child: Container(
            decoration: BoxDecoration(
                color: provider.currentTheme == ThemeMode.light
                    ? AppColors.canvasColorLight
                    : AppColors.canvasColorDark,
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30.0),
                  child: Container(
                    height: 65,
                    width: 4,
                    color: widget.todo.isDone
                        ? AppColors.green
                        : AppColors.primaryColorLight,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.todo.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${widget.todo.time.day}/${widget.todo.time.month}/${widget.todo.time.year}",
                      style: Theme.of(context).textTheme.titleSmall,
                    )
                  ],
                ),
                Container(
                    decoration: BoxDecoration(
                        color: widget.todo.isDone
                            ? Colors.transparent
                            : AppColors.primaryColorLight,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1, horizontal: 15),
                      child: ImageIcon(
                        AssetImage(widget.todo.isDone
                            ? "assets/done_list.png"
                            : "assets/icon_check.png"),
                        size: 40,
                        color: widget.todo.isDone
                            ? AppColors.green
                            : AppColors.white,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
