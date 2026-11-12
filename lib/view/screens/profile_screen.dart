import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projict_3_todo/core/app_dialog.dart';
import 'package:projict_3_todo/core/app_routes.dart';
import 'package:projict_3_todo/data/model/user_model.dart';
import 'package:projict_3_todo/view/widgets/custom_material_button.dart';
import 'package:projict_3_todo/view/widgets/custom_text_form_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var fullName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF5F7FB),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: 100),
            Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Color(0xffE8ECF5),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Icon(Icons.person, size: 100, color: Color(0xff3F51B5)),
            ),
            SizedBox(height: 20),
            Text(
              "create Your Profile",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            CustomTextFormField(
              lable: "Full Name",
              hint: "Enter your name",
              controller: fullName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter your name";
                }
                return null;
              },
            ),
            SizedBox(height: 50),
            CustomMaterialButton(
              text: "Create",
              onPressed: () async {
                AppDialog.showLoading(context);
                var userBox = Hive.box<UserModel>('user');

                await userBox
                    .put("UserKey", UserModel(fullName: fullName.text))
                    .then((value) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(AppRoutes.home);
                    })
                    .catchError((error) {
                      Navigator.of(context).pop();
                      AppDialog.showError(context, error);
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
