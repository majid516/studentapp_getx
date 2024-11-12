import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:student_app_getx/application/main_screen/id_controller.dart';
import 'package:student_app_getx/application/main_screen/student_data_contoller.dart';
import 'package:student_app_getx/core/constant_colors/colors.dart';
import 'package:student_app_getx/core/constats/constants.dart';

class UserCredentialList extends StatelessWidget {
  const UserCredentialList({
    super.key,
    required this.studentListController,
    required this.index,
    required this.idController,
  });

  final StudentDataContoller studentListController;
  final int index;
  final IdController idController;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: const BoxDecoration(
                color: appThemeColor,
              ),
            ),
            Positioned(
                bottom: -90,
                child: Obx(
                  () => CircleAvatar(
                    radius: 88,
                    backgroundColor: whiteColor,
                    child: CircleAvatar(
                        radius: 80,
                        backgroundImage: FileImage(File(studentListController
                            .studentListObs[index].image))),
                  ),
                )),
            const Positioned(
              left: 35,
              top: 80,
              child: Text('Details', style: headingStyle),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.1,
            horizontal: 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Obx(() => Text(
                  'Name : ${studentListController.studentListObs[index].name}',
                  style: normalTextStyle1,
                  overflow: TextOverflow.clip)),
              Obx(() => Text(
                  'Age : ${studentListController.studentListObs[index].age}',
                  style: normalTextStyle1,
                  overflow: TextOverflow.clip)),
              Obx(() => Text(
                  'Phone : ${studentListController.studentListObs[index].phone}',
                  style: normalTextStyle1,
                  overflow: TextOverflow.clip)),
              Obx(() => Text(
                  'Guardian : ${studentListController.studentListObs[index].guardian}',
                  style: normalTextStyle1,
                  overflow: TextOverflow.clip)),
              const SizedBox(
                height: 10,
              ),
              Obx(() => Visibility(
                  visible: idController.isVisible.value,
                  child: Text(
                    'ID : ${studentListController.studentListObs[index].id}',
                    style: normalTextStyle1,
                    overflow: TextOverflow.clip,
                  ))),
            ],
          ),
        ),
      ],
    );
  }
}
