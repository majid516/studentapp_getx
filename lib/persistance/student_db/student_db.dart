import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app_getx/application/main_screen/student_data_contoller.dart';
import 'package:student_app_getx/infrastucture/model/student_model.dart';

final listController = Get.put(StudentDataContoller());

class StudentDbController extends GetxController {
  Future<void> deleteStudent(String id) async {
    final studentDB = await Hive.openBox<StudentModel>('Student_db');
    await studentDB.delete(id);
    await getAllStudents();
    update();
  }

  Future<void> getAllStudents() async {
    final studentDB = await Hive.openBox<StudentModel>('Student_db');
    listController.studentListObs.clear();
    listController.studentListObs.addAll(studentDB.values);
    listController.filterdStudentList.assignAll(listController.studentListObs);
    update();
  }

  Future<void> updateStudentData(StudentModel studentData) async {
    try {
      final studentDB = await Hive.box<StudentModel>('Student_db');
      await studentDB.put(studentData.id!, studentData);
      await getAllStudents();
    } catch (e) {
      //  print('Error updating student: $e');
      throw Exception('Failed to update student data: $e');
    }
  }

  Future<void> addNewStudent(StudentModel student) async {
    try {
      final id = DateTime.now().toIso8601String();
      student.id = id;
      final studentDB = await Hive.openBox<StudentModel>('Student_db');
      studentDB.put(id, student);
    } catch (e) {
      // log('error found while adding ' + e.toString());
    }
    getAllStudents();
  }
}
