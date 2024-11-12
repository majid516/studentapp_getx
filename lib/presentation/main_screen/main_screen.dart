import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:student_app_getx/application/main_screen/icon_controller.dart';
import 'package:student_app_getx/application/main_screen/search_icon_contoller.dart';
import 'package:student_app_getx/application/main_screen/student_data_contoller.dart';
import 'package:student_app_getx/core/constant_colors/colors.dart';
import 'package:student_app_getx/core/constats/constants.dart';
import 'package:student_app_getx/persistance/student_db/student_db.dart';
import 'package:student_app_getx/presentation/main_screen/widgets/add_new_student_button.dart';
import 'package:student_app_getx/presentation/main_screen/widgets/student_grid_view.dart';
import 'package:student_app_getx/presentation/main_screen/widgets/student_list_view.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final iconController = Get.put(IconController());
  final studentListController = Get.put(StudentDataContoller());
  final searchIconController = Get.put(SearchIconContoller());
  final dbController = Get.put(StudentDbController());

  @override
  Widget build(BuildContext context) {
    log(studentListController.filterdStudentList.length);
    studentListController.fechAllData();
    return RefreshIndicator(
      onRefresh: () => studentListController.fechAllData(),
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            title: const Text(
              'Student App Get X',
              style: headingStyle,
            ),
            centerTitle: false,
            actions: [
              IconButton(
                  onPressed: () {
                    searchIconController.changeVisibitity();
                  },
                  icon: const Icon(
                    Icons.search,
                    color: whiteColor,
                  )),
              IconButton(
                onPressed: () {
                  iconController.changeIcon();
                },
                icon: Icon(iconController.isList.value
                    ? Icons.grid_view_outlined
                    : Icons.list),
                color: whiteColor,
              )
            ],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            backgroundColor: appThemeColor,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(
                  () => Visibility(
                      visible: searchIconController.isVisible.value,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: SearchBar(
                          onChanged: (value) {
                            studentListController.filterStudents(value);
                          },
                          backgroundColor:
                              const WidgetStatePropertyAll(whiteColor),
                          leading: const Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                        ),
                      )),
                ),
                Obx(
                  () {
                    return Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          studentListController.filterdStudentList.isNotEmpty
                              ? iconController.isList.value
                                  ? StudentListview(
                                      studentListController:
                                          studentListController,
                                      dbController: dbController)
                                  : StudentGridview(
                                     dbController: dbController,
                                      studentListController:
                                          studentListController)
                              : const Center(
                                  child: Text(
                                  'No Student Found',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.grey),
                                )),
                          const AddNewStudentButton()
                        ],
                      ),
                    );
                  },
                )
              ],
            ),
          ),
          backgroundColor: backgroundThemeColor,
        ),
      ),
    );
  }
}
