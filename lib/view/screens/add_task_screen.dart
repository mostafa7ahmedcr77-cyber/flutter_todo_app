import 'dart:developer';

import 'package:hive_flutter/hive_flutter.dart';

import '../../data/model/task_model.dart';

import 'package:flutter/material.dart';
import 'package:projict_3_todo/view/widgets/choose_color_widget.dart';
import 'package:projict_3_todo/view/widgets/custom_material_button.dart';
import 'package:projict_3_todo/view/widgets/custom_text_form_field.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String dropdownButtonValue = "pending";
  var titleTask = TextEditingController();
  var desTask = TextEditingController();
  int colorSelected = 4283215696;

  get AppDialog => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FB),
      appBar: AppBar(
        title: const Text(
          "Add Task",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            CustomTextFormField(
              lable: "Title Task",
              hint: "Enter task title",
              controller: titleTask,
            ),
            CustomTextFormField(
              lable: "Description",
              hint: "Enter task description",
              maxLines: 4,
              controller: desTask,
            ),
            const Text(
              "Status",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            DropdownButton(
              value: dropdownButtonValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              items: [
                DropdownMenuItem(
                  value: "pending",
                  child: Text(
                    "pending",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
                DropdownMenuItem(
                  value: "Done",
                  child: Text(
                    "Done",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  dropdownButtonValue = value ?? "pending";
                });
              },
            ),
            ChooseColorWidget(
              clickColor: (color) {
                log(color.toString());
                colorSelected = color;
              },
            ),
            CustomMaterialButton(
              onPressed: () async {
                // log("Title: ${titleTask.text}");
                // log("Des: ${desTask.text}");
                // log("Status: $dropdownButtonValue");
                // log("Color: $colorSelected");
                AppDialog.showLoading(context);
                var taskBox = Hive.box<TaskModel>('Tasks');
                await taskBox
                    .add(
                      TaskModel(
                        title: titleTask.text,
                        description: desTask.text,
                        status: dropdownButtonValue == "Pending"
                            ? .pending
                            : .done,
                        colorHex: colorSelected,
                      ),
                    )
                    .then((value) {
                      Navigator.of(context).pop();
                      titleTask.clear();
                      desTask.clear();
                      colorSelected = 4283215696;
                    })
                    .catchError((error) {
                      Navigator.of(context).pop();
                      AppDialog.showError(context, error);
                    });
              },
              text: "Save",
            ),
          ],
        ),
      ),
    );
  }
}
