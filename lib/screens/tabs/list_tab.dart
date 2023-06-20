import 'package:flutter/material.dart';
import 'package:todo/model/todo_dm.dart';
import 'package:todo/screens/tabs/todo_widget.dart';

class ListTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (_, index) => TodoWidget(
            todo: TodoDM(
                title: 'Play basket ball',
                details: '',
                isDone: false,
                time: DateTime.now())));
  }
}
