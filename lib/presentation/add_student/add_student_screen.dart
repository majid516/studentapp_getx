import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:student_app_getx/application/main_screen/profile_contoller.dart';
import 'package:student_app_getx/core/constant_colors/colors.dart';
import 'package:student_app_getx/core/constats/constants.dart';
import 'package:student_app_getx/infrastucture/model/student_model.dart';
import 'package:student_app_getx/persistance/student_db/student_db.dart';
import 'package:student_app_getx/presentation/add_student/widget/text_fields.dart';

class AddNewStudent extends StatelessWidget {
  AddNewStudent({
    super.key,
    required this.isAdd,
    this.id,
    this.student,
  });

  final bool isAdd;
  final String? id;
  final StudentModel? student;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController guardianController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final profileController = Get.put(ProfileController());
  final dbController = Get.put(StudentDbController());

  @override
  Widget build(BuildContext context) {
    if (!isAdd) {
      nameController.text = student?.name ?? '';
      ageController.text = student?.age ?? '';
      phoneController.text = student?.phone ?? '';
      guardianController.text = student?.guardian ?? '';
      profileController.profileImage.value = student?.image ?? 'default_path';
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: Text(
          isAdd ? 'Add Student' : 'Update Student',
          style: headingStyle,
        ),
        backgroundColor: appThemeColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      backgroundColor: whiteColor,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        profileController.pickImageFormGallery();
                      },
                      child: Obx(() {
                        return CircleAvatar(
                          radius: 60,
                          backgroundImage: profileController
                                      .profileImage.value !=
                                  'default_path'
                              ? FileImage(
                                  File(profileController.profileImage.value))
                              : const NetworkImage(
                                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0VykKbAbaa7tNQ143EKaeGO22WXPDSXQLaQ&s'),
                        );
                      }),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Icon(
                        Icons.add_a_photo_outlined,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
              buildTextField(
                  nameController, 'Student Name', 'name is required'),
              buildTextField(ageController, 'Student Age', 'age is required'),
              buildTextField(phoneController, 'Phone', 'phone is required'),
              buildTextField(guardianController, 'Guardian Name',
                  'guardian name is required'),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25.0, vertical: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final studentData = StudentModel(
                            id: isAdd ? null : id,
                            name: nameController.text,
                            age: ageController.text,
                            phone: phoneController.text,
                            guardian: guardianController.text,
                            image: profileController.profileImage.value,
                          );

                          if (isAdd) {
                            await dbController.addNewStudent(studentData);
                            profileController.disposeImage();
                          } else {
                            await dbController.updateStudentData(studentData);
                            profileController.disposeImage();
                          }

                          profileController.profileImage.value = 'default_path';
                          Navigator.pop(context);
                        } else {
                          //  print('Form data is invalid');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: appThemeColor),
                      child: const Wrap(
                        children: [
                          Text(
                            'Submit',
                            style: TextStyle(color: whiteColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
