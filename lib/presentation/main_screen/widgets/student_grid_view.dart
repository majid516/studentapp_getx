import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_app_getx/application/main_screen/student_data_contoller.dart';

import 'package:student_app_getx/core/constant_colors/colors.dart';
import 'package:student_app_getx/core/constats/constants.dart';
import 'package:student_app_getx/persistance/student_db/student_db.dart';
import 'package:student_app_getx/presentation/student_data/student_data.dart';

class StudentGridview extends StatelessWidget {
  const StudentGridview({
    super.key,
    required this.studentListController, required this.dbController,
  });

  final StudentDataContoller studentListController;
   final StudentDbController dbController;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
          itemBuilder: (ctx, index) {
            final data = studentListController.filterdStudentList[index];
            return InkWell(
              onLongPress: () {
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
              child: GridTile(
                child: Container(
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 1,
                          color: const Color.fromARGB(134, 158, 158, 158))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: FileImage(File(data.image)),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          data.name,
                          style: normalTextStyle2,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          itemCount: studentListController.filterdStudentList.length,
        ));
  }
}
