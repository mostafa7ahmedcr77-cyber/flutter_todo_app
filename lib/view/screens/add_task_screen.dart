import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/model/task_model.dart';

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
  final titleTask = TextEditingController();
  final desTask = TextEditingController();
  int colorSelected = 4283215696;

  @override
  void dispose() {
    titleTask.dispose();
    desTask.dispose();
    super.dispose();
  }

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
            DropdownButton<String>(
              value: dropdownButtonValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              items: const [
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
                setState(() {
                  colorSelected = color;
                });
              },
            ),
            CustomMaterialButton(onPressed: _saveTask, text: "Save"),
          ],
        ),
      ),
    );
  }

  Future<void> _saveTask() async {
    if (titleTask.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please enter task title")));
      return;
    }

    final navigator = Navigator.of(context);

    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        return const AlertDialog(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Loading..."),
            ],
          ),
        );
      },
    );

    try {
      final taskBox = Hive.box<TaskModel>('Tasks');

      await taskBox.add(
        TaskModel(
          title: titleTask.text.trim(),
          description: desTask.text.trim(),
          status: dropdownButtonValue == "pending"
              ? StatusTask.pending
              : StatusTask.done,
          colorHex: colorSelected,
        ),
      );

      if (!mounted) return;

      navigator.pop(); // Close Loading Dialog
      navigator.pop(); // Return to HomeScreen
    } catch (error) {
      if (!mounted) return;

      navigator.pop(); // Close Loading Dialog

      showDialog<void>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text("Error"),
            content: Text(error.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
}
