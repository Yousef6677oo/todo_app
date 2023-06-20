import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/model/todo_dm.dart';
import 'package:todo/utilities/app_color.dart';

class TodoWidget extends StatefulWidget {
  TodoDM todo;

  TodoWidget({required this.todo});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  List<int> listItem = [
    0,
    1,
    2,
    3,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      ///
      child: Dismissible(
        movementDuration: const Duration(milliseconds: 500),
        resizeDuration: const Duration(milliseconds: 500),
        background: Container(
          decoration: BoxDecoration(
              color: AppColor.red, borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageIcon(
                  const AssetImage("assets/icon_delete.png"),
                  color: AppColor.white,
                  size: 45,
                ),
                Text(
                  AppLocalizations.of(context)!.delete,
                  style: TextStyle(fontSize: 14, color: AppColor.white),
                )
              ],
            ),
          ),
        ),
        key: Key("${listItem.length}"),
        onDismissed: (direction) {
          setState(() {
            listItem.removeAt(0);
          });
        },
        ///
        child: Container(
          decoration: BoxDecoration(
              color: AppColor.white, borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Container(
                  height: 65,
                  width: 4,
                  color: widget.todo.isDone
                      ? AppColor.green
                      : AppColor.primaryColor,
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
                      "${widget.todo.time.day}/${widget.todo.time.month}/${widget.todo.time.year}")
                ],
              ),
              Container(
                  decoration: BoxDecoration(
                      color: widget.todo.isDone
                          ? Colors.transparent
                          : AppColor.primaryColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 1, horizontal: 15),
                    child: ImageIcon(
                      AssetImage(widget.todo.isDone
                          ? "assets/done_list.png"
                          : "assets/icon_check.png"),
                      size: 40,
                      color:
                          widget.todo.isDone ? AppColor.green : AppColor.white,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
