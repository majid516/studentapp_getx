import 'dart:developer';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app_getx/infrastucture/model/student_model.dart';

class StudentDataContoller extends GetxController {
  final RxList<StudentModel> studentListObs = <StudentModel>[].obs;
  RxList<StudentModel> filterdStudentList = <StudentModel>[].obs;

  Future<void> fechAllData() async {
    await getAllStudent();
  }

  Future<void> getAllStudent() async {
    final studentDB = await Hive.openBox<StudentModel>('Student_db');
    studentListObs.clear();
    studentListObs.addAll(studentDB.values);
    filterdStudentList.assignAll(studentListObs);
  }

  Future<void> filterStudents(String query) async {
    if (query.isEmpty) {
      filterdStudentList.assignAll(studentListObs);
    } else {
      filterdStudentList.assignAll(studentListObs
          .where((student) =>
              student.name.toLowerCase().contains(query.toLowerCase()))
          .toList());
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fechAllData();
    filterdStudentList.assignAll(studentListObs);
  }
}
