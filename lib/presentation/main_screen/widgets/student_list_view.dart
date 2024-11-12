import 'dart:io';

import 'package:student_app_getx/application/main_screen/student_data_contoller.dart';
import 'package:student_app_getx/core/constats/constants.dart';
import 'package:student_app_getx/persistance/student_db/student_db.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:student_app_getx/core/constant_colors/colors.dart';
import 'package:student_app_getx/presentation/student_data/student_data.dart';

class StudentListview extends StatelessWidget {
  const StudentListview({
    super.key,
    required this.studentListController,
    required this.dbController,
  });

  final StudentDataContoller studentListController;
  final StudentDbController dbController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (ctx, index) {
          final data = studentListController.filterdStudentList[index];
          return InkWell(
            onTap: () => Navigator.of(context).push(CupertinoPageRoute(
                builder: (ctx) => StudentData(
                      id: data.id!,
                      name: data.name,
                      age: data.age,
                      phone: data.phone,
                      guardian: data.guardian,
                      image: data.image,
                      index: index,
                    ))),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minTileHeight: 80,
                tileColor: whiteColor,
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: FileImage(File(data.image)),
                ),
                title: Text(
                  data.name,
                  style: normalTextStyle2,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              title: const Text('delete'),
                              content:
                                  Text('Are you sure to delete ${data.name}'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('cancel')),
                                TextButton(
                                    onPressed: () {
                                      dbController.deleteStudent(
                                          studentListController
                                              .studentListObs[index].id!);
                                      Navigator.pop(context);
                                    },
                                    child: const Text('delete')),
                              ],
                            );
                          });
                    },
                    icon: const Icon(Icons.delete)),
              ),
            ),
          );
        },
        itemCount: studentListController.filterdStudentList.length);
  }
}
