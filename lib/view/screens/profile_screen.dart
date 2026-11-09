import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projict_3_todo/core/app_routes.dart';
import 'package:projict_3_todo/data/model/user_model.dart';

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
              style: TextStyle(fontSize: 20, fontWeight: .bold),
            ),
            SizedBox(height: 20),

            CustomTextFormField(
              lable: "Full Name",
              controller: fullName,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter your name";
                }
                return null;
              },
            ),
            SizedBox(height: 50),
            MaterialButton(
              onPressed: () async {
                _showLoading();
                var userBox = Hive.box<UserModel>('user');
                await userBox
                    .put("UserKey", UserModel(fullName: fullName.text))
                    .then((value) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushNamed(AppRoutes.home);
                    })
                    .catchError((error) {
                      Navigator.of(context).pop();
                      _showError(error);
                    });
              },
              color: Color(0xff3F51B5),
              padding: EdgeInsets.all(10),
              minWidth: 300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
              child: Text(
                "Create",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showLoading() async {
    return showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            spacing: 20,
            children: [
              CircularProgressIndicator(),
              Text(
                "Loding...",
                style: TextStyle(fontSize: 16, fontWeight: .w400),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showError(String error) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Error',
            style: TextStyle(
              fontSize: 20,
              fontWeight: .bold,
              color: Colors.red,
            ),
          ),
          content: Text(
            error,
            style: TextStyle(fontSize: 16, fontWeight: .bold),
          ),
          actions: [
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.validator,
    required this.lable,
  });

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String lable;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(lable, style: TextStyle(fontSize: 16, fontWeight: .bold)),
        SizedBox(height: 5),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hint: Text("Enter your name", style: TextStyle(color: Colors.grey)),
            fillColor: Color(0xffFFFFFF),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blue),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.red),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }
}
