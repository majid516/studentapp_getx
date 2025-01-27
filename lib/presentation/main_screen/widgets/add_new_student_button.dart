import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:student_app_getx/core/constant_colors/colors.dart';
import 'package:student_app_getx/presentation/add_student/add_student_screen.dart';

class AddNewStudentButton extends StatelessWidget {
  const AddNewStudentButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 40,
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                    builder: (ctx) => AddNewStudent(
                      isAdd: true,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: appThemeColor),
              child: const Wrap(
                children: [
                  Icon(
                    Icons.add,
                    color: whiteColor,
                  ),
                  Text(
                    'add student',
                    style: TextStyle(color: whiteColor),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
