import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../utilities/app_color.dart';

class AddBottomSheet extends StatefulWidget {
  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  TextEditingController taskController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  DateTime selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.45,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                AppLocalizations.of(context)!.add_new_task,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.black,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: taskController,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.enter_your_task,
                    labelStyle: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: AppColors.hintColor)),
              ),
              TextField(
                controller: detailsController,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.enter_your_details,
                    labelStyle: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: AppColors.hintColor)),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(AppLocalizations.of(context)!.select_time,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.black,
                      )),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  showMyDataPicker();
                },
                child: Text(
                    "${selectedDay.day}/${selectedDay.month}/${selectedDay.year}",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.hintColor,
                        )),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColorLight),
                  onPressed: () {
                    onAddPressed();
                  },
                  child: const Text("Add"))
            ],
          ),
        ),
      ),
    );
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

  void onAddPressed() {}
}
