import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo/utilities/app_color.dart';
import '../../model/edit_task_dm.dart';
import '../../model/user_dm.dart';

class SettingsScreen extends StatefulWidget {
  static String routeName = "Settings Screen";

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late String id;
  late DateTime selectedDay;
  TextEditingController editTitleController = TextEditingController();
  TextEditingController editDetailsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    EditTaskDM args = ModalRoute.of(context)?.settings.arguments as EditTaskDM;
    id = args.id;
    selectedDay = args.selectedDay;
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.25,
          title: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
                vertical: MediaQuery.of(context).size.height * 0.03),
            child: Text(AppLocalizations.of(context)!.to_do_list),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(27),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Text(AppLocalizations.of(context)!.edit_task,
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          TextField(
                            controller: editTitleController,
                            decoration: InputDecoration(
                                hintText:
                                    AppLocalizations.of(context)!.this_is_title,
                                hintStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          TextField(
                            controller: editDetailsController,
                            decoration: InputDecoration(
                                hintText:
                                    AppLocalizations.of(context)!.task_details,
                                hintStyle: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.black)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Text(AppLocalizations.of(context)!.select_time,
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.start),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          InkWell(
                            onTap: () {
                              showMyDataPicker();
                            },
                            child: Text(
                                "${selectedDay.day}/${selectedDay.month}/${selectedDay.year}",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: AppColors.hintColor,
                                    )),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: const StadiumBorder(),
                                  backgroundColor: AppColors.primaryColorLight),
                              onPressed: () async {
                                await onSaveChangesPressed();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  AppLocalizations.of(context)!.save_changes,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(color: AppColors.white),
                                ),
                              ))
                        ]),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void showMyDataPicker() async {
    selectedDay = (await showDatePicker(
            context: context,
            initialDate: selectedDay,
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(const Duration(days: 365))) ??
        selectedDay);
    setState(() {});
  }

  Future onSaveChangesPressed() async {
    CollectionReference todos = FirebaseFirestore.instance
        .collection('users')
        .doc(UserDM.currentUser!.id)
        .collection("todos");
    DocumentReference doc = todos.doc(id);
    return doc.update({
      "title": editTitleController.text,
      "details": editDetailsController.text,
      "dateTime": selectedDay.millisecondsSinceEpoch
    }).then((value) => Navigator.pop(context));
  }
}
