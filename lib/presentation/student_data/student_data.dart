import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app_getx/application/main_screen/id_controller.dart';
import 'package:student_app_getx/application/main_screen/student_data_contoller.dart';
import 'package:student_app_getx/core/constant_colors/colors.dart';
import 'package:student_app_getx/presentation/student_data/widgets/show_id_button.dart';
import 'package:student_app_getx/presentation/student_data/widgets/student_credentials.dart';
import 'package:student_app_getx/presentation/student_data/widgets/update_button.dart';

class StudentData extends StatelessWidget {
  StudentData({
    super.key,
    required this.name,
    required this.age,
    required this.phone,
    required this.guardian,
    required this.image,
    required this.id,
    required this.index,
  });

  final String name;
  final String age;
  final String phone;
  final String guardian;
  final String image;
  final String id;
  final int index;
  final studentListController = Get.put(StudentDataContoller());
  final idController = Get.put(IdController());

  @override
  Widget build(BuildContext context) {
    studentListController.fechAllData();

    return Scaffold(
      backgroundColor: whiteColor,
      body: RefreshIndicator(
        onRefresh: studentListController.fechAllData,
        child: Stack(
          children: [
            UserCredentialList(
                studentListController: studentListController,
                index: index,
                idController: idController),
            ShowUserIdButton(idController: idController),
            UpdateButton(
                id: id,
                name: name,
                age: age,
                phone: phone,
                guardian: guardian,
                image: image)
          ],
        ),
      ),
    );
  }
}
