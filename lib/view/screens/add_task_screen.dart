import 'dart:developer';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F7FB),
      appBar: AppBar(
        title: Text(
          "Add Task",
          style: TextStyle(fontSize: 25, fontWeight: .bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: .start,
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
            Text("Status", style: TextStyle(fontSize: 16, fontWeight: .bold)),
            DropdownButton(
              value: dropdownButtonValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              items: [
                DropdownMenuItem(
                  value: "pending",
                  child: Text(
                    "pending",
                    style: TextStyle(fontSize: 16, fontWeight: .w500),
                  ),
                ),
                DropdownMenuItem(
                  value: "Done",
                  child: Text(
                    "pending",
                    style: TextStyle(fontSize: 16, fontWeight: .w500),
                  ),
                ),
              ],
              onChanged: (value) {
                dropdownButtonValue = value ?? "Pending";
                setState(() {});
              },
            ),

            ChooseColorWidget(
              clickColor: (color) {
                log(color.toString());
                colorSelected = color;
              },
            ),

            CustomMaterialButton(
              onPressed: () {
                log("Title: ${titleTask.text}");
                log("Des: ${desTask.text}");
                log("Status ${dropdownButtonValue}");
                log("Color; $colorSelected");
              },
              text: "Save",
            ),
          ],
        ),
      ),
    );
  }
}
